//
//  addBankDetails.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 13/07/25.
//

import UIKit

class addBankDetails: UIViewController,UITextFieldDelegate {

    var onBankSelected: ((String,String,String) -> Void)?
    @IBOutlet weak var ifscTxt: UITextField!
    
    @IBOutlet weak var accountNumberTxt: UITextField!
    
    @IBOutlet weak var comfirmAccountTxt: UITextField!
    @IBOutlet weak var accountHloderName: UITextField!
   
    @IBOutlet weak var lookUpBtn: UIButton!
    
    @IBOutlet weak var adNewBankBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lookUpBtn.isHidden = true
        // Keyboard types
        accountHloderName.keyboardType = .default
        accountNumberTxt.keyboardType = .numberPad
        comfirmAccountTxt.keyboardType = .numberPad
        ifscTxt.keyboardType = .asciiCapable
        
        // Delegates
        ifscTxt.delegate = self
        accountNumberTxt.delegate = self
        comfirmAccountTxt.delegate = self
        accountHloderName.delegate = self
        
        // Toolbars
        addDoneToolbar(to: accountHloderName)
        addDoneToolbar(to: accountNumberTxt)
        addDoneToolbar(to: comfirmAccountTxt)
     
    }
    override func viewWillAppear(_ animated: Bool) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                break
            case .right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func adNewBankActionBtn(_ sender: Any) {
        print("ok!")
        if let errorMessage = BankValidation.validate(
                 ifsc: ifscTxt.text,
                 accountNumber: accountNumberTxt.text,
                 confirmAccount: comfirmAccountTxt.text,
                 name: accountHloderName.text
             ) {
                 showAlert(message: errorMessage)
             } else {
                 onBankSelected?(ifscTxt.text ?? "", accountNumberTxt.text ?? "''", accountHloderName.text ?? "")
                     self.navigationController?.popViewController(animated: true)

                 print(" All validations passed. New Account Added!")
             }
      }

    func showAlert(message: String) {
         let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true)
     }
    func addDoneToolbar(to textField: UITextField) {
          let toolbar = UIToolbar()
          toolbar.sizeToFit()
          let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
          toolbar.items = [flexSpace, doneBtn]
          textField.inputAccessoryView = toolbar
      }
    
    
    // MARK: - TextFieldDelegate for input restriction and IFSC uppercase
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == ifscTxt {
            let uppercase = string.uppercased()
            if let currentText = textField.text as NSString? {
                textField.text = currentText.replacingCharacters(in: range, with: uppercase)
            }
            return false
        }
        
        if textField == accountNumberTxt || textField == comfirmAccountTxt {
            let maxLength = 20
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= maxLength && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        
        return true
    }
    @IBAction func actBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



