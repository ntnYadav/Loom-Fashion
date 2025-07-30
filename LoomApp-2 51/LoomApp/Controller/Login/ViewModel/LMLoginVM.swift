//
//  LoginVM.swift
//  TouringHealth
//
//  Created by chetu on 07/10/22.
//

import Foundation
import UIKit
import Toast_Swift

class LoginVM : NSObject{
    
    private var hostVC : LoginVC
    init(hostController : LoginVC) {
        self.hostVC = hostController
    }
    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else{
            return
        }
        let phoneNumber = hostVC.phoneTextField.text!
        if hostVC.phoneTextField.text!.isEmpty {
            self.hostVC.showToastView(message: keyName.phoneNumber)
        } else if phoneNumber.count != 10 {
            self.hostVC.showToastView(message: keyName.validPhoneNumber)
            return
        } else {
            self.hitLoginApi(PhoneNo: self.hostVC.phoneTextField.text!, isResend: false)
        }
    }
    
    
    private  func hitLoginApi(PhoneNo:String, isResend:Bool) {
        GlobalLoader.shared.show()

        let bodyRequest = LoginModelBody(phoneNumber: THconstant.countryCode + PhoneNo, isResend: false)
        THApiHandler.post(requestBody: bodyRequest, responseType: LoginModelResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            // self?.hostVC.loginBtn.loadingIndicator(false)
            GlobalLoader.shared.hide()

            if let status = dataResponse?.success {

                
                self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
                status ? self?.redirectToHome() : self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: dataResponse?.message ?? keyName.backenError)
            }
        }
    }
    private func redirectToHome(){
        THUserDefaultValue.phoneNumber = hostVC.phoneTextField.text

        
        self.hostVC.dismiss(animated: true) {
                 // After dismissing FirstVC, present SecondVC from root or current context
                 if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                     let vc = VerifyVC()
                     vc.modalPresentationStyle = .overFullScreen
                     vc.modalTransitionStyle = .crossDissolve  // Smooth fade animation
                     rootVC.present(vc, animated: true, completion: nil)
                 }
             }

        
//        let vc = VerifyVC()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve  // Smooth fade animation
//        self.hostVC.present(vc, animated: true, completion: nil)
//        //hostVC.selectedViewController?.present(halfVC, animated: true)
        
        hostVC.NavigationController(navigateFrom: hostVC, navigateTo: VerifyVC(), navigateToString: VcIdentifier.VerifyVC)
    }
}
