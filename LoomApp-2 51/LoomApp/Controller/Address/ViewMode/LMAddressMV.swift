//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMAddressMV : NSObject{
    
    private var hostVC : LMAddressAddVC1
    init(hostController : LMAddressAddVC1) {
        self.hostVC = hostController
    }
    var modelgeocode : [GeoResult]?
    var modelgeocode1 : [PostalLocation]?
    var modelgeocode2 : [PostOfficeInfo]?


    // MARK: - Initial Setup

    func initialSetup() {
        hostVC.lbl1Name.isHidden    = true
        hostVC.lbl2Phone.isHidden   = true
        hostVC.lbl3pincode.isHidden = true
        hostVC.lbl4House.isHidden   = true
        hostVC.lbl5Area.isHidden    = true
        hostVC.lbl6City.isHidden    = true
    }

    // MARK: - Validate Address Fields

    func validateAddressFields(addressId: String) {
        guard hostVC.checkInternet else { return }

        initialSetup()

        var isValid = true

        if let name = hostVC.txtName.text, name.isEmpty {
            showError(on: hostVC.lbl1Name, message: keyName.name)
            isValid = false
        }

        if let phone = hostVC.txtPhoneNo.text, phone.isEmpty {
            showError(on: hostVC.lbl2Phone, message: keyName.phoneNumber)
            isValid = false
        } else if let phone = hostVC.txtPhoneNo.text, phone.count != 10 {
            showError(on: hostVC.lbl2Phone, message: keyName.validPhoneNumber)
            isValid = false
        }

        if let pincode = hostVC.txtPincode.text, pincode.isEmpty {
            showError(on: hostVC.lbl3pincode, message: keyName.pincode)
            isValid = false
        }

        if let house = hostVC.txtHouse.text, house.isEmpty {
            showError(on: hostVC.lbl4House, message: keyName.house)
            isValid = false
        }

        if let area = hostVC.txtArea.text, area.isEmpty {
            showError(on: hostVC.lbl5Area, message: keyName.area)
            hostVC.showToastView(message: keyName.area)
            isValid = false
        }

        if let city = hostVC.txtCity.text, city.isEmpty {
            showError(on: hostVC.lbl6City, message: keyName.city)
            isValid = false
        }

        if let state = hostVC.txtState.text, state.isEmpty {
            //hostVC.showToastView(message: keyName.state)
            isValid = false
        }

        guard isValid else { return }

        let isDefault = hostVC.btnCheckMark.isSelected

        if hostVC.edit == keyName.Edit {
            callEditApi(
                name: hostVC.txtName.text!,
                phoneNo: hostVC.txtPhoneNo.text!,
                pincode: hostVC.txtPincode.text!,
                house: hostVC.txtHouse.text!,
                area: hostVC.txtArea.text!,
                city: hostVC.txtCity.text!,
                state: hostVC.txtState.text!,
                country: "India",
                degaultaddress: isDefault,
                addressId: addressId
            )
        } else {
            callAddressApi(
                name: hostVC.txtName.text!,
                phoneNo: hostVC.txtPhoneNo.text!,
                pincode: hostVC.txtPincode.text!,
                house: hostVC.txtHouse.text!,
                area: hostVC.txtArea.text!,
                city: hostVC.txtCity.text!,
                state: hostVC.txtState.text!,
                country: "India",
                degaultaddress: isDefault
            )
        }
    }


    // MARK: - Helper to Show Field Error

    private func showError(on label: UILabel, message: String) {
        label.text = message
        label.isHidden = false
    }

    private  func callEditApi(name:String,phoneNo:String,pincode:String,house:String,area:String,city:String,state:String,country:String,degaultaddress:Bool,addressId:String) {
        GlobalLoader.shared.show()
        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.postPatch(requestBody: bodyRequest, responseType: EditAddressResponse.self, progressView: hostVC.view,editId:addressId){ [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
                AlertManager.showAlert(on: self!.hostVC,
                                       title: "Success",
                                       message: dataResponse?.message ?? "") {
                    self?.hostVC.navigationController?.popViewController(animated: true)
                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    private  func callAddressApi(name:String,phoneNo:String,pincode:String,house:String,area:String,city:String,state:String,country:String,degaultaddress:Bool) {
        GlobalLoader.shared.show()
        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.post(requestBody: bodyRequest, responseType: AddAddressResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
                AlertManager.showAlert(on: self!.hostVC,
                                       title: "Success",
                                       message: dataResponse?.message ?? "") {
                    self?.hostVC.navigationController?.popViewController(animated: true)
                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    func getPincodetempApi(Pincode:String) {
          GlobalLoader.shared.show()
          THApiHandler.getApiGoogleAPI(responseType: PincodeResponse.self, subcategoryId: Pincode) { [weak self] dataResponse, error in
              debugPrint(dataResponse as Any)
              GlobalLoader.shared.hide()
              if dataResponse != nil{
                  self?.modelgeocode2 = (dataResponse?.PostOffice)
//                  self?.hostVC.txtPincode.text = self?.modelgeocode2.
//                  self?.hostVC.txtPincode.text = component.long_name
//                  self?.hostVC.txtPincode.text = component.long_name
//                  

              }
          }
    }
    
      func getApiGoogleAPI1(Pincode:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApiGoogleAPI1(responseType: GeocodeResponse.self, subcategoryId: Pincode) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil{
                self?.modelgeocode = (dataResponse?.data?.results)
                if let results = self?.modelgeocode {
                    if  self?.modelgeocode?.count != 0 {
                        self?.hostVC.postcode_localities = (self?.modelgeocode?[0].postcode_localities)!
                        var containsIndia = false

                        for result in results {
                            self?.hostVC.lbl3pincode.isHidden = true

                            guard let components = result.address_components else { continue }
                            containsIndia = false

                            for component in components {
                                let types = component.types ?? []

                                if types.contains("postal_code") {
                                    self?.hostVC.txtPincode.text = component.long_name
                                } else if types.contains("locality") {
//                                    self?.hostVC.txtCity.text = component.long_name
                                } else if types.contains("administrative_area_level_1") {
                                    self?.hostVC.txtState.text = component.long_name

                                } else if types.contains("administrative_area_level_3") {
                                    self?.hostVC.txtCity.text = component.long_name

                                }

                                if types.contains("country"), component.long_name == "India" {
                                    containsIndia = true
                                    break
                                }
                            }

                            // If you only want to check the first result, break here:
                            // break
                        }

                        // After the loop:
                        if containsIndia {
                            print("Address is in India ✅")
                        } else {
                            self?.hostVC.lbl3pincode.isHidden = false
                            self?.hostVC.lbl3pincode.text = "Pincode is not serviceable"
                        }

                        
                    } else {
                        self?.hostVC.lbl3pincode.isHidden = false
                        //self?.hostVC.lbl3pincode.textColor = .red
                        self?.hostVC.lbl3pincode.text = "Pincode is not serviceable"
                    }
                   
                }

//                self?.hostVC.stateTextField.text = self?.modelgeocode?[0].address_components[0].long_name
//                self?.hostVC.cityTextField.text = self?.modelgeocode?[0].address_components[0].long_name
//                self?.hostVC.pincodeTextField.text = self?.modelgeocode?[0].address_components[0].long_name
            } else{
                self?.hostVC.lbl3pincode.isHidden = false

            }
            }
        }

    private func redirectToHome(){
        
          //hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
       // hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
}
