//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMPaymentMV : NSObject{
    var model : OrderData?

    var days = ""
    private var hostVC : LMPaymentFinalVC
    init(hostController : LMPaymentFinalVC) {
        self.hostVC = hostController
    }
    // MARK: validate value
   
    func validateValue1(Pincode:Int,weight:Float,height:Double,breadth:Double,length:Double){
        guard hostVC.checkInternet else {
            return
        }
            GlobalLoader.shared.show()
        


        let bodyRequest = deliveryPincodeReq12(deliveryPincode: Pincode, weight: 0.5, height: 2.0, breadth: 30.0, length: 30.0)
        
            THApiHandler.post(requestBody: bodyRequest, responseType: DeliveryEstimateResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
                GlobalLoader.shared.hide()
                if let status = dataResponse?.success {
                    let mod = dataResponse?.data
                    self?.hostVC.dismiss(animated: true) {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let currentDateString = formatter.string(from: Date())

                        THUserDefaultValue.userdateCurrentDate = currentDateString
                        
                        self?.days = mod?.estimatedDeliveryDays ?? ""
                       let dateprivois = mod?.expectedDeliveryDate ?? ""
                        let dateShow = self?.addThreeDays(to: mod?.expectedDeliveryDate ?? "", StrEstimate: dateprivois)
                       
                    }
                   // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
                } else {
                    
                    //self?.hostVC.infoLabel.text = "Pincode is not serviceable"
                }
            }
        
        
    }
    func addThreeDays(to inputDateString: String,StrEstimate:String) -> String {
        let formatter = DateFormatter()
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.locale = Locale(identifier: "en_IN") // ✅ Indian locale

        formatter.dateFormat = "MMM dd, yyyy"  // Matches: "Jun 20, 2025"

        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MMM dd, yyyy"
        let currentDateString = formatter1.string(from: Date())
        
     
        let StrEstimate1 = StrEstimate.components(separatedBy: ",").first ?? ""

        
        guard let date = formatter.date(from: currentDateString) else {
            print("❌ Invalid input date string: \(inputDateString)")
            return ""
        }

        if let savedDays = Int(self.days) {
            
            if savedDays == 5 {
                self.hostVC.lbl24.text = "Pay ₹\(self.hostVC.amountpaymentFinal) now to get it by \(savedDays - 1) days, \(StrEstimate1)"
                if let newDate = Calendar.current.date(byAdding: .day, value: (savedDays - 1), to: date) {
                    return formatter.string(from: newDate)
                }
            } else if savedDays > 5 {
                
                self.hostVC.lbl24.text = "Pay ₹\(self.hostVC.amountpaymentFinal) now to get it by \(savedDays - 2) days, \(StrEstimate1)"
                
                if let newDate = Calendar.current.date(byAdding: .day, value: (savedDays - 2), to: date) {
                    return formatter.string(from: newDate)
                }
                // ✅ savedDays is greater than or equal to currentDays
            } else {
                self.hostVC.lbl24.text = "Pay ₹\(self.hostVC.amountpaymentFinal) now to get it by \(savedDays) days,  \(StrEstimate1)"

                guard let date = formatter.date(from: inputDateString) else {
                    print("❌ Invalid input date string: \(inputDateString)")
                    return ""
                }
                
                if let newDate = Calendar.current.date(byAdding: .day, value: 0, to: date) {
                    return formatter.string(from: newDate)
                }
                // ❌ savedDays is less than currentDays
            }

        }
        
        
     
        return ""
    }
    func paymentOnlineApi(amount:Double,name:String, productName:String,orderID:String) {
      GlobalLoader.shared.show()
      Notes(name: name, product: productName)
       // (amount: amount, orderId: orderID, notes: Notes(name: name, product: productName))
    let bodyRequest = OrderPayment(amount: amount, orderId: orderID, email: "", contact: "9636202167", paymentmethod: "razorpay", notes: Notes(name: name, product: productName))
     THApiHandler.post(requestBody: bodyRequest, responseType: OrderResponse12.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
          GlobalLoader.shared.hide()
          if dataResponse != nil{
              if let data = dataResponse?.data {
                  self?.model = data
                  let amountInPaise = amount * 100
                  let options: [String:Any] = [
                  "key": "rzp_test_zBwPgh9zUMzz9y",
                  "amount":amountInPaise,
                  "currency":"INR",
                  "name":"Test Payment iOS",
                  "order_id":self?.model?.razorpayOrderId ?? "",
                  "prefill": [
                          "contact": "9636202167"
                      ],
                  "theme":[
                      "color":"#000000"
                  ]
              ]
                  self?.hostVC.razorpayObj?.open(options)
              }
              
            
       
          } else {
              self?.hostVC.showToastView(message: msg)
          }
      }
  }

    func paymentVerifiedApi(razorpayOrderId: String, razorpayPaymentId: String, razorpaySignature: String) {
        GlobalLoader.shared.show()
        
        let bodyRequest = RazorpayPaymentVerification(
            razorpay_order_id: razorpayOrderId,
            razorpay_payment_id: razorpayPaymentId,
            razorpay_signature: razorpaySignature,
            paymentId: razorpayOrderId // or your internal payment ID if different
        )
        
        print("✅ Sending Payment Verification:", bodyRequest)
        
        THApiHandler.post(
            requestBody: bodyRequest,
            responseType: RazorpayVerificationResponse.self,
            progressView: hostVC.view,
            editId: ""
        ) { [weak self] dataResponse, error, msg in
            GlobalLoader.shared.hide()
            
            if let dataResponse = dataResponse {
                print("✅ Payment verified response:", dataResponse)
                self?.paymentOnlineApiBackSide(orderID: self?.hostVC.orderID ?? "", Payment: self?.hostVC.paymentIDRazorPay ?? "")
            } else {
                print("❌ Payment verification failed:", error ?? "Unknown error")
                self?.hostVC.showToastView(message: msg)
            }
        }
    }


    
    
    
    func paymentOnlineApiBackSide(orderID:String, Payment:String) {
      GlobalLoader.shared.show()
        
        let bodyRequest = paymentCODModel(
            paymentMethod: "razorpay",
            orderId: orderID,
            paymentId: Payment
        )
        
       
        print("✅ bodyRequest", bodyRequest)

      THApiHandler.post(requestBody: bodyRequest, responseType: PaymentResponse123.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
          GlobalLoader.shared.hide()
          if dataResponse != nil{
              
              let obj = LMOrderCartpop()
              self?.hostVC.navigationController?.pushViewController(obj, animated: true)
       
          } else {
              self?.hostVC.showToastView(message: msg)
          }
      }
  }

    func paymentCODApi(orderID:String) {
      GlobalLoader.shared.show()
        let bodyRequest = paymentCODModel(paymentMethod:"cod", orderId: orderID, paymentId: nil)
      THApiHandler.post(requestBody: bodyRequest, responseType: OrderResponse.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
          GlobalLoader.shared.hide()
          if dataResponse != nil{
              
              
              let obj = LMOrderCartpop()
              self?.hostVC.navigationController?.pushViewController(obj, animated: true)
       
          } else {
              self?.hostVC.showToastView(message: msg)
          }
      }
  }
}
