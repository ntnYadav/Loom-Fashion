import UIKit
class LoginVC: UIViewController,UITextFieldDelegate {
    
    private let containerView = UIView()
    private let headerLabel = UILabel()
    private let infoLabel = UILabel()
    let phoneTextField = UITextField()
    private let verifyButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    lazy private var viewmodel = LoginVM(hostController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupContainer()
        setupCancelButton()
        setupHeader()
        setupInfoLabel()
        setupPhoneTextField()
        setupVerifyButton()
        setupKeyboardObservers()
        addTapGestureToDismissKeyboard() // Dismiss keyboard on tap
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setupContainer() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 0
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("", for: .normal)
        cancelButton.setTitleColor(ConstantColour.colorDone, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        containerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            cancelButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16)
        ])
    }
    
    private func setupHeader() {
        headerLabel.text = "LOGIN OR SIGNUP"
        headerLabel.font = UIFont(name: "HeroNew-Regular", size: 20)
        headerLabel.textAlignment = .center

        containerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func setupInfoLabel() {
        infoLabel.text = "Enter your phone number to receive OTP"
        infoLabel.font = UIFont(name: "HeroNew-Regular", size: 16)
        infoLabel.textAlignment = .left
        infoLabel.textColor = .darkGray
        
        containerView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 24),
            infoLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func setupPhoneTextField() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        let codeLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 40, height: 44))
        codeLabel.text = "+91 |"
        codeLabel.textAlignment = .left
        codeLabel.font = UIFont(name: "HeroNew-Regular", size: 16)
        leftView.addSubview(codeLabel)
        
        phoneTextField.leftView = leftView
        phoneTextField.leftViewMode = .always
        phoneTextField.placeholder = "Enter phone number"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .numberPad
        phoneTextField.font = UIFont(name: "HeroNew-Regular", size: 16)

        phoneTextField.layer.cornerRadius = 0
        phoneTextField.layer.borderWidth = 0.3
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.backgroundColor = .white
        phoneTextField.delegate = self
        containerView.addSubview(phoneTextField)
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            phoneTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            phoneTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupVerifyButton() {
        verifyButton.setTitle("SEND OTP", for: .normal)
        verifyButton.titleLabel?.font = UIFont(name: "HeroNew-Regular", size: 18)
        verifyButton.setTitleColor(.white, for: .normal)
        verifyButton.backgroundColor = .black
        verifyButton.layer.cornerRadius = 0
        verifyButton.addTarget(self, action: #selector(verifyTapped), for: .touchUpInside)
        
        containerView.addSubview(verifyButton)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verifyButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 40), // Increased space here
            verifyButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            verifyButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            verifyButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func backgroundTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil) // Dismiss the popup
        } else {
            view.endEditing(true) // Just dismiss keyboard
        }
    }

    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func validateValue(){
        guard checkInternet else{
            return
        }
        let phoneNumber = phoneTextField.text!
        if phoneTextField.text!.isEmpty {
            self.showToastView(message: keyName.phoneNumber)
        } else if phoneNumber.count != 10 {
            self.showToastView(message: keyName.validPhoneNumber)
            return
        } else {
            viewmodel.validateValue()
        }
    }
    
    @objc private func verifyTapped() {
        validateValue()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height - 90
        
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight / 2)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
    // MARK:- Text Field Delegate Method (Phone No)
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if string.isEmpty { return true } // Accepting control characters
           
           let newText = (phoneTextField.text! as NSString).replacingCharacters(in: range, with: string)
           
           // Allow numeric input only and restrict to 10 digits
           if newText.count > 10 || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
               return false
           }
           return true
       }
}

extension UIView {
    func shake(duration: CFTimeInterval = 0.5, pathLength: CGFloat = 10) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-pathLength, pathLength, -pathLength * 0.7, pathLength * 0.7, -pathLength * 0.4, pathLength * 0.4, 0]
        layer.add(animation, forKey: "shake")
    }
}
