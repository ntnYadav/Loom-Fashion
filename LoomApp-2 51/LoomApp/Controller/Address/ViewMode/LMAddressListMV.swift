//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMAddressListMV : NSObject{
    
   // var Addresslist: [Addresslist]
    var model : AddressDatalist?
    var model1 : AddressDatalist?
    var otherAddresses: [Addresslisting] = []

    
    private var hostVC : LMAddresslistVC
    init(hostController : LMAddresslistVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    
    
    func validateValue(){
        guard hostVC.checkInternet else{
            return
        }
        self.callAddressApi()
    }
    // MARK: Delete
    func deleteValue(addressId: String){
        guard hostVC.checkInternet else{
            return
        }
        self.callDeleteAddressApi(addressId:addressId)
    }
    
      func
    callEditApi(name:String,phoneNo:String,pincode:String,house:String,area:String,city:String,state:String,country:String,degaultaddress:Bool,addressId:String) {
        GlobalLoader.shared.show()
        
        guard hostVC.checkInternet else{
            return
        }
        
        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.postPatch(requestBody: bodyRequest, responseType: EditAddressResponse.self, progressView: hostVC.view,editId:addressId){ [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
//                AlertManager.showAlert(on: self!.hostVC,
//                                       title: "Success",
//                                       message: dataResponse?.message ?? "") {
//                    self?.hostVC.navigationController?.popViewController(animated: true)
//                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    private  func callDeleteAddressApi(addressId:String) {
       // GlobalLoader.shared.show()
        THApiHandler.deleteAPICall(responseType: AddressDeleteResponse.self, id: addressId, completionHandler:{_dataResponse,_error in
            print(_dataResponse)
          if let status = _dataResponse?.success {
              AlertManager.showAlert(on: self.hostVC,
                                       title: "Success",
                                       message: _dataResponse?.message ?? "") {
                  self.hostVC.initset()
                  self.hostVC.tblAddlist.reloadData()
                  //self.hostVC.navigationController?.popViewController(animated: true)
                }
            } else {
                self.hostVC.lblError.isHidden = false
                self.hostVC.tblAddlist.isHidden = true
            }
        })
    }

    
    private  func callAddressApi() {
           GlobalLoader.shared.show()
            guard hostVC.checkInternet else{
                return
            }
            THApiHandler.getApi(responseType: AddressResponseList.self) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()

                if dataResponse != nil {
                
//                    if self?.model?.otherAddresses.count == 1 {
//                        if self?.model?.defaultAddress == nil,
//                           var addresses = self?.model?.otherAddresses,
//                           !addresses.isEmpty {
//                            
//                            addresses[0].isDefault = true
//                            self?.model?.otherAddresses = addresses // Reassign the updated array if it's a value type
//                        }
//                    
//                  }
//                    if self?.model?.defaultAddress == nil,
//                       var addresses = self?.model?.otherAddresses,
//                           !addresses.isEmpty {
//                            
//                            addresses[0].isDefault = true
//                            self?.model?.otherAddresses = addresses // Reassign the updated array if it's a value type
//                        }
                    
                    
                    
                    
                    
                    
                    self?.hostVC.lblError.isHidden = true
                    self?.hostVC.tblAddlist.isHidden = false
                    self?.model = (dataResponse?.data)!
                    if self?.model?.defaultAddress != nil {
                        
                        (self?.model?.otherAddresses.count ?? 0) + 1
                    }
                self?.hostVC.tblAddlist.isHidden = false
                self?.hostVC.viewEmpty.isHidden  = true
                self?.hostVC.btnAdd.isHidden     = false
                    if self?.model?.defaultAddress == nil && self?.model?.otherAddresses.count == 0 {
                        self?.hostVC.tblAddlist.isHidden = true
                        self?.hostVC.viewEmpty.isHidden  = false
                        self?.hostVC.btnAdd.isHidden     = true
                    } else {
                        if self?.model?.defaultAddress == nil {
                            
                            if self?.model?.otherAddresses.count == 1 {
                                if var addresses = self?.model?.otherAddresses,
                                   !addresses.isEmpty {
                                    addresses[0].isDefault = true
                                    self?.hostVC.selectCell = IndexPath(row: 1, section: 0)
                                    self?.model?.otherAddresses = addresses
                                }
                            }
                        }
                    }
                        
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self?.hostVC.tblAddlist.reloadData()
                    }
                }
                
            }
        
    }
    private func redirectToHome(){
        
          //hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
       // hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
}
