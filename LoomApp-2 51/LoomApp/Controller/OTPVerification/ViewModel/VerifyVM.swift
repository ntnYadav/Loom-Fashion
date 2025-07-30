//
//  VerifyVM.swift
//  TouringHealth
//
//  Created by chetu on 12/10/22.
//

import Foundation
import UIKit

class VerifyVM {
    var loginTap: ((Int) -> Void)?

    private var hostVC : VerifyVC
    
    init(hostController:VerifyVC) {
        self.hostVC = hostController
    }
    
    
    //MARK: load UI
    func loadUI(){

    }
    
    
    //MARK: validate value
    func validateValue(otp:String){
        guard hostVC.checkInternet else{
            return
        }
        self.callAPIforVerify(OTP: otp)

//        switch  hostVC.verifyBtn.backgroundColor  {
//        case ConstantColour.activateButtonColour:
//            self.hostVC.verifyBtn.loadingIndicator(true)
//            let otp = hostVC.textFieldFirst.text!+hostVC.textFieldSecound.text!+hostVC.textFieldThird.text!+hostVC.textFieldFourth.text! + hostVC.textFieldFivth.text!
//            self.callAPIforVerify(OTP: otp)
//            
////
////            switch self.hostVC.isFromScreen {
////            case .fromRegisterScreen:
////                self.callAPIforVerify(OTP: otp)
////            default:
////                self.callAPIforVerify_Forget(OTP: otp)
////            }
////            
//        default:
//            break
//        }
    }
    
    
      func hitresendApi(PhoneNo:String, isResend:Bool) {
        GlobalLoader.shared.show()

        let bodyRequest = LoginModelBody(phoneNumber: THconstant.countryCode + PhoneNo, isResend: false)
        THApiHandler.post(requestBody: bodyRequest, responseType: LoginModelResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            // self?.hostVC.loginBtn.loadingIndicator(false)
            if let status = dataResponse?.success {
                GlobalLoader.shared.hide()
                self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
            } else {
                self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
            }
        }
    }
    
    func hitGuestUserApi() {
      GlobalLoader.shared.show()
        var tokenDevice = ""
        if let tokenDeviceFinal1 = THUserDefaultValue.authTokenTemp {
            print("Device Token: \(tokenDeviceFinal1)")
            tokenDevice = tokenDeviceFinal1
        }
        
      THUserDefaultValue.authTokenTemp = nil
      let bodyRequest = LoginModelBodySuggestUser(guestId: tokenDevice)
      THApiHandler.post(requestBody: bodyRequest, responseType: GuestMergeResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
          // self?.hostVC.loginBtn.loadingIndicator(false)
          if let status = dataResponse?.success {
              GlobalLoader.shared.hide()
              self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
          } else {
              self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
          }
      }
  }
    //MARK: call API
    
    private func callAPIforVerify(OTP:String){
        GlobalLoader.shared.show()

        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
            return
        }
      
        var tokenDevice = ""
        if let tokenDeviceFinal1 = THUserDefaultValue.userDeviceToken {
            print("Device Token: \(tokenDeviceFinal1)")
            tokenDevice = tokenDeviceFinal1
        }
        
        let bodyRequest = OTPverificationBody(phoneNumber: THconstant.countryCode + phoneNumber, otp: OTP, deviceType: "ios", deviceToken: tokenDevice )
        //(phoneNumber: THconstant.countryCode + phoneNumber, otp: OTP)
        THApiHandler.post5(requestBody: bodyRequest, responseType: OTPLoginResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error, message in
            GlobalLoader.shared.hide()

            if message == "Redirect" {
                self?.redirectionContact()
              //  self?.hostVC.NavigationController(navigateFrom: self?.hostVC, navigateTo: LMContactDetailsVC(), navigateToString: VcIdentifier.LMContactDetailsVC)

            } else {
                if dataResponse?.success == true {
                    if dataResponse?.data?.isNewUser == true{
                        self?.redirectionContact()
                    } else {
                        
                        print("dataResponse?.data?.isNewUser ===\(dataResponse?.data?.isNewUser)")
                        let token = dataResponse?.data?.token
                        AppDelegate.shared.token = token ?? ""
                        THUserDefaultValue.authToken     = token
                        
                        let value = THUserDefaultValue.authToken
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        THUserDefaultValue.userFirstName = dataResponse?.data?.user?.name
                        THUserDefaultValue.phoneNumber   = dataResponse?.data?.user?.phoneNumber
                        THUserDefaultValue.userEmail     = dataResponse?.data?.user?.email
                        THUserDefaultValue.userBagCount     = dataResponse?.data?.userBag?.cartCount
                        THUserDefaultValue.userwishlistCount = dataResponse?.data?.userBag?.wishlistCount
                        
                        THUserDefaultValue.isUserLoging  = true
                        self?.hostVC.dismiss(animated: true)
//                        self?.hostVC.NavigationController(navigateFrom: self?.hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
                        
                        if dataResponse?.data?.isNewUser == false {
                            self?.hitGuestUserApi()
                        }
                        
                    }
                } else {
                    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.hostVC.present(alert, animated: true)
                  //  self?.hostVC.showToastView(message: message)
                    
                }
                
            }
            
        }
        
    }
    
    func redirectionContact(){
       // self.hostVC.dismiss(animated: true, completion: nil) // Dismiss the popup

        self.hostVC.dismiss(animated: true) {
                // After dismissing FirstVC, present SecondVC from root or current context
                if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                    let vc = LMContactDetailsVC()
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve  // Smooth fade animation
                    rootVC.present(vc, animated: true, completion: nil)
                }
            }
        
   
    }
    
    private func callAPIforVerify_Forget(OTP:String){
        guard let email = THUserDefaultValue.userEmail else {
            return
        }
        
        let bodyRequest = OTPverificationBody1(phoneNumber: email, otp: OTP)
        THApiHandler.post(requestBody: bodyRequest, responseType: ResponseForgetPasswordOTP.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
          debugPrint(dataResponse as Any)
           // self?.hostVC.verifyBtn.loadingIndicator(false)
            if let status = dataResponse?.status {
//                THUserDefaultValue.userID = nil
//                THUserDefaultValue.userID =  dataResponse?.data?.id
                status ? self?.redirectToForgetPassword(message: dataResponse?.message ?? "") : self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            }
        }

    }
    
    func resendOTP_API(){
        guard hostVC.checkInternet else{
            return
        }

        guard let email = THUserDefaultValue.userEmail else {
            return
        }
        //self.hostVC.resendBtn.loadingIndicator(true)
        let bodyRequest = ResendOTPBody(email: email)
        THApiHandler.post(requestBody: bodyRequest, responseType: ResendOTPResponse.self, progressView: hostVC.view ) { [weak self] dataResponse, error,msg  in
            //self?.hostVC.resendBtn.loadingIndicator(false)
            if let message = dataResponse?.message {
                self?.hostVC.showToastView(message: message)
            }
        }
      
    }
    
    private func redirectToForgetPassword(message:String){
        self.hostVC.showToastView(message: message)
//        guard let controller = THconstant.storyboardMain.instantiateViewController(identifier: controllerName.forgetscreen.controllerID) as? ForgetViewController else {
//            debugPrint("ViewController not found")
//            return
//        }
//        // controller.isFromScreen = .fromLoginScreen
//        self.hostVC.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func redirectToCreatePassword(message:String){
        self.hostVC.showToastView(message: message)
//        guard let controller = THconstant.storyboardMain.instantiateViewController(identifier: controllerName.createPasswordScreen.controllerID) as? CreatePasswordViewController else {
//            debugPrint("ViewController not found")
//            return
//        }
//        // controller.isFromScreen = .fromLoginScreen
//        self.hostVC.navigationController?.pushViewController(controller, animated: true)
    }
}
