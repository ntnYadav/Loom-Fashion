//
//  VerifyVC.swift
//  TouringHealth
//
//  Created by chetu on 12/10/22.
//

import UIKit

class VerifyVC1: UIViewController {

//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var verifyBtn: UIButton!
//    @IBOutlet weak var resendBtn: UIButton!
//    @IBOutlet weak var textFieldFirst: UITextField!
//    @IBOutlet weak var textFieldSecound: UITextField!
//    @IBOutlet weak var textFieldThird: UITextField!
//    @IBOutlet weak var textFieldFourth: UITextField!
//    @IBOutlet weak var textFieldFivth: UITextField!
//    @IBOutlet weak var imageView: UIImageView!
//    let phoneNo :String = ""
//    
//    lazy private var viewmodel = VerifyVM(hostController: self)
//   // var isFromScreen : isFromScreen?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//       // viewmodel.loadUI()
//    }
//    
//    
//    //MARK: action handler
//    @IBAction func backActionBtn(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func verifyOTP_Action(_ sender: UIButton) {
//        viewmodel.validateValue()
//       // self.NavigationController(navigateFrom: self, navigateTo: LMDashboardVC(), navigateToString: VcIdentifier.LMDashboardVC)
//      //  self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
//
//    }
//
//    @IBAction func resendOTPActionBtn(_ sender: UIButton) {
//        viewmodel.resendOTP_API()
//    }
//    
//}
//
//
//
//
////MARK: UItextField delegate managed
//extension VerifyVC1: UITextFieldDelegate {
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let oldText = (textField.text ?? "" ) as NSString
//        let oldTextFieldText = textField.text
//        if textField == textFieldFirst || textField == textFieldSecound || textField == textFieldThird || textField == textFieldFourth || textField == textFieldFivth  {
//            if (oldText.length < 1 && string.count > 0) || (string == oldTextFieldText || string.count == 1) { /// || (string == oldTextFieldText || string.count == 1)
//                if textField == textFieldFirst {
//                    textFieldSecound.becomeFirstResponder()
//                } else if textField == textFieldSecound {
//                    textFieldThird.becomeFirstResponder()
//                } else if textField == textFieldThird {
//                    textFieldFourth.becomeFirstResponder()
//                } else if textField == textFieldFourth {
//                    textFieldFivth.becomeFirstResponder()
//                }
//               
//                textField.text = string
//                if textFieldFirst.text != "" && textFieldSecound.text != "" && textFieldThird.text != "" && textFieldFourth.text != "" && textFieldFivth.text != ""{
//                  //  viewModel.verifyTheOtp(id: 1)
//                    self.verifyBtn.backgroundColor = ConstantColour.activateButtonColour
//                    self.imageView.image =  UIImage(named: "VerifyOTP")
//                    
//                }
//                return false
//            } else if oldText.length >= 1 && string.count == 0 {
//                if textField == textFieldSecound {
//                    textFieldFirst.becomeFirstResponder()
//                } else if textField == textFieldThird {
//                    textFieldSecound.becomeFirstResponder()
//                } else if textField == textFieldFourth {
//                    textFieldThird.becomeFirstResponder()
//                } else if textField == textFieldFivth {
//                    textFieldFourth.becomeFirstResponder()
//                }
//                textField.text = ""
//                if textFieldFirst.text == "" || textFieldSecound.text == "" || textFieldThird.text == "" || textFieldFourth.text == "" || textFieldFivth.text != ""{
//                    self.imageView.image =  UIImage(named: "EnterOTP")
//                    self.verifyBtn.backgroundColor = ConstantColour.deactivateButtonColour
//                    debugPrint("validate")
//                
//                }
//                return false
//            } else if oldText.length >= 1 {
//                textField.text = string
//
//                return false
//            }
//            return false
//        }
//        return false
//    }
}

