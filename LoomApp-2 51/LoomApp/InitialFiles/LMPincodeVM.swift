//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMPincodeVM : NSObject{
    var modelgeocode : [GeoResult]?

    private var hostVC : LMPincodeVC
    init(hostController : LMPincodeVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    func validateValue(Pincode:String){
        guard hostVC.checkInternet else {
            return
        }
        getPincodeApi(Pincode: Pincode)
        
    }
   
    
    // MARK: validate value
    func validateValue1(Pincode:String,weight:Double,height:Double,breadth:Double,length:Double){
        guard hostVC.checkInternet else {
            return
        }
       
            GlobalLoader.shared.show()
        let bodyRequest = deliveryPincodeReq12(deliveryPincode: Int(Pincode) ?? 0, weight: 5.2, height: Double(height), breadth: Double(breadth), length: Double(length))
        
            THApiHandler.post(requestBody: bodyRequest, responseType: DeliveryEstimateResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
                GlobalLoader.shared.hide()
                if let status = dataResponse?.success {
                    let mod = dataResponse?.data
                    self?.hostVC.dismiss(animated: true) {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let currentDateString = formatter.string(from: Date())
                        let dateShow = self?.addThreeDays(to: currentDateString)
                        THUserDefaultValue.userdateCurrentDate = currentDateString
                        
                        THUserDefaultValue.userdateDays   = mod?.estimatedDeliveryDays ?? ""

                        THUserDefaultValue.userdatefrmate = mod?.expectedDeliveryDate ?? ""
                        self?.hostVC.onApplyTapped?(Pincode,[""])
                        
                        
                        THUserDefaultValue.isUserPincodeLoging = true
                                      }
                   // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
                } else {
                    
                    self?.hostVC.infoLabel.text = "Pincode is not serviceable"
                }
            }
        
        
    }
    
    func addThreeDays(to inputDateString: String) -> String {
        let formatter = DateFormatter()
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.locale = Locale(identifier: "en_IN") // ✅ Indian locale

        formatter.dateFormat = "MMM dd, yyyy"  // Matches: "Jun 20, 2025"

        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MMM dd, yyyy"
        let currentDateString = formatter1.string(from: Date())
        
        
        
        guard let date = formatter.date(from: currentDateString) else {
            print("❌ Invalid input date string: \(inputDateString)")
            return ""
        }

        if let savedDays = Int(THUserDefaultValue.userdateDays ?? "") {
            
            if savedDays >= 5 {
                
                if let newDate = Calendar.current.date(byAdding: .day, value: (savedDays - 2), to: date) {
                    return formatter.string(from: newDate)
                }
                // ✅ savedDays is greater than or equal to currentDays
            } else {
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
    
    private  func getPincodeApi1(Pincode:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: DeliveryEstimateResponse.self, subcategoryId: Pincode) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil{
                //self?.modelgeocode = (dataResponse?)
//                if  self?.modelgeocode?.count != 0 {
////                    self?.hostVC.dismiss(animated: true) {
////                        self?.hostVC.onApplyTapped?(self?.modelgeocode?[0].address_components[0].long_name ?? "",self?.modelgeocode?[0].postcode_localities)
////                        THUserDefaultValue.isUserPincodeLoging = true
////                    }
//                } else {
//                    self?.hostVC.infoLabel.textColor = .red
//                    self?.hostVC.infoLabel.text = "Please enter a valid 6-digit pincode"
//                }
               
            } else {
                self?.hostVC.infoLabel.textColor = .red
                self?.hostVC.infoLabel.text = "Please enter a valid 6-digit pincode"
            }
            }
        }
    
    private  func getPincodeApi(Pincode:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: GeocodeResponse.self, subcategoryId: Pincode) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil{
                self?.modelgeocode = (dataResponse?.data?.results)
                if  self?.modelgeocode?.count != 0 {
                    self?.hostVC.dismiss(animated: true) {
                        self?.hostVC.onApplyTapped?(self?.modelgeocode?[0].address_components?[0].long_name ?? "",self?.modelgeocode?[0].postcode_localities)
                        THUserDefaultValue.isUserPincodeLoging = true
                    }
                } else {
                    self?.hostVC.infoLabel.textColor = .red
                    self?.hostVC.infoLabel.text = "Please enter a valid 6-digit pincode"
                }
               
            } else {
                self?.hostVC.infoLabel.textColor = .red
                self?.hostVC.infoLabel.text = "Please enter a valid 6-digit pincode"
            }
            }
        }
   
}
