//
//  LMAddressAddVC1.swift
//  LoomApp
//
//  Created by Flucent tech on 12/06/25.
//

import UIKit


class LMAddressAddVC1: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    var onAddressSelectedreturn: ((String, String) -> Void)?

    @IBOutlet weak var lbl6City: UILabel!
    @IBOutlet weak var lbl5Area: UILabel!
    @IBOutlet weak var lbl1Name: UILabel!
    @IBOutlet weak var lbl2Phone: UILabel!
    @IBOutlet weak var lbl4House: UILabel!
    @IBOutlet weak var lbl3pincode: UILabel!
    
    @IBOutlet weak var btnsave: UIButton!
    lazy private var viewmodel = LMAddressMV(hostController: self)
    var modeldata : Addresslisting?
    var edit = ""
 //   let defaultAddressCheckbox = UIButton(type: .custom)
  //  let defaultAddressLabel = UILabel()
    var isDefault = false

    @IBOutlet weak var tblcity: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNoborder: UITextField!

    @IBOutlet weak var lblError: UILabel!

    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtHouse: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var btnCheckMark: UIButton!
    var postcode_localities: [String] = []

    var check = true
    var ClickAddress1 = true

    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat","Horse", "Cow", "Camel", "Sheep", "Goat"]
        
        // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblcity.delegate   = self
        tblcity.dataSource = self
        tblcity.isHidden = true
        
        txtName.delegate = self
        txtPincode.delegate = self
        txtHouse.delegate = self
        txtState.delegate = self
        txtCity.delegate = self
        txtArea.delegate = self
        txtPhoneNo.delegate = self

        initalSetUp()
        lblError.isHidden = true
        self.tblcity.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        view1.layer.borderColor = UIColor.black.cgColor
        view2.layer.borderColor = UIColor.black.cgColor
        view3.layer.borderColor  = UIColor.black.cgColor
        view4.layer.borderColor  = UIColor.black.cgColor
        view5.layer.borderColor = UIColor.black.cgColor

        txtCity.layer.borderColor = UIColor.black.cgColor
        txtState.layer.borderColor = UIColor.black.cgColor
        
        view1.layer.borderWidth = 0.7
        view5.layer.borderWidth = 0.7
        view4.layer.borderWidth = 0.7
        view3.layer.borderWidth = 0.7
        view2.layer.borderWidth = 0.7
 
        txtCity.layer.borderWidth = 0.7
        txtState.layer.borderWidth = 0.7
        
        tblcity.delegate = self
        tblcity.dataSource = self
        btnCheckMark.setImage(UIImage(systemName: "square"), for: .normal)
        btnCheckMark.setImage(UIImage(systemName: "check-box"), for: .selected)
        btnCheckMark.tintColor = .black
        btnCheckMark.addTarget(self, action: #selector(toggleDefault), for: .touchUpInside)
       
        tblcity.isUserInteractionEnabled = true
//        defaultAddressLabel.text = "Use this as default address."
//        defaultAddressLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
//        defaultAddressLabel.numberOfLines = 0
        txtCity.setLeftPaddingPoints(15)
        txtState.setLeftPaddingPoints(15)
        txtArea.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        initalSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }


    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        // Only shift up if view hasn't already moved
        if self.view.transform == .identity {
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.height) / 2)
            }
        }
    }

    
    func initalSetup() {
        lbl1Name.isHidden    = true
        lbl2Phone.isHidden   = true
        lbl3pincode.isHidden = true
        lbl4House.isHidden   = true
        lbl5Area.isHidden    = true
        lbl6City.isHidden    = true
    }
    @objc private func toggleDefault() {
        isDefault.toggle()
        btnCheckMark.isSelected = isDefault
    }
    override func viewWillAppear(_ animated: Bool) {
        if edit == keyName.Edit {
            btnsave.setTitle("Edit Address", for: .normal)
        } else {
            btnsave.setTitle("Add Address", for: .normal)
        }
        if edit == keyName.Edit {
            txtName.text    = modeldata?.name
            txtPincode.text = modeldata?.pinCode
            txtHouse.text   = modeldata?.houseNumber
            txtArea.text    = modeldata?.area
            txtCity.text    = modeldata?.city
            txtState.text   = modeldata?.state
            //defaultAddressCheckbox.isSelected = ((modeldata?.isDefault) != nil)
            btnsave.setTitle("EDIT ADDRESS", for: .normal)

        }
    }
     func initalSetUp() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
            return
        }
        let parsed = phoneNumber.replacingOccurrences(of: "+91", with: "")
         txtPhoneNo.text = parsed
        guard let name = THUserDefaultValue.userFirstName else {
            return
        }
        txtName.text = name

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // This hides the keyboard
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtArea {
            if (self.viewmodel.modelgeocode?.count ?? 0) != 0 {
                tblcity.isHidden = false
                tblcity.reloadData()
            }
        } else {
            tblcity.isHidden = true
        }
        print("TextField did begin editing")
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text?.lowercased() else { return }
        if self.viewmodel.modelgeocode?.count != 0 {
            if searchText.isEmpty {
                postcode_localities = (self.viewmodel.modelgeocode?[0].postcode_localities)!
            } else {
                postcode_localities = (self.viewmodel.modelgeocode?[0].postcode_localities?.filter { $0.lowercased().contains(searchText) })!
            }
            tblcity.reloadData()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:keyName.allowedCharacter).inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: keyName.emptyStr)
        let currentText = textField.text ?? keyName.emptyStr
        
        if textField == txtName  || textField == txtCity  || textField == txtState {
            tblcity.isHidden = true

              if filtered == string {
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                return updatedText.count <= 50
            } else {
                if string == keyName.emptyStr {
                    let countdots = textField.text!.components(separatedBy:keyName.separator).count - 1
                    if countdots == 0 {
                        return true
                    }else{
                        if countdots > 0 && string == keyName.separator {
                            return false
                        } else {
                            return true
                        }
                    }
                }else{
                    return false
                }
            }
            
        } else if textField == txtArea {
            
           // self.initalCityCall()

              if filtered == string {
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                return updatedText.count <= 50
            } else {
                if string == keyName.emptyStr {
                    let countdots = textField.text!.components(separatedBy:keyName.separator).count - 1
                    if countdots == 0 {
                        return true
                    }else{
                        if countdots > 0 && string == keyName.separator {
                            return false
                        } else {
                            return true
                        }
                    }
                }else{
                    return false
                }
            }
            
        }
        else if  textField == txtPhoneNo {
            tblcity.isHidden = true

            let currentCharacterCount = txtPhoneNo.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= 10
            
        } else if  textField == txtPincode {
            self.lbl3pincode.isHidden = true

            let currentCharacterCount = txtPincode.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            if newLength == 6 {
                let pincode = ((textField.text ?? "") + string)
                viewmodel.getApiGoogleAPI1(Pincode: pincode)
            } else {
                self.txtCity.text  = ""
                self.txtState.text = ""
            }
            return newLength <= 6
            
        }
        
        
        return true
    }
    @objc private func dismissKeyboard1() {
        view.endEditing(true)
    }
  @objc private func dismissKeyboard() {
      view.endEditing(true)
  }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actDefaultAddress(_ sender: Any) {
//        isDefault.toggle()
//        btnCheckMark.isSelected = isDefault
        
        if ClickAddress1 == false {
            check = false
            ClickAddress1 = true
            btnCheckMark.isSelected = check

            btnCheckMark.setImage(UIImage(named: "square"), for: .normal)
        } else {
            check = true
            ClickAddress1 = false
            btnCheckMark.isSelected = check

            btnCheckMark.setImage(UIImage(named: "check-box"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postcode_localities.count//self.viewmodel.modelgeocode?[0].postcode_localities.count ?? 0
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 2
        let cell:UITableViewCell = (self.tblcity.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.selectionStyle = .none

              // set the text from the data model
        //let obj = self.viewmodel.modelgeocode?[0].postcode_localities[indexPath.row]
        cell.textLabel?.text = postcode_localities[indexPath.row]//obj
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard1))
        tapGesture.cancelsTouchesInView = false  // 💥 This line is critical
        cell.addGestureRecognizer(tapGesture)
        
              return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.txtArea.text = postcode_localities[indexPath.row]//self.viewmodel.modelgeocode?[0].postcode_localities[indexPath.row]
       // let o = self.viewmodel.modelgeocode?[0].postcode_localities[indexPath.row]
        tblcity.isHidden = true
    }
    @IBAction func actSave(_ sender: Any) {
        if edit == keyName.Edit {
            viewmodel.validateAddressFields(addressId: modeldata?.id ?? "")
        } else {
            viewmodel.validateAddressFields(addressId: "")
        }
    }
}

// MARK: - Padding Extension
  extension UITextField {
      func setLeftPaddingPoints(_ amount:CGFloat) {
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
          self.leftView = paddingView
          self.leftViewMode = .always
      }
  }
