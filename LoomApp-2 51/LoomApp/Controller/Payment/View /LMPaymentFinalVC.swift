//
//  ViewController.swift
//  paymentscreen
//
//  Created by Flucent tech on 28/05/25.
//

import UIKit
import Razorpay
   
import UIKit
import Foundation
import Alamofire
import Starscream
import SocketIO


struct PaymentMethod {
    let title: String
    var isExpanded: Bool
    let isCOD: Bool
}


struct Section12 {
    var mainCellTitle: String
    var expandableCellOptions: [String]
    var isExpandableCellsHidden: Bool
}


class LMPaymentFinalVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RazorpayPaymentCompletionProtocolWithData{
    //let socketManager = SocketManager()

    @IBOutlet weak var lbl24: UILabel!
    var modelproduct : CartDataitem?

    @IBOutlet weak var lblsession: UILabel!
    
    lazy fileprivate var viewmodel = LMPaymentMV(hostController: self)

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblSession: UILabel!
    var sections9: [Section12] = [
        Section12(mainCellTitle: "PAY ONLINE", expandableCellOptions: ["0"], isExpandableCellsHidden: false),
        Section12(mainCellTitle: "CASH ON DELIVERY", expandableCellOptions: ["1"], isExpandableCellsHidden: true),
        Section12(mainCellTitle: "PRICE DETAILS", expandableCellOptions: ["10"], isExpandableCellsHidden: false)
    ]
    
    @IBOutlet weak var actBack: UIButton!
    var amountpayment: String = "2998"
    var amountpaymentFinal: String = "2998"
    var timerun: Int = 0

    var orderID: String = ""
    let ProductId: String = ""
    var AddressID: String = ""
    var couponCode: String = ""
    var coupondiscountAmount: String = ""
    var wallet: String = ""
    var Amount: String = ""
    var isPreparedActive: Bool = true

    var paymentIDRazorPay:String?



    var countdownTimer: Timer?
    var remainingTime: Int = 180 // 3 minutes
    
    
    
    
    
    var razorpayObj : RazorpayCheckout? = nil
   // var merchantDetails : MerchantsDetails = MerchantsDetails.getDefaultData()
    let razorpayKey = "rzp_live_nWfIOCraA2izDq"
    
    var webSocketTask: URLSessionWebSocketTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //socketManager.connect()
        if  let token = THUserDefaultValue.authToken  {
            SocketService.shared.connect(accessToken: token, userID: "")
        }
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        remainingTime = timerun
        remainingTime = 180

        if let doubleValue = Double("\(amountpaymentFinal)") {
            lbl24.text = "Pay ₹\(Int(doubleValue)) now to get it by 4 days"

          }
        tableView.register(UINib(nibName: ExpandableCell0.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell0.cellIdentifier)
        tableView.register(UINib(nibName: MainCell0.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell0.cellIdentifier)
        
        tableView.register(UINib(nibName: "priceSubCategoryDetailTableCell", bundle: nil), forCellReuseIdentifier: "priceSubCategoryDetailTableCell")

        if THUserDefaultValue.userpincodeSecond != THUserDefaultValue.isUserPincode  {
            if THUserDefaultValue.userpincodeSecond != "" {
                viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.userpincodeSecond ?? "") ?? 0, weight: 0.5, height: 2.0, breadth: 30, length: 30)

            } else if THUserDefaultValue.isUserPincode != "" {
                viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.isUserPincode ?? "") ?? 0, weight: 0.5, height: 2.0, breadth: 30, length: 30)

            }
        } else {
            if THUserDefaultValue.userpincodeSecond != "" {
                viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.userpincodeSecond ?? "") ?? 0, weight: 0.5, height: 2.0, breadth: 30, length: 30)

            } else if THUserDefaultValue.isUserPincode != "" {
                viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.isUserPincode ?? "") ?? 0, weight: 0.5, height: 2.0, breadth: 30, length: 30)

            }
        }
      
        startCountdownTimer()
        
       // "Pay ₹\(amountpaymentFinal) now to get it by 4 days"
    }
    // MARK: - Countdown Timer
    func startCountdownTimer() {
        updateCountdownLabel()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateCountdownLabel()
        } else {
            countdownTimer?.invalidate()
            lblsession.text = "Expired"
            AlertManager.showAlert(on: self,title: "",message: "Session expired") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    func updateCountdownLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        lblsession.textColor = .red
        lblsession.text = "Session Expired in : " + String(format: "%02d:%02d", minutes, seconds)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections9.count
    }
    
    
    @IBAction func actionback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections9[section]
        if !section.isExpandableCellsHidden {
            return section.expandableCellOptions.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
    //2ad
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section main cell title
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell0.cellIdentifier, for: indexPath) as! MainCell0
            cell.label.text = sections9[indexPath.section].mainCellTitle
            cell.label.font = UIFont(name: ConstantFontSize.Bold, size: 17)
            cell.label.textAlignment = .left
            cell.btnPay.isHidden = false

            if  cell.label.text == "PRICE DETAILS" {
                cell.label.textAlignment = .center
                cell.label.font = UIFont(name: ConstantFontSize.Bold, size: 17)
                cell.btnPay.isHidden = true
            }
            if sections9[indexPath.section].isExpandableCellsHidden == true {
                cell.btnPay.setTitle("  -  ", for: .normal)
                cell.btnPay.tintColor = UIColor.lightGray
                cell.btnPay.titleLabel?.font = UIFont(name: ConstantFontSize.Bold, size: 20)// Increase font size to 20
            } else {
                cell.btnPay.setTitle("  +  ", for: .normal)
                cell.btnPay.tintColor = UIColor.lightGray
                cell.btnPay.titleLabel?.font = UIFont(name: ConstantFontSize.Bold, size: 20)
            }
            return cell
            
        } else if indexPath.row == 1 {
          //  let obj = viewmodel.modelproduct?.items[indexPath.row]
            if sections9[indexPath.section].expandableCellOptions[indexPath.row - 1] == "10" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "priceSubCategoryDetailTableCell", for: indexPath) as! priceSubCategoryDetailTableCell
                cell.lblYoumayLIke.isHidden = true
                cell.btnDelete.isHidden = true
                cell.lblHeaderPrice.isHidden = true
//
                let obj = modelproduct?.pricingSummary

                if let baseTotal = obj?.baseTotal {
                    let baseTotal1 = String(format: "%.0f", baseTotal)
                    cell.lblMRPPrice.text = keyName.rupessymbol  + "\(baseTotal1)"
                }
                if let couponDiscount = obj?.couponDiscount {
                    let dicountvaluetemp = String(format: "%.0f", couponDiscount)
                    cell.lblCouponDiscountprice.text   = "- " +  keyName.rupessymbol  + "\(dicountvaluetemp)"
                   // discount = " \(dicountvaluetemp)"
                }
                if let couponDiscount = obj?.couponCode {
                   // discountcode = " \(couponDiscount)"
                }

                if let sellingPrice = obj?.sellingTotal {
                    let sellingPrice = String(format: "%.0f", sellingPrice)
                    //cell.lblSellingPrice.text =  keyName.rupessymbol  + "\(sellingPrice)"
                }
                
                if let savings = obj?.savings {
                    let savings = String(format: "%.0f", savings)
                    cell.lblProductDiscountPrice.text =  "- " + keyName.rupessymbol  + "\(savings)"
                }
                
                
                if let coins = obj?.coinsFinal {
                    let coins = String(format: "%.0f", coins)
                    cell.lblCoin.text =  "- " + keyName.rupessymbol  + "\(coins)"
                }
                
    //            if let wallet = obj?.wallet {
    //                let wallet = String(format: "%.0f", wallet)
    //                cell.lblCoin.text =  "- " + keyName.rupessymbol  + "\(wallet)"
    //            }
                
                if let wallet = obj?.sliderValue {
                    let wallet = String(format: "%.0f", wallet)
                    cell.lblWallet.text =  "- " + keyName.rupessymbol  + "\(wallet)"
                }
                if let price = obj?.payableAmount {
                    let price = String(format: "%.0f", price)
                   // cell.lblGrandTotalPrice.text = keyName.rupessymbol  + "\(price)"
                    
                }
                
                let coins   = obj?.coinsFinal ?? 0
                let wallet  = obj?.wallet ?? 0
                let savings = obj?.savings ?? 0
                let coupon  = obj?.sliderValue ?? 0
                let amountText = (modelproduct?.pricingSummary.couponDiscount) ?? 0
                let total = coins + wallet + savings + coupon + (Double(amountText))
                let baseTotal = obj?.baseTotal ?? 0
                let grandTotal = Double(baseTotal) - total
                cell.lblGrandTotalPrice.text = String(format: "%@%.0f", keyName.rupessymbol, grandTotal)
                return cell

            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell0.cellIdentifier, for: indexPath) as! ExpandableCell0
                cell.label.text = sections9[indexPath.section].expandableCellOptions[indexPath.row - 1]
                
                if cell.label.text == "0" {
                    cell.btn.tag = 9
                    if isPreparedActive == true {
                        cell.lblpaymentTitle.isHidden = false
                        cell.lblpaymentTitle.text = "You'll get Extra 10% OFF on PREPAID Orders"
                    } else {
                        cell.lblpaymentTitle.isHidden = true
                        
                    }
                    cell.btn.addTarget(self, action: #selector(paymentCheckOut1(_:)), for: .touchUpInside)
                    // cell.btn.setTitle("PAY ₹\(amountpaymentFinal)", for: .normal)
                    if let doubleValue = Double("\(amountpaymentFinal)") {
                        cell.btn.setTitle("PAY ₹\(Int(doubleValue))", for: .normal)
                    }
                } else  if cell.label.text == "1" {
                    cell.btn.tag = 10
                    cell.btn.addTarget(self, action: #selector(paymentCheckOut(_:)), for: .touchUpInside)
                    
                    cell.lblpaymentTitle.text = "You will be charged 100 Rs for Cash on Delivery orders"
                    if let doubleValue = Double("\(amountpayment)") {
                        cell.btn.setTitle("PAY ₹\(Int(doubleValue))", for: .normal)
                    }
                    
                    // cell.btn.setTitle("PAY ₹\(amountpayment)", for: .normal)
                }
                //            if indexPath.row == 0 {
                //                cell.btn.tag = 9
                //                cell.btn.isHidden = true
                //                cell.btn1.isHidden = false
                //
                //
                //            } else if indexPath.row == 0 {
                //
                //                cell.btn.tag = 2
                //                cell.btn1.isHidden = true
                //                cell.btn.isHidden = false
                //
                //
                //            }
                return cell
            }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "priceSubCategoryDetailTableCell", for: indexPath) as! priceSubCategoryDetailTableCell
                
                
                
               
                
               
                
               
                
               // cell.lbl
                
                

            return cell
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }

    
    func formatAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "\(Int(amount))"
    }
    @objc func paymentCheckOut1(_ sender: UIButton) {
        let tag = sender.tag
        if flag == true{
            print("nnsndsj")
        }
        if tag == 9{
                        razorpayObj = RazorpayCheckout.initWithKey("rzp_live_nWfIOCraA2izDq", andDelegateWithData: self)
                        viewmodel.paymentOnlineApi(amount: Double(amountpaymentFinal) ?? 0.0, name: "Test Payment iOS", productName: "ProductName", orderID: orderID)
        }
       // viewmodel.paymentCODApi(orderID: orderID)
    }
    var flag:Bool = false
    @objc func paymentCheckOut(_ sender: UIButton) {
        flag = true
        let tag = sender.tag
        if tag == 10{
            viewmodel.paymentCODApi(orderID: orderID)

//            razorpayObj = RazorpayCheckout.initWithKey("rzp_test_zBwPgh9zUMzz9y", andDelegateWithData: self)
//            viewmodel.paymentOnlineApi(amount: Double(amountpaymentFinal) ?? 0.0, name: "Test Payment iOS", productName: "ProductName", orderID: orderID)
                       //self.openRazorpayCheckout()
        }
        if tag == 9{

            //            razorpayObj = RazorpayCheckout.initWithKey("rzp_test_zBwPgh9zUMzz9y", andDelegateWithData: self)
            //            viewmodel.paymentOnlineApi(amount: Double(amountpaymentFinal) ?? 0.0, name: "Test Payment iOS", productName: "ProductName", orderID: orderID)
                                   //self.openRazorpayCheckout()
        }
        
    }
  
 
    
    private func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable: Any]?) {
        // Show a success alert to the user
       // self.presentAlert(withTitle: "Payment Successful", message: "Payment ID: \(payment_id)")
        print("response ==\(response)")
        // Extract important Razorpay values from response
        guard
            let orderID = response?["razorpay_order_id"] as? String,
            let paymentID = response?["razorpay_payment_id"] as? String,
            let signature = response?["razorpay_signature"] as? String
        else {
            print("❌ Invalid Razorpay response format")
            return
        }

        paymentIDRazorPay = paymentID
        // Call your backend API via ViewModel with verification data
        viewmodel.paymentVerifiedApi(
            razorpayOrderId: orderID,
            razorpayPaymentId: paymentID,
            razorpaySignature: signature
        )
    }

    
//    @objc func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
//        self.presentAlert(withTitle: "Payment Successful", message: response?.description)
//
//
//    }
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        var message = ""

        switch code {
        case 0:
            message = "Network error. Please check your internet connection."
        case 1:
            message = "Unexpected error occurred. Please try again."
        case 2:
            message = "Payment was cancelled by the user."
        default:
            message = str
        }

        print("❌ Payment Failed. Code: \(code) - \(message)")
        print("📦 Razorpay error data: \(response ?? [:])")

        // Show user-friendly alert
        let alert = UIAlertController(title: "Payment Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.section == 2 {
            tableView.reloadData()

        } else {
            
            if indexPath.row == 0{
                sections9[indexPath.section].isExpandableCellsHidden = !sections9[indexPath.section].isExpandableCellsHidden
                tableView.reloadData()
            }
        }
    }
//    func paymentVerifiedApi(razorpayOrderId: String, razorpayPaymentId: String, razorpaySignature: String) {
//        let params: [String: Any] = [
//            "razorpay_order_id": razorpayOrderId,
//            "razorpay_payment_id": razorpayPaymentId,
//            "razorpay_signature": razorpaySignature,
//            "paymentId": razorpayOrderId // optional, your internal ID
//        ]
//        print("✅ params", params)
//
//        AF.request("https://payment-api.loomfashion.co.in/api/payment/verify-payment", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { [self] response in
//            switch response.result {
//            case .success(let value):
//                print("✅ Verified with server:", value)
//
//                print("✅ RequestID", paymentIDRazorPay, self.orderID)
//
//                viewmodel.paymentOnlineApiBackSide(orderID: self.orderID, Payment: paymentIDRazorPay ?? "")
//
//                // Handle success: show confirmation screen, update UI, etc.
//            case .failure(let error):
//                print("❌ Failed to verify with server:", error)
//                // Optionally show alert
//            }
//        }
//    }

   
}

//extension LMPaymentFinalVC : CustomizeDataDelegate {
//
//    func dataChanged(with merchantDetails: MerchantsDetails) {
//        self.merchantDetails = merchantDetails
//    }
//
//}
