//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMProfileMV : NSObject{
    
    var model : Userprofile?
    private var hostVC : LMProfileVC
    init(hostController : LMProfileVC) {
        self.hostVC = hostController
    }
    var stylePreference: [String] = []

    // MARK: validate value
    func validateValue(AddressId:String){
        guard hostVC.checkInternet else{
            return
        }
        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
                    return
                }
        getProfileApi(phoneno: phoneNumber)

//        let phoneNumber = hostVC.txtPhoneNumber.text!
//        if hostVC.txtName.text!.isEmpty {
//            self.hostVC.showToastView(message: keyName.name)
//        } else if hostVC.txtPhoneNumber.text!.isEmpty {
//            self.hostVC.showToastView(message: keyName.phoneNumber)
//        } else if phoneNumber.count != 10 {
//            self.hostVC.showToastView(message: keyName.validPhoneNumber)
//            return
//        }else if hostVC.txtEmail.text!.isEmpty {
//                self.hostVC.showToastView(message: keyName.emailCheck)
//        }else if hostVC.btnDOB.currentTitle  == "Date of Birth"{
//                self.hostVC.showToastView(message: keyName.DOB)
//        }else if hostVC.btnaniversary.currentTitle  == "Anniversary"{
//            self.hostVC.showToastView(message: keyName.Anniversary)
//        }else if hostVC.btnGender.currentTitle  == "Gender"{
//            self.hostVC.showToastView(message: keyName.Gender)
////        } else if hostVC.stateTextField.text!.isEmpty {
////            self.hostVC.showToastView(message: keyName.state)
//        } else {
          //  self.getProfileApi(name: hostVC.txtName.text!, phoneNo: hostVC.txtPhoneNumber.text!, email: hostVC.txtEmail.text!, dob: hostVC.btnaniversary.currentTitle ?? "", anniversary: hostVC.btnaniversary.currentTitle ?? "", gender: hostVC.btnaniversary.currentTitle ?? "", style: "")
      //  }
    }
    func validateProfileUpdate(profileId:String){
        guard hostVC.checkInternet else{
            return
        }
        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
                    return
                }

       // let phoneNumbervalue = hostVC.txtPhoneNumber.text!
       if hostVC.txtEmail.text!.isEmpty {
                self.hostVC.showToastView(message: keyName.emailCheck)
        }else if hostVC.btnDOB.title(for: .normal) == "Date of Birth"{
                self.hostVC.showToastView(message: keyName.DOB)
        }else if hostVC.btnaniversary.currentTitle  == "Anniversary"{
            self.hostVC.showToastView(message: keyName.Anniversary)
        }else if hostVC.btnGender.currentTitle  == "Gender"{
            self.hostVC.showToastView(message: keyName.Gender)
////        } else if hostVC.stateTextField.text!.isEmpty {
////            self.hostVC.showToastView(message: keyName.state)
        } else {
            self.callUpdateApi(dob: hostVC.btnDOB.currentTitle ?? "", anniversary: hostVC.btnaniversary.currentTitle ?? "", gender: hostVC.btnGender.currentTitle ?? "", style: hostVC.btnStyle.currentTitle ?? "")
        }
    }
    
    
    private  func callUpdateApi(dob:String,anniversary:String,gender:String,style:String) {
        stylePreference.removeAll()
        //stylePreference.append(style)
        let style_preference: [String]? = style.isEmpty ? nil : style.components(separatedBy: ",")

        
        GlobalLoader.shared.show()
        let bodyRequest = ProfileUpdate(dob: dob, anniversary: anniversary, gender: gender, style_preference: style_preference)
        THApiHandler.postPatch(requestBody: bodyRequest, responseType: UserProfileResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
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
    
    private  func getProfileApi(phoneno:String) {
           GlobalLoader.shared.show()
            guard hostVC.checkInternet else{
                return
            }
        THApiHandler.getApi(responseType: UserResponse.self,phoneNo:phoneno) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()

                if dataResponse != nil{
                    
                  //  self?.healthData = dataResponse?.data
                    self?.model = (dataResponse?.data)!
                    if self?.model != nil {
                        self?.hostVC.txtEmail.text       = self?.model?.email
                        self?.hostVC.txtName.text        = self?.model?.name
                        self?.hostVC.txtPhoneNumber.text = self?.model?.phoneNumber
                        var ani = self?.model?.anniversary
                        ani = ani?.replacingOccurrences(of: "T00:00:00.000Z", with: "")
                        var dob = self?.model?.dob
                        dob = dob?.replacingOccurrences(of: "T00:00:00.000Z", with: "")
                        if self?.model?.stylePreference?.count != 0{
                            let styleString = self?.model?.stylePreference?.joined(separator: ",") ?? ""

                            //let styledata:String =  self?.model?.stylePreference?[0] ?? ""
                            self?.hostVC.btnStyle.setTitle(styleString, for: .normal)

                        }
                        
//                        for style in self?.model?.stylePreference  {
//                            styledata.append(style)
//                            styledata.append(",")
//                        }
                    
                        self?.hostVC.btnaniversary.setTitle(ani, for: .normal)
                        self?.hostVC.btnDOB.setTitle(dob, for: .normal)
                        self?.hostVC.btnGender.setTitle(self?.model?.gender, for: .normal)
                        
                        self?.hostVC.btnaniversary.setTitleColor(UIColor.black, for: .normal)
                        self?.hostVC.btnDOB.setTitleColor(UIColor.black, for: .normal)
                        self?.hostVC.btnGender.setTitleColor(UIColor.black, for: .normal)
                        self?.hostVC.btnStyle.setTitleColor(UIColor.black, for: .normal)

                        
                    }
                    DispatchQueue.main.async {
                        //self?.hostVC.tblAddlist.reloadData()
                    }
                }
                
            }
        
    }
   
//    private  func getProfileApi(name:String) {
//        GlobalLoader.shared.show()
//        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
//        THApiHandler.getApi(requestBody: bodyRequest, responseType: AddAddressResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
//            GlobalLoader.shared.hide()
//            if let status = dataResponse?.success {
//              
//                AlertManager.showAlert(on: self!.hostVC,
//                                       title: "Success",
//                                       message: dataResponse?.message ?? "") {
//                    self?.hostVC.navigationController?.popViewController(animated: true)
//                }
//               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
//            } else {
//                self?.hostVC.showToastView(message: msg)
//            }
//        }
//    }
    private func redirectToHome(){
        
          //hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
       // hostVC.NavigationController(navigateFrom: hostVC, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
}
