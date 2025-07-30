import UIKit

class LMContactDetailsVC: UIViewController, UITextFieldDelegate {
    
    private let containerView = UIView()
    private let headerLabel = UILabel()
     let nameTextField = UITextField()
     let phoneTextField = UITextField()
     let emailTextField = UITextField()
    private let continueButton = UIButton(type: .system)
    private let bottomLabel = UILabel()
    
    
    private let otpLoader = UIActivityIndicatorView(style: .large)
    private let otpTextField = UITextField()
    private let resendButton = UIButton(type: .system)
    private var resendTimer: Timer?
    private var remainingSeconds = 30
    private let timerLabel = UILabel()
    
    
    lazy private var viewmodel = LMContactVM(hostController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        nameTextField.returnKeyType = .next
        emailTextField.returnKeyType = .done

        
        setupUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                                  name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                                  name: UIResponder.keyboardWillHideNotification, object: nil)
           
           let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           view.addGestureRecognizer(tap)
        
        guard let phoneNumber = THUserDefaultValue.phoneNumber else {
            return
        }
            self.phoneTextField.text = phoneNumber
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
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        // Only shift up if view hasn't already moved
        if self.containerView.transform == .identity {
            UIView.animate(withDuration: 0.3) {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height / 2)
            }
        }
    }
    private func showOTPLoaderAndResend() {
        otpLoader.startAnimating()
        containerView.addSubview(otpLoader)
        otpLoader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otpLoader.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            otpLoader.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 20)
        ])

        // Simulate API call delay (e.g., 2 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.otpLoader.stopAnimating()
            self.otpLoader.removeFromSuperview()
            self.showOTPInputAndResend()
        }
    }
    private func showOTPInputAndResend() {
        otpTextField.placeholder = "Enter OTP"
        otpTextField.borderStyle = .roundedRect
        otpTextField.textAlignment = .center
        otpTextField.keyboardType = .numberPad
        otpTextField.font = UIFont(name: "HeroNew-Regular", size: 16)

        resendButton.setTitle("Resend OTP", for: .normal)
        resendButton.setTitleColor(.gray, for: .normal)
        resendButton.isEnabled = false
        resendButton.addTarget(self, action: #selector(resendOTP), for: .touchUpInside)

        timerLabel.font = UIFont.systemFont(ofSize: 14)
        timerLabel.textColor = .gray
        updateTimerLabel()

        let otpStack = UIStackView(arrangedSubviews: [otpTextField, resendButton, timerLabel])
        otpStack.axis = .vertical
        otpStack.spacing = 12
        otpStack.alignment = .center

        containerView.addSubview(otpStack)
        otpStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otpStack.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 20),
            otpStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            otpTextField.widthAnchor.constraint(equalToConstant: 120),
        ])

        startResendTimer()
    }
    private func updateTimerLabel() {
        timerLabel.text = "Resend in \(remainingSeconds)s"
    }
    private func startResendTimer() {
        remainingSeconds = 30
        resendTimer?.invalidate()
        resendTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.remainingSeconds -= 1
            self.updateTimerLabel()
            if self.remainingSeconds <= 0 {
                self.resendTimer?.invalidate()
                self.resendButton.isEnabled = true
                self.resendButton.setTitleColor(.systemBlue, for: .normal)
                self.timerLabel.text = "You can now resend OTP"
            }
        }
    }

    @objc private func resendOTP() {
        // Call resend OTP API
        resendButton.isEnabled = false
        resendButton.setTitleColor(.gray, for: .normal)
        startResendTimer()
    }
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent background
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 0
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        headerLabel.text = "Contact Details"
        headerLabel.textColor = .black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 26)
        headerLabel.textAlignment = .center

        nameTextField.font = UIFont(name: "HeroNew-Regular", size: 16)
        nameTextField.layer.borderWidth = 0.3
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.backgroundColor = .white
        nameTextField.placeholder = "Enter name"
        nameTextField.leftViewMode = .always
        nameTextField.borderStyle = .roundedRect

        phoneTextField.font = UIFont(name: "HeroNew-Regular", size: 16)
        phoneTextField.layer.borderWidth = 0.3
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.backgroundColor = .white
        phoneTextField.keyboardType = .numberPad
        phoneTextField.placeholder = "Enter phone no"
        phoneTextField.leftViewMode = .always
        phoneTextField.isUserInteractionEnabled = false
        phoneTextField.borderStyle = .roundedRect
        
        emailTextField.font = UIFont(name: "HeroNew-Regular", size: 16)
        emailTextField.layer.borderWidth = 0.3
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Enter email address"
        emailTextField.leftViewMode = .always
        emailTextField.borderStyle = .roundedRect
        
        
        
        [nameTextField, phoneTextField, emailTextField].forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 0
            $0.setLeftPaddingPoints(10)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.delegate = self
        }
        
        let prefixLabel = UILabel()
        prefixLabel.text = "  +91 | "
        prefixLabel.font = UIFont(name: "HeroNew-Regular", size: 16)
        prefixLabel.sizeToFit()
        
        phoneTextField.leftView = prefixLabel
        phoneTextField.leftViewMode = .always
        phoneTextField.keyboardType = .numberPad
        
        continueButton.titleLabel?.font = UIFont(name: "HeroNew-Regular", size: 18)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .black
        continueButton.layer.cornerRadius = 0
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomLabel.font = UIFont(name: "HeroNew-Regular", size: 14)
        bottomLabel.text = "By continuing, you agree to our Terms."
        bottomLabel.textColor = .gray
        bottomLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [headerLabel, nameTextField, phoneTextField, emailTextField, continueButton, bottomLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        
        containerView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            stack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
        ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()  // move to next field
        } else if textField == emailTextField {
 
            textField.resignFirstResponder()   // hide keyboard
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
        let ACCEPTABLE_CHARACTERS1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.1234567890-"

        
        if textField == nameTextField  {

            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")

                return (string == filtered)
     
        }
        if textField == emailTextField  {

            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS1).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")

                return (string == filtered)
     
        }
        
        return true
    }
    
    @objc private func continueTapped() {
        view.endEditing(true)
        viewmodel.validateValue()
    }
    
    @IBAction func actSigin(_ sender: Any) {
        
    }
}


