//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift

struct CartSection {
    let title: String
    var items: [CartItemType]
}

enum CartItemType {
    case product(String)     // e.g., "Apple", "Banana"
    case coupon
    case collection
    case price
}

var cartSections: [CartSection] = [
    CartSection(title: "Fruits", items: [
        .product("Apple"),
        .product("Banana"),
        .product("Orange"),
        .coupon,
        .collection,
        .price
    ]),
    CartSection(title: "Vegetables", items: [
        .product("Carrot")
    ])
]

class LMCartTableMV : NSObject{
    var model12 : [WishlistProduct9] = []
    var modelAddress : AddressDatalist?
    var model : ReservationData?
    var modelwallet : WalletPointsData?
    var modelproduct : CartDataitem?
    private var hostVC : LMCartTableVC
    init(hostController : LMCartTableVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    func validateGetAddressList(){
        guard hostVC.checkInternet else{
            return
        }
        self.callAddressApi()
    }
    
    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else {
            return
        }
        getCartApi()
    }
    func validateUpdateQty(id :String,qty:Int){
        guard hostVC.checkInternet else {
            return
        }
        updateQty(id: id, qty: qty)
    }
    func validateDeleteCart(id :String){
        guard hostVC.checkInternet else {
            return
        }
        DeleteCartApi(cartId: id)
    }
    
    private  func DeleteCartApi(cartId:String) {
       // GlobalLoader.shared.show()
        THApiHandler.deleteAPICall(responseType: CartRemovalResponse.self, id: cartId, completionHandler:{_dataResponse,_error in
            print(_dataResponse)
            self.getCartApi()

          if let status = _dataResponse?.success {

            } else {

            }
        })
    }

    
    private  func updateQty(id :String,qty:Int) {
        GlobalLoader.shared.show()
        let bodyRequest = cartModel(quantity: qty)
        THApiHandler.postPatch(requestBody: bodyRequest, responseType: CartUpdateResponse.self, progressView: hostVC.view,editId:id){ [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            self?.validateValue()

            if let status = dataResponse?.success {

                AlertManager.showAlert(on: self!.hostVC,
                                       title: "",
                                       message: dataResponse?.message ?? "") {
                   // self?.hostVC.navigationController?.popViewController(animated: true)
                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                if msg != "" {
                    self?.hostVC.showToastView(message: msg)
                }
            }
        }
    }
    func validateValueWishListList() {
        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: WishlistResponse9.self,page:"1",limit: "100",subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                if let data = dataResponse?.products {

                                        self?.model12 = data
                                        if self?.model12.count != 0{
                                            self?.hostVC.lblCOuntBag.isHidden = false

                                            if let valuecount = self?.model12.count {
                                                self?.hostVC.lblCOuntBag.text = "\(valuecount)"
                                            }
                                            
                                            //self?.hostVC.viewEmpty.isHidden = true
                                        } else {
                                            self?.hostVC.lblCOuntBag.isHidden = true

                                            self?.hostVC.lblCOuntBag.text = ""
                                            //self?.hostVC.viewEmpty.isHidden = false
                                        }
                
                                        DispatchQueue.main.async {
                                            //self?.hostVC.tblWishlist.reloadData()
                                        }
                                    }
                                } else {
                                    self?.hostVC.lblCOuntBag.isHidden = true
                                    //self?.hostVC.viewEmpty.isHidden = false
                                }
            }
        }
    func validateValueWallet() {
        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: WalletPointsResponse.self,page:"1",limit: "50",subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                if let data = dataResponse {
                    
                   
                    self?.modelwallet = data.data // ✅ This matches WalletPointsData type
                    if self?.modelwallet?.history?.count != 0 {
                        if var history = self?.modelwallet?.history {
                            self?.modelwallet?.history = history
                            self?.getCartApi()
                        }
                       // self?.hostVC.tblcart.reloadData()

                    } else {
                        
                    }
                                            //self?.hostVC.viewEmpty.isHidden = true
//                                        } else{
//                                            //self?.hostVC.viewEmpty.isHidden = false
//                                        }
                
                                        DispatchQueue.main.async {
                                            //self?.hostVC.tblWallet.reloadData()
                                        }
                                    }
                                } else {
                                    //self?.hostVC.viewEmpty.isHidden = false
                                }
            }
        }
    
    private  func getCartApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: CartResponse.self,subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                self?.hostVC.viewEmpty.isHidden = true
                self?.hostVC.mainViewPay.isHidden = false

                self?.modelproduct = (dataResponse?.data)
                
                if self?.modelproduct?.items.count != 0 {
                    self?.hostVC.payableAmount = self?.modelproduct?.pricingSummary.payableAmount ?? 0.0
                  
                    if let amount = self?.modelproduct?.pricingSummary.payableAmount {
                        let amountString = String(format: "%.1f", amount)
                        self?.hostVC.btnPay.setTitle("Pay  \(keyName.rupessymbol) \(amountString)", for: .normal)
                    }
                    
                  
                    var items: [CartItemdata] = []
                    items.append(dummyCartItem1)
                    //self?.modelproduct?.items.append(dummyCartItemComplete)
                    self?.modelproduct?.items.append(dummyCartItem1)
                    if THUserDefaultValue.isUserLoging  == false {
                        self?.modelproduct?.items.append(dummyCartItem7)

                    } else {
                        self?.modelproduct?.items.append(dummyCartItem4)
                        self?.modelproduct?.items.append(dummyCartItem5)
                    }
                   
                    if self?.modelproduct?.isPrepaid10Active == true {
                        self?.modelproduct?.items.append(dummyCartItem6)
                    }
                    self?.modelproduct?.items.append(dummyCartItem2)

                    DispatchQueue.main.async {
                        self?.hostVC.mainViewPay.isHidden = false

                        self?.hostVC.tblcart.reloadData()
                    }
                } else {
                    self?.hostVC.mainViewPay.isHidden = true
                    self?.hostVC.viewEmpty.isHidden = false

//                    if let tabBarVC = self?.hostVC.tabBarController as? LMTabBarVC {
//                        tabBarVC.addCartTabIfNeeded()
//                    }                   
                }
              
            } else {

//                   self.viewControllers = currentTabs
//                let deleteSheet = LMCartEmptyVC()
//                deleteSheet.modalPresentationStyle = .overFullScreen
//                deleteSheet.modalTransitionStyle = .coverVertical
//                self?.hostVC.present(deleteSheet, animated: true)
            }
        }
    }
    func paymentApi(couponDiscount:String, addressId:String, couponCode:String,walletPointsToUse:String){
      GlobalLoader.shared.show()
        let bodyRequest = paymentModel(couponDiscount: Int(couponDiscount) ?? 0, addressId: addressId, couponCode: couponCode, walletPointsToUse: walletPointsToUse)
      THApiHandler.post(requestBody: bodyRequest, responseType: SoftReservationResponse.self, progressView: hostVC.view,editId:addressId){ [weak self] dataResponse, error,msg  in
          GlobalLoader.shared.hide()
          if let status = dataResponse?.success {
              self?.model = (dataResponse?.data)
              //let obj = LMPaymentVC()
              
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let obj = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMPaymentFinalVC) as! LMPaymentFinalVC
              obj.orderID = self?.model?.orderId ?? ""
              
              
              let objprice = self?.modelproduct?.pricingSummary
              let coins   = objprice?.coinsFinal ?? 0
              let wallet  = objprice?.wallet ?? 0
              let savings = objprice?.savings ?? 0
              let coupon  = objprice?.sliderValue ?? 0
              let amountText = self?.modelproduct?.pricingSummary.couponDiscount ?? 0

              let total = coins + wallet + savings + coupon + (Double(amountText))
              
              let baseTotal = objprice?.baseTotal ?? 0
              let grandTotal = Double(baseTotal) - total
              
              
              
              
              
              
              
              
              
             obj.amountpaymentFinal = String(format: "%.0f", grandTotal)
        
              //let amountString = self?.hostVC.finalAmountPayment ?? ""
              let amount = Double(grandTotal)
              let am = amount + 100
              let finalAmount = String(format: "%.2f", am)
              obj.amountpayment = "\(finalAmount)"
              obj.timerun = self?.model?.expiresIn ?? 0
              obj.coupondiscountAmount = self?.hostVC.discount ?? ""
              obj.couponCode = self?.hostVC.discountcode ?? ""
              obj.AddressID  =  self?.hostVC.addresID ?? ""
              obj.modelproduct = self?.modelproduct
              self?.hostVC.navigationController?.pushViewController(obj, animated: true)
          } else {
              self?.hostVC.showToastView(message: msg)
          }
      }
  }
    func validateValue(AddressId:String){
        guard hostVC.checkInternet else{
            return
        }
        
        self.paymentApi(couponDiscount: "", addressId: "", couponCode: "", walletPointsToUse: "")
            
        
    }
    private  func callAddressApi() {
           GlobalLoader.shared.show()
            guard hostVC.checkInternet else {
                return
            }
            THApiHandler.getApi(responseType: AddressResponseList.self) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()

                if dataResponse != nil{
                    self?.modelAddress = (dataResponse?.data)!
                    if self?.modelAddress?.defaultAddress != nil {
                        let obj = self?.modelAddress?.defaultAddress
                        self?.hostVC.addresID = obj?.id ?? keyName.name
                        self?.hostVC.lblAddress.text =  "Address: " + (obj?.houseNumber ?? "") + " " + (obj?.area ?? "") + (obj?.city ?? "") + " " + (obj?.state ?? "")
                        THUserDefaultValue.userpincodeSecond = obj?.pinCode
                        
                    } else {
                        if self?.modelAddress?.otherAddresses.count != 0 {
                            let obj = self?.modelAddress?.otherAddresses[0]
                            self?.hostVC.addresID = obj?.id ?? keyName.name
                            self?.hostVC.lblAddress.text =  "Address: " + (obj?.houseNumber ?? "") + " " + (obj?.area ?? "") + (obj?.city ?? "") + " " + (obj?.state ?? "")
                            THUserDefaultValue.userpincodeSecond = obj?.pinCode

                        }

                    }
                    if self?.modelAddress?.defaultAddress == nil && self?.modelAddress?.otherAddresses.count == 0 {
                        DispatchQueue.main.async {
                        self?.hostVC.lblAddress.text =  "ADDRESS: Add your address"
                        self?.hostVC.btnChnage.setTitle("ADD", for: .normal)
                        }
                    }
                }
            }
      }
}
