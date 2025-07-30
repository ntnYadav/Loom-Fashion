//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMSettingMV : NSObject{
    
    private var hostVC : LMSettingVC
    init(hostController : LMSettingVC) {
        self.hostVC = hostController
    }
    
    var model:OrderItemData?
    // MARK: validate value

    func validateDetailValue(){
        guard hostVC.checkInternet else {
            return
        }
        OrderDeleteApi()
    }

  
    
    private  func OrderDeleteApi() {
        GlobalLoader.shared.show()
        THApiHandler.deleteAPICall(responseType: DeleteAccountResponse.self, id: "", completionHandler:{_dataResponse,_error in
            print(_dataResponse)
            GlobalLoader.shared.hide()

          if let status = _dataResponse?.success {
              UserDefaults.standard.set(nil, forKey: "accessToken")
              THUserDefaultValue.userFirstName = nil
              THUserDefaultValue.phoneNumber   = nil
              THUserDefaultValue.userEmail     = nil
              THUserDefaultValue.isUserLoging  = false
              THUserDefaultValue.phoneNumber   = nil
              THUserDefaultValue.userpincodeSecond = nil
              THUserDefaultValue.isUserPincode = nil
              THUserDefaultValue.authTokenTemp = nil
              THUserDefaultValue.authToken = nil
              AlertManager.showAlert(on: self.hostVC,
                                       title: "Success",
                                       message: _dataResponse?.message ?? "") {
                  self.hostVC.NavigationController(navigateFrom: self.hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)

                }
            } else {
//                self.hostVC.lblError.isHidden = false
//                self.hostVC.tblAddlist.isHidden = true
            }
        })
    }
}
