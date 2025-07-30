//
//  LMProfileVC.swift
//
//  Created by chetu on 02/04/25.
//

import UIKit
import AVKit

class LMProfileVC: UIViewController {
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnStyle: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnaniversary: UIButton!
    @IBOutlet weak var btnDOB: UIButton!
    lazy private var viewmodel = LMProfileMV(hostController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        txtEmail.delegate = self
        txtPhoneNumber.delegate = self
        txtPhoneNumber.keyboardType = .numberPad

//        txtEmail.layer.borderColor = UIColor.lightGray.cgColor
//        txtName.layer.borderColor = UIColor.lightGray.cgColor
//        txtPhoneNumber.layer.borderColor = UIColor.lightGray.cgColor
//        btnaniversary.layer.borderColor = UIColor.lightGray.cgColor
//        btnDOB.layer.borderColor = UIColor.lightGray.cgColor
//        btnStyle.layer.borderColor = UIColor.lightGray.cgColor
//        btnGender.layer.borderColor = UIColor.lightGray.cgColor
//
//        txtEmail.layer.borderWidth = 0.7
//        txtName.layer.borderWidth = 0.7
//        txtPhoneNumber.layer.borderWidth = 0.7
//        btnaniversary.layer.borderWidth = 0.7
//        btnDOB.layer.borderWidth = 0.7
//        btnStyle.layer.borderWidth = 0.7
//        btnGender.layer.borderWidth = 0.7
//        txtEmail.setLeftPaddingPoints(10)
//        txtName.setLeftPaddingPoints(10)
//        txtPhoneNumber.setLeftPaddingPoints(10)
        txtEmail.font       = UIFont(name: ConstantFontSize.regular, size: 14)
        txtName.font        = UIFont(name: ConstantFontSize.regular, size: 14)
        txtPhoneNumber.font = UIFont(name: ConstantFontSize.regular, size: 14)
        viewmodel.validateValue(AddressId: "")
        setupUI()
        setupDelegates()
        
      
        initalValueset()

    }
    func initalValueset() {
        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
            return
        }
        let parsed = phoneNumber.replacingOccurrences(of: "+91", with: "")
        self.txtPhoneNumber.text = parsed
        
        guard let name = THUserDefaultValue.userFirstName else {
            return
        }
        self.txtName.text = name
        
        guard let email = THUserDefaultValue.userEmail else {
            return
        }
        self.txtName.text = email
        txtEmail.textColor       = UIColor.lightGray
        txtName.textColor        = UIColor.lightGray
        txtPhoneNumber.textColor = UIColor.lightGray
        txtEmail.isEnabled       = true
        txtPhoneNumber.isEnabled = true
        txtName.isEnabled        = true

    }
    override func viewWillAppear(_ animated: Bool) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
       // setupMultipleButtons()
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
    // MARK: - Setup Methods
      private func setupUI() {
          let borderedViews: [UIView] = [txtName, txtEmail, txtPhoneNumber, btnStyle, btnGender, btnDOB, btnaniversary]
          borderedViews.forEach {
              $0.layer.borderColor = UIColor.lightGray.cgColor
              $0.layer.borderWidth = 0.7
          }
          [txtName, txtEmail, txtPhoneNumber].forEach {
              $0.setLeftPaddingPoints(10)
          }
          txtPhoneNumber.keyboardType = .numberPad
      }
    private func setupDelegates() {
          [txtName, txtEmail, txtPhoneNumber].forEach {
              $0.delegate = self
          }
      }
    @IBAction func actStyle(_ sender: Any) {
        let styleVC = LMSheetVC()

        styleVC.onDismiss = { [weak self] selected in
            Swift.print("User selected styles: \(selected)")
            self?.handleSelectedStyles(selected)
        }
            if let sheet = styleVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()] // Makes it open from bottom
                sheet.prefersGrabberVisible = true // Optional: adds grabber bar
               
            }
            present(styleVC, animated: true)
    }
//        func handleSelectedStyles(_ styles: Set<String>) {
//            // Use the selected styles here
//            var str:String = ""
//            for style in styles {
//                str.append(style)
//                str.append(",")
//            }
//            btnStyle.setTitle(str, for: .normal)
//            btnStyle.setTitleColor(.black, for: .normal) // Same for both states
//        }
    private func handleSelectedStyles(_ styles: Set<String>) {
          let selected = styles.joined(separator: ", ")
         // setButtonTitle(btnStyle, with: selected)
        btnStyle.setTitle(selected, for: .normal)
        btnStyle.setTitleColor(.black, for: .normal)
      }
    @IBAction func actGender(_ sender: Any) {
        // Simple Option Picker
        RPicker.selectOption(title: THconstant.selectGender, dataArray: THconstant.arrGender) {[weak self] (selctedText, atIndex) in
            // TODO: Your implementation for selection
           // self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
            self?.btnGender.setTitle(selctedText, for: .normal)
            self?.btnGender.setTitleColor(.black, for: .normal)

        }
    }
    @IBAction func actDOB(_ sender: Any) {
        RPicker.selectDate(title: THconstant.selectDOBDate, cancelText: THconstant.cancel, datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.btnDOB.setTitle(selectedDate.dateString(THconstant.dateFormate), for: .normal)
            self?.btnDOB.setTitleColor(.black, for: .normal)
        })
    }
    @IBAction func actUpdate(_ sender: Any) {
        
        viewmodel.validateProfileUpdate(profileId: "")
    }
    @IBAction func actAniversary(_ sender: Any) {
        RPicker.selectDate(title: THconstant.selectAnniversaryDate, cancelText: THconstant.cancel, datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.btnaniversary.setTitle(selectedDate.dateString(THconstant.dateFormate), for: .normal)
            self?.btnaniversary.setTitleColor(.black, for: .normal)
        })
    }
    
    func dateSelect()  {

        //init date picker
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 260))
        datePicker.datePickerMode = UIDatePicker.Mode.date

        //add target
        datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: UIControl.Event.valueChanged)

        //add to actionsheetview
        let alertController = UIAlertController(title: "", message:" " , preferredStyle: UIAlertController.Style.actionSheet)

        alertController.view.addSubview(datePicker)//add subview

        let cancelAction = UIAlertAction(title: THconstant.done, style: .cancel) { (action) in
            self.dateSelected(datePicker: datePicker)
        }

        //add button to action sheet
        alertController.addAction(cancelAction)

        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        alertController.view.addConstraint(height);

        self.present(alertController, animated: true, completion: nil)

    }


    //selected date func
    @objc func dateSelected(datePicker:UIDatePicker) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short

        let currentDate = datePicker.date

        print(currentDate)

    }
    
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if textField == txtName {
//            let inverseSet = NSCharacterSet(charactersIn:keyName.allowedCharacter).inverted
//            let components = string.components(separatedBy: inverseSet)
//            let filtered = components.joined(separator: keyName.emptyStr)
//            let currentText = textField.text ?? keyName.emptyStr
//            
//            if filtered == string {
//                guard let stringRange = Range(range, in: currentText) else { return false }
//                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//                return updatedText.count <= 50
//            } else {
//                if string == keyName.emptyStr {
//                    let countdots = textField.text!.components(separatedBy:keyName.separator).count - 1
//                    if countdots == 0 {
//                        return true
//                    }else{
//                        if countdots > 0 && string == keyName.separator {
//                            return false
//                        } else {
//                            return true
//                        }
//                    }
//                }else{
//                    return false
//                }
//            }
//            
//        } else if  textField == txtPhoneNumber {
//            let currentCharacterCount = txtPhoneNumber.text?.count ?? 0
//            if (range.length + range.location > currentCharacterCount){
//                return false
//            }
//            let newLength = currentCharacterCount + string.count - range.length
//            return newLength <= 10
//            
//        }
//        
//        
//        return true
//    }
}
// MARK: - UITextFieldDelegate
extension LMProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == txtName {
            let allowedChars = CharacterSet(charactersIn: keyName.allowedCharacter)
            let filtered = string.unicodeScalars.allSatisfy { allowedChars.contains($0) }

            guard filtered else {
                return string.isEmpty // Allow backspace
            }

            let currentText = textField.text ?? ""
            if let range = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                return updatedText.count <= 50
            }
            return false

        } else if textField == txtPhoneNumber {
            let currentLength = textField.text?.count ?? 0
            if range.location + range.length > currentLength { return false }
            let newLength = currentLength + string.count - range.length
            return newLength <= 10
        }

        return true
    }
}
extension Date {
    
    func dateString(_ format: String = THconstant.dateCalender) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}

