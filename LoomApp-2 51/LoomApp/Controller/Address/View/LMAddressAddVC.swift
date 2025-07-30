//
//  ViewController.swift
//  DemoProject
//
//  Created by chetu on 02/04/25.
//

import UIKit
import AVKit

class LMAddressAddVC: UIViewController,UITextFieldDelegate {
  
//      lazy private var viewmodel = LMAddressMV(hostController: self)
//        var modeldata : Addresslisting?
////      let otherAddresses: Addresslisting
//      var edit = ""
//      let scrollView = UIScrollView()
//      let contentView = UIStackView()
//      
//      let nameTextField = UITextField()
//      let phoneTextField = UITextField()
//      let pincodeTextField = UITextField()
//      let houseTextField = UITextField()
//      let areaTextField = UITextField()
//    
//      let cityTextField = UITextField()
//      let stateTextField = UITextField()
//      
//      let defaultAddressCheckbox = UIButton(type: .custom)
//      let defaultAddressLabel = UILabel()
//      
//      let saveButton = UIButton(type: .system)
//      
//      var isDefault = false
//      
//      override func viewDidLoad() {
//          super.viewDidLoad()
//          overrideUserInterfaceStyle = .light
//
//          setupUI()
//          guard let phoneNumber = THUserDefaultValue.phoneNumber else {
//              return
//          }
//          let parsed = phoneNumber.replacingOccurrences(of: "+91", with: "")
//          phoneTextField.text = parsed
//          guard let name = THUserDefaultValue.userFirstName else {
//              return
//          }
//          nameTextField.text = name
//
//          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//          view.addGestureRecognizer(tapGesture)
//
//      }
//    override func viewWillAppear(_ animated: Bool) {
//        if edit == keyName.Edit {
//            nameTextField.text    = modeldata?.name
//            pincodeTextField.text = modeldata?.pinCode
//            houseTextField.text   = modeldata?.houseNumber
//            areaTextField.text    = modeldata?.area
//            cityTextField.text    = modeldata?.city
//            stateTextField.text   = modeldata?.state
//            //defaultAddressCheckbox.isSelected = ((modeldata?.isDefault) != nil)
//            saveButton.setTitle("EDIT ADDRESS", for: .normal)
//
//        }
//    }
//    
//    
//    
//      @objc private func dismissKeyboard() {
//          view.endEditing(true)
//      }
//    private func setupUI() {
//          // MARK: - Header View
//          let headerView = UIView()
//          headerView.translatesAutoresizingMaskIntoConstraints = false
//          view.addSubview(headerView)
//
//          NSLayoutConstraint.activate([
//              headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//              headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//              headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//              headerView.heightAnchor.constraint(equalToConstant: 50)
//          ])
//
//          let leftButton = UIButton(type: .system)
//          leftButton.setTitleColor(.black, for: .normal)
//          let image = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
//          leftButton.setImage(image, for: .normal)
//          
//           leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//
//          let titleLabel = UILabel()
//        if edit == keyName.Edit {
//            titleLabel.text = "Edit Address"
//        } else {
//            titleLabel.text = "Add Address"
//        }
//          titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 18)
//          titleLabel.textAlignment = .center
//
//          let rightButton = UIButton(type: .system)
//          rightButton.setTitle("", for: .normal)
//          rightButton.setTitleColor(.systemBlue, for: .normal)
//         // rightButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
//
//          let spacerLeft = UIView()
//          let spacerRight = UIView()
//
//          let headerStack = UIStackView()
//          headerStack.axis = .horizontal
//          headerStack.alignment = .center
//          headerStack.distribution = .equalCentering
//          headerStack.translatesAutoresizingMaskIntoConstraints = false
//
//          headerStack.addArrangedSubview(leftButton)
//          headerStack.addArrangedSubview(titleLabel)
//          headerStack.addArrangedSubview(rightButton)
//
//          headerView.addSubview(headerStack)
//          NSLayoutConstraint.activate([
//              headerStack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//              headerStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//              headerStack.topAnchor.constraint(equalTo: headerView.topAnchor),
//              headerStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
//          ])
//
//          
//          
//          view.backgroundColor = .white
//          title = "Add Address"
//
//          scrollView.translatesAutoresizingMaskIntoConstraints = false
//          view.addSubview(scrollView)
//          NSLayoutConstraint.activate([
//              scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
//              scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//              scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//              scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
//
//          ])
//
//          contentView.axis = .vertical
//          contentView.spacing = 16
//          contentView.translatesAutoresizingMaskIntoConstraints = false
//          scrollView.addSubview(contentView)
//          NSLayoutConstraint.activate([
//              contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//              contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
//              contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
//              contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//              contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
//          ])
//
//          // Name
//          styleTextField(nameTextField)
//          nameTextField.placeholder = "Name"
//          contentView.addArrangedSubview(nameTextField)
//
//          // Phone number with country code
//          let phoneContainer = UIView()
//          phoneContainer.layer.borderColor = UIColor.lightGray.cgColor
//          phoneContainer.layer.borderWidth = 1
//         // phoneContainer.layer.cornerRadius = 0
//          phoneContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//          let phoneStack = UIStackView()
//          phoneStack.axis = .horizontal
//          phoneStack.spacing = 8
//          phoneStack.alignment = .fill
//          phoneStack.distribution = .fill
//
//          phoneStack.translatesAutoresizingMaskIntoConstraints = false
//          phoneContainer.addSubview(phoneStack)
//          NSLayoutConstraint.activate([
//              phoneStack.topAnchor.constraint(equalTo: phoneContainer.topAnchor, constant: 0),
//              phoneStack.bottomAnchor.constraint(equalTo: phoneContainer.bottomAnchor, constant: 0),
//              phoneStack.leftAnchor.constraint(equalTo: phoneContainer.leftAnchor, constant: 8),
//              phoneStack.rightAnchor.constraint(equalTo: phoneContainer.rightAnchor, constant: -8)
//          ])
//
//          let countryCodeLabel = UILabel()
//          countryCodeLabel.text = "+91"
//          countryCodeLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
//          countryCodeLabel.textAlignment = .center
//          countryCodeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
//          let countryCodeLabel1 = UILabel()
//          countryCodeLabel1.text = "|"
//          countryCodeLabel1.font = UIFont(name: ConstantFontSize.regular, size: 16)
//          countryCodeLabel1.textAlignment = .center
//          countryCodeLabel1.widthAnchor.constraint(equalToConstant: 2).isActive = true
//  //        let prefixLabel = UILabel()
//  //        prefixLabel.text = "+91 "
//  //        prefixLabel.font = UIFont(name: "HeroNew-Regular", size: 16)
//         // countryCodeLabel.sizeToFit()
//          
//          //phoneTextField.leftView = countryCodeLabel
//          phoneTextField.leftViewMode = .always
//          
//          phoneTextField.borderStyle = .none
//          phoneTextField.placeholder = "Phone Number"
//          phoneTextField.keyboardType = .numberPad
//          let phone = THUserDefaultValue.phoneNumber
//          let parsed = phone?.replacingOccurrences(of: "+91", with: "")
//
//          phoneTextField.text = parsed
//        
//          phoneStack.addArrangedSubview(countryCodeLabel)
//          phoneStack.addArrangedSubview(countryCodeLabel1)
//          phoneStack.addArrangedSubview(phoneTextField)
//          contentView.addArrangedSubview(phoneContainer)
//
//
//          // Other fields
//          [pincodeTextField, houseTextField, areaTextField].forEach {
//              styleTextField($0)
//              contentView.addArrangedSubview($0)
//          }
//
//          [nameTextField, phoneTextField, pincodeTextField, houseTextField,
//           areaTextField, cityTextField, stateTextField].forEach {
//              $0.delegate = self
//
//          }
//
//          
//          pincodeTextField.placeholder = "Pincode"
//          pincodeTextField.keyboardType = .numberPad
//          houseTextField.placeholder = "House/ Flat/ Office No."
//          areaTextField.placeholder = "Area/ Locality/ Town"
//
//          // City and State side-by-side
//          let cityStateStack = UIStackView()
//          cityStateStack.axis = .horizontal
//          cityStateStack.spacing = 8
//          cityStateStack.distribution = .fillEqually
//
//          styleTextField(cityTextField)
//          cityTextField.placeholder = "City"
//          styleTextField(stateTextField)
//          stateTextField.placeholder = "State"
//
//          cityStateStack.addArrangedSubview(cityTextField)
//          cityStateStack.addArrangedSubview(stateTextField)
//          contentView.addArrangedSubview(cityStateStack)
//
//          // Default address checkbox
//          let checkboxStack = UIStackView()
//          checkboxStack.axis = .horizontal
//          checkboxStack.spacing = 8
//          checkboxStack.alignment = .center  // Vertically center checkbox with label
//          checkboxStack.distribution = .fill
//          checkboxStack.translatesAutoresizingMaskIntoConstraints = false
//
//          defaultAddressCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
//          defaultAddressCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
//          defaultAddressCheckbox.tintColor = .black
//          defaultAddressCheckbox.addTarget(self, action: #selector(toggleDefault), for: .touchUpInside)
//          defaultAddressCheckbox.widthAnchor.constraint(equalToConstant: 24).isActive = true
//          defaultAddressCheckbox.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//          defaultAddressLabel.text = "Use this as default address."
//          defaultAddressLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
//          defaultAddressLabel.numberOfLines = 0
//
//          checkboxStack.addArrangedSubview(defaultAddressCheckbox)
//          checkboxStack.addArrangedSubview(defaultAddressLabel)
//
//          // Wrap inside container to control alignment
//          let checkboxContainer = UIView()
//          checkboxContainer.addSubview(checkboxStack)
//          NSLayoutConstraint.activate([
//              checkboxStack.topAnchor.constraint(equalTo: checkboxContainer.topAnchor),
//              checkboxStack.leadingAnchor.constraint(equalTo: checkboxContainer.leadingAnchor),
//              checkboxStack.trailingAnchor.constraint(lessThanOrEqualTo: checkboxContainer.trailingAnchor),
//              checkboxStack.bottomAnchor.constraint(equalTo: checkboxContainer.bottomAnchor)
//          ])
//
//          contentView.addArrangedSubview(checkboxContainer)
//
//
//  //        // Save Button
//  //        saveButton.setTitle("SAVE ADDRESS", for: .normal)
//  //        saveButton.setTitleColor(.white, for: .normal)
//  //        saveButton.backgroundColor = .black
//  //        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//  //        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//  //        saveButton.layer.cornerRadius = 6
//  //        saveButton.addTarget(self, action: #selector(saveAddressTapped), for: .touchUpInside)
//  //        contentView.addArrangedSubview(saveButton)
//  //
//          
//          // 1. Add Save Button to Main View (outside scrollView)
//          view.addSubview(saveButton)
//          saveButton.translatesAutoresizingMaskIntoConstraints = false
//          saveButton.setTitle("SAVE ADDRESS", for: .normal)
//          saveButton.setTitleColor(.white, for: .normal)
//          saveButton.backgroundColor = .black
//          saveButton.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 18)
//          //saveButton.layer.cornerRadius = 0
//          saveButton.addTarget(self, action: #selector(saveAddressTapped), for: .touchUpInside)
//
//          // 2. Pin Save Button to Bottom
//          NSLayoutConstraint.activate([
//              saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//              saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//              saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//              saveButton.heightAnchor.constraint(equalToConstant: 50)
//          ])
//
//      }
//    
//      @objc func backButtonTapped() {
//          navigationController?.popViewController(animated: true)
//      }
//      @objc private func keyboardWillShow(notification: Notification) {
//          guard let userInfo = notification.userInfo,
//                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//          let bottomInset = keyboardFrame.height
//          scrollView.contentInset.bottom = bottomInset
//          scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
//      }
//
//      @objc private func keyboardWillHide(notification: Notification) {
//          scrollView.contentInset.bottom = 0
//          scrollView.verticalScrollIndicatorInsets.bottom = 0
//      }
//
//      
//      private func styleTextField(_ tf: UITextField) {
//          tf.returnKeyType = .done
//          tf.borderStyle = .roundedRect
//          tf.backgroundColor = .white
//          tf.layer.borderWidth = 1
//          tf.layer.borderColor = UIColor.lightGray.cgColor
//          tf.setLeftPaddingPoints(15)
//          tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
//      }
//      
//      @objc private func toggleDefault() {
//          isDefault.toggle()
//          defaultAddressCheckbox.isSelected = isDefault
//      }
//    func moveCharacters(matching char: Character, in input: String) -> String {
//        let matched = input.filter { $0 == char }
//        let others = input.filter { $0 != char }
//        return others + matched
//    }
//      @objc private func saveAddressTapped() {
////          let name = nameTextField.text ?? ""
////          let phone = phoneTextField.text ?? ""
////          let pin = pincodeTextField.text ?? ""
////          let house = houseTextField.text ?? ""
////          let area = areaTextField.text ?? ""
////          let city = cityTextField.text ?? ""
////          let state = stateTextField.text ?? ""
////          
////          print("Saving Address:\n\(name), \(phone), \(pin), \(house), \(area), \(city), \(state), Default: \(isDefault)")
//          if edit == keyName.Edit {
//              viewmodel.validateValue(AddressId: modeldata?.id ?? "")
//          } else {
//              viewmodel.validateValue(AddressId: "")
//          }
//
//          // API call can be placed here
//      }
//      func scrollToActiveTextField(_ textField: UITextField) {
//          let convertedFrame = textField.convert(textField.bounds, to: scrollView)
//          scrollView.scrollRectToVisible(convertedFrame.insetBy(dx: 0, dy: -20), animated: true)
//      }
//      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//          textField.resignFirstResponder() // This hides the keyboard
//          return true
//      }
//
//
//      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//          let inverseSet = NSCharacterSet(charactersIn:keyName.allowedCharacter).inverted
//          let components = string.components(separatedBy: inverseSet)
//          let filtered = components.joined(separator: keyName.emptyStr)
//          let currentText = textField.text ?? keyName.emptyStr
//          
//          if textField == nameTextField || textField == houseTextField || textField == cityTextField || textField == stateTextField {
//                if filtered == string {
//                  guard let stringRange = Range(range, in: currentText) else { return false }
//                  let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//                  return updatedText.count <= 50
//              } else {
//                  if string == keyName.emptyStr {
//                      let countdots = textField.text!.components(separatedBy:keyName.separator).count - 1
//                      if countdots == 0 {
//                          return true
//                      }else{
//                          if countdots > 0 && string == keyName.separator {
//                              return false
//                          } else {
//                              return true
//                          }
//                      }
//                  }else{
//                      return false
//                  }
//              }
//              
//          } else if textField == areaTextField {
//              
//              self.initalCityCall()
//              
//                if filtered == string {
//                  guard let stringRange = Range(range, in: currentText) else { return false }
//                  let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//                  return updatedText.count <= 50
//              } else {
//                  if string == keyName.emptyStr {
//                      let countdots = textField.text!.components(separatedBy:keyName.separator).count - 1
//                      if countdots == 0 {
//                          return true
//                      }else{
//                          if countdots > 0 && string == keyName.separator {
//                              return false
//                          } else {
//                              return true
//                          }
//                      }
//                  }else{
//                      return false
//                  }
//              }
//              
//          }
//          else if  textField == phoneTextField {
//              let currentCharacterCount = phoneTextField.text?.count ?? 0
//              if (range.length + range.location > currentCharacterCount){
//                  return false
//              }
//              let newLength = currentCharacterCount + string.count - range.length
//              return newLength <= 10
//              
//          } else if  textField == pincodeTextField {
//              let currentCharacterCount = pincodeTextField.text?.count ?? 0
//              if (range.length + range.location > currentCharacterCount){
//                  return false
//              }
//              let newLength = currentCharacterCount + string.count - range.length
//              if newLength == 6 {
//                  let pincode = ((textField.text ?? "") + string)
//                  viewmodel.getPincodeApi(Pincode: pincode)
//                 // fetchCityAndState(for: pincode, apiKey: "")
//              } else {
//                  self.cityTextField.text  = ""
//                  self.stateTextField.text = ""
//              }
//              return newLength <= 6
//              
//          }
//          
//          
//          return true
//      }
//    func initalCityCall() {
//        let dataSource = ["Apple", "Mango", "Orange", "Banana", "Kiwi", "Watermelon"]
//
//        //let button = UIButton(primaryAction: nil)
//
//            let actionClosure = { (action: UIAction) in
//                print(action.title)
//            }
//
//            var menuChildren: [UIMenuElement] = []
//            for fruit in dataSource {
//                menuChildren.append(UIAction(title: fruit, handler: actionClosure))
//            }
//            
////            button.menu = UIMenu(options: .displayInline, children: menuChildren)
////            
////            button.showsMenuAsPrimaryAction = true
////            button.changesSelectionAsPrimaryAction = true
//            
////            button.frame = CGRect(x: 150, y: 200, width: 100, height: 40)
////            self.view.addSubview(button)
//    }
//    
//
//    func fetchCityAndState(for pincode: String, apiKey: String) {
//        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(pincode)&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
////        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(pincode)&components=country:IN&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                   let results = json["results"] as? [[String: Any]],
//                   let addressComponents = results.first?["address_components"] as? [[String: Any]] {
//
//                    var city: String?
//                    var state: String?
//
//                    for component in addressComponents {
//                        if let types = component["types"] as? [String] {
//                            if types.contains("locality") {
//                                self.cityTextField.text  = component["long_name"] as? String
//                            }
//                            if types.contains("administrative_area_level_1") {
//                                self.stateTextField.text  = component["long_name"] as? String
//                            }
//                        }
//                    }
//
//                    print("City: \(city ?? "Unknown")")
//                    print("State: \(state ?? "Unknown")")
//                } else {
//                    print("Invalid response format")
//                }
//            } catch {
//                print("JSON parsing error: \(error)")
//            }
//        }
//
//        task.resume()
//    }
//
//  }
//
//  // MARK: - Padding Extension
//  extension UITextField {
//      func setLeftPaddingPoints(_ amount:CGFloat) {
//          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
//          self.leftView = paddingView
//          self.leftViewMode = .always
//      }
  }

