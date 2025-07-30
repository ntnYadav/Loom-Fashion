//
//  LoginVM.swift
//  TouringHealth
//
//  Created by chetu on 07/10/22.
//

import Foundation
import UIKit
import Toast_Swift
//nameTextField.placeholder = "Enter Name"
//phoneTextField.placeholder = "Phone Number"
//emailTextField.placeholder = "Email Address"
class LMContactVM : NSObject{
    
    private var hostVC : LMContactDetailsVC
    init(hostController : LMContactDetailsVC) {
        self.hostVC = hostController
    }
    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else{
            return
        }
        
        let phoneNumber = hostVC.phoneTextField.text!
        if hostVC.nameTextField.text!.isEmpty {
            self.hostVC.showToastView(message: keyName.name)
        } else if hostVC.phoneTextField.text!.isEmpty {
            self.hostVC.showToastView(message: keyName.phoneNumber)
        } else if phoneNumber.count != 10 {
            self.hostVC.showToastView(message: keyName.validPhoneNumber)
            return
        } else if let email = hostVC.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty {
                if !email.isValidEmail() {
                    self.hostVC.showToastView(message: keyName.validEmail) // "Please enter a valid email"
                } else {
                    self.hitContactApi(name: hostVC.nameTextField.text!, phoneNo: hostVC.phoneTextField.text!, emailId: hostVC.emailTextField.text!)
                    // ✅ Email is valid, proceed
                }
            
//        } else if !hostVC.emailTextField.text!.isValidEmail() {
//            self.hostVC.showToastView(message: keyName.validEmail)
        } else {
            self.hitContactApi(name: hostVC.nameTextField.text!, phoneNo: hostVC.phoneTextField.text!, emailId: hostVC.emailTextField.text!)
        }
    }
    
    
    private  func hitContactApi(name:String,phoneNo:String,emailId:String) {
        GlobalLoader.shared.show()
     //THUserDefaultValue.userDeviceToken ?? ""{
        var tokenDevice = ""
        if let tokenDeviceFinal1 = THUserDefaultValue.userDeviceToken {
            print("Device Token: \(tokenDeviceFinal1)")
            tokenDevice = tokenDeviceFinal1
        }
        
//        print("Device Token: \(tokenDeviceFinal)")
////        if tokenDeviceFinal == "" {
////            tokenDeviceFinal = ""
////        }
        
        let bodyRequest = ContactModelBody(name: name, phoneNumber: THconstant.countryCode + phoneNo, email: emailId, deviceType: "ios", deviceToken: tokenDevice)
        THApiHandler.post(requestBody: bodyRequest, responseType: ContactModelResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {

                UserDefaults.standard.set(dataResponse?.data?.accesstoken, forKey: "accessToken")
                THUserDefaultValue.userFirstName = dataResponse?.data?.name
                THUserDefaultValue.phoneNumber   = dataResponse?.data?.phoneNumber
                THUserDefaultValue.userEmail     = dataResponse?.data?.email
                THUserDefaultValue.isUserLoging  = true
                self?.hitGuestUserApi()

                
//                THUserDefaultValue.authToken     = dataResponse?.data.token
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.name
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.id
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.phoneNumber
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.name
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.name
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.name
//                THUserDefaultValue.userFirstName = dataResponse?.data.user.name
               // status ? self?.redirectToHome() : self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    func hitGuestUserApi() {
     // GlobalLoader.shared.show()
        var tokenDevice = ""
        if let tokenDeviceFinal1 = THUserDefaultValue.authTokenTemp {
            print("Device Token: \(tokenDeviceFinal1)")
            tokenDevice = tokenDeviceFinal1
        }
        
      THUserDefaultValue.authTokenTemp = nil
      let bodyRequest = LoginModelBodySuggestUser(guestId: tokenDevice)
      THApiHandler.post(requestBody: bodyRequest, responseType: GuestMergeResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
          // self?.hostVC.loginBtn.loadingIndicator(false)
          GlobalLoader.shared.hide()

          if let status = dataResponse?.success {
              
              AlertManager.showAlert(on: self!.hostVC,
                                     title: "Success",
                                     message: dataResponse?.message ?? "") {
                  self?.hostVC.dismiss(animated: true, completion: nil)
              }
              self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
          } else {
              self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
          }
      }
  }
    private func redirectToHome(){
       
          //hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
       // hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
}
