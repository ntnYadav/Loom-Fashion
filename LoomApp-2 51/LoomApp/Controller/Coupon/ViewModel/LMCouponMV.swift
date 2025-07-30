//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMCouponMV : NSObject{
    var model : PromoData?

    private var hostVC : LMCouponVC
    init(hostController : LMCouponVC) {
        self.hostVC = hostController
    }
    // MARK: validate value
    func validateCoupon(){
        guard hostVC.checkInternet else{
            return
        }
        callCouponApi()
         
    }
    private  func callCouponApi() {
           GlobalLoader.shared.show()
            guard hostVC.checkInternet else{
                return
            }
            THApiHandler.getApi(responseType: PromoResponse.self) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()

                if dataResponse != nil{
                
                   
                    self?.model = (dataResponse?.data)!
                    if self?.model?.results.count != 0 {
                        var filteredOffers = self?.model?.results
                    } else {
                        self?.hostVC.tableView.isHidden = true

                        AlertManager.showAlert(on: self!.hostVC,
                                                 title: "No active offers",
                                                 message:  "") {
                           
                          }

                    }
                        
                    DispatchQueue.main.async {
                        self?.hostVC.tableView.reloadData()
                    }
                } else {
                    
                    
                }
                
            }
        
    }
    
    private  func callEditApi(name:String,phoneNo:String,pincode:String,house:String,area:String,city:String,state:String,country:String,degaultaddress:Bool,addressId:String) {
        GlobalLoader.shared.show()
        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.postPatch(requestBody: bodyRequest, responseType: EditAddressResponse.self, progressView: hostVC.view,editId:addressId){ [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
              
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
   
    private func redirectToHome(){
        
          //hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
       // hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
}
