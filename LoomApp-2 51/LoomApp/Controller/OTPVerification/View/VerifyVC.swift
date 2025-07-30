//
//  tranparentLogin.swift
//  LoomApp
//
//  Created by Flucent tech on 28/04/25.
//

import UIKit

class VerifyVC: UIViewController, UITextFieldDelegate {

  
        lazy private var viewmodel = VerifyVM(hostController: self)
        private let containerView = UIView()
        private let headerLabel = UILabel()
        var otpFields: [UITextField] = []
        private let resendButton = UIButton(type: .system)
        private var timer: Timer?
        private var remainingTime = 60
        private let loader = UIActivityIndicatorView(style: .medium)
    private let resendLabel = UILabel()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupContainer()
            setupHeader()
            setupOTPFields()
            setupLoader()
            setupResendButton()
            startTimer()
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
            timer?.invalidate()
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

        private func setupHeader() {
            headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
            headerLabel.text = "Enter OTP"
            headerLabel.textAlignment = .center
            containerView.addSubview(headerLabel)
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
                headerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
        }

        private func setupOTPFields() {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            
            for _ in 0..<5 {
                let field = UITextField()
                field.textAlignment = .center
                field.font = UIFont(name: "HeroNew-Regular", size: 16)
                field.layer.borderWidth = 0.3
                field.layer.borderColor = UIColor.lightGray.cgColor
                field.leftViewMode = .always
                field.borderStyle = .roundedRect
                field.keyboardType = .numberPad
                field.delegate = self
                
                otpFields.append(field)
                stackView.addArrangedSubview(field)
            }
            
            containerView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
                stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
                stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
                stackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        private func setupLoader() {
            loader.hidesWhenStopped = true
            containerView.addSubview(loader)
            loader.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                loader.topAnchor.constraint(equalTo: otpFields[0].superview!.bottomAnchor, constant: 20),
                loader.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
        }

    private func setupResendButton() {
        resendButton.backgroundColor = .clear
        resendLabel.font = UIFont(name: "HeroNew-Regular", size: 18)
        resendLabel.textColor = .gray
        resendLabel.text = "Resend OTP in 60s"
        resendButton.addSubview(resendLabel)

        resendButton.isEnabled = false
        resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)

        containerView.addSubview(resendButton)
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            resendButton.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 20),
            resendButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            resendLabel.centerXAnchor.constraint(equalTo: resendButton.centerXAnchor),
            resendLabel.centerYAnchor.constraint(equalTo: resendButton.centerYAnchor)
        ])
    }
//        private func setupResendButton() {
//            resendButton.titleLabel?.font = UIFont(name: "HeroNew-Regular", size: 18)
//            resendButton.setTitle("Resend OTP in 60s", for: .normal)
//            resendButton.setTitleColor(.gray, for: .normal)
//            resendButton.isEnabled = false
//            resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
//            
//            containerView.addSubview(resendButton)
//            resendButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                resendButton.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 20),
//                resendButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
//            ])
//        }

        private func startTimer() {
            resendButton.isEnabled = false
            resendLabel.text = "Resend OTP in \(remainingTime)s"

//            resendButton.setTitle("Resend OTP in \(remainingTime)s", for: .normal)
            resendButton.setTitleColor(.gray, for: .normal)
            resendLabel.textColor = .gray

               // Change OTP field text color while timer is running
               otpFields.forEach { $0.textColor = .black }

            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateResendTimer), userInfo: nil, repeats: true)
        }

        @objc private func updateResendTimer() {
            remainingTime -= 1
           // resendButton.setTitle("Resend OTP in \(remainingTime)s", for: .normal)
            resendLabel.text = "Resend OTP in \(remainingTime)s"
            let fullText = "Resend OTP in \(remainingTime)s"
              let attributedString = NSMutableAttributedString(string: fullText)

              if let range = fullText.range(of: "\(remainingTime)s") {
                  let nsRange = NSRange(range, in: fullText)
                  attributedString.addAttribute(.foregroundColor, value: ConstantColour.colorDone, range: nsRange)
              }

              resendLabel.attributedText = attributedString
            if remainingTime <= 0 {
                timer?.invalidate()

                resendLabel.text = "Resend OTP"
                resendLabel.textColor = .black
                resendButton.isEnabled = true
                //startBlinkingLabel()
                otpFields.forEach { $0.textColor = .black }

            }
        }
    private func startBlinkingLabel() {
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
            self.resendLabel.alpha = 0.0
        })
    }
    private func stopBlinkingLabel() {
        resendLabel.layer.removeAllAnimations()
        resendLabel.alpha = 1.0
    }
        @objc private func resendTapped() {
            print("Resend OTP tapped")
            remainingTime = 60
            startTimer()
           // simulateOTPInput()
            guard let phone = THUserDefaultValue.phoneNumber else { return }

            viewmodel.hitresendApi(PhoneNo: phone, isResend: true)

        }
    
   
        // MARK: - Simulate OTP autofill
        private func simulateOTPInput() {
            let otp = "12345"
            for (index, char) in otp.enumerated() {
                if index < otpFields.count {
                    otpFields[index].text = String(char)
                }
            }
            loader.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loader.stopAnimating()
                let otpString = self.otpFields.compactMap { $0.text }.joined()
                print("OTP Submitted: \(otpString)")
                self.viewmodel.validateValue(otp: otpString)
            }
        }

        // MARK: - OTP manual entry
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, (text + string).count > 1 {
                return false
            }
            
            if string.count == 1 {
                if let currentIndex = otpFields.firstIndex(of: textField), currentIndex < otpFields.count - 1 {
                    otpFields[currentIndex + 1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                    let otpString = otpFields.compactMap { $0.text }.joined()
                    loader.startAnimating()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.loader.stopAnimating()
                        self.viewmodel.validateValue(otp: otpString + string)
                    }
                }
                textField.text = string
                return false
            } else if string.isEmpty {
                if let currentIndex = otpFields.firstIndex(of: textField), currentIndex > 0 {
                    otpFields[currentIndex - 1].becomeFirstResponder()
                }
                textField.text = ""
                return false
            }

            return true
        }
    }

    
  //  class HalfScreenViewController: UIViewController {
//
//        lazy private var viewmodel = VerifyVM(hostController: self)
//        private let containerView = UIView()
//        private let headerLabel = UILabel()
//        var otpFields: [UITextField] = []
//        private let resendButton = UIButton(type: .system)
//        private var timer: Timer?
//        private var remainingTime = 60
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            setupBackground()
//            setupContainer()
//            setupHeader()
//            setupOTPFields()
//            setupResendButton()
//            startTimer()
//        }
//        
//        deinit {
//            timer?.invalidate()
//        }
//        
//        private func setupBackground() {
//            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        }
//    private func setupOTPFields() {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.distribution = .fillEqually
//        
//        for _ in 0..<5 {
//            let field = UITextField()
//            field.textAlignment = .center
//            field.font = UIFont(name: "HeroNew-Regular", size: 16)
//            field.layer.borderWidth = 0.3
//            field.layer.borderColor = UIColor.lightGray.cgColor
//            field.leftViewMode = .always
//            field.borderStyle = .roundedRect
//            field.keyboardType = .numberPad
//            field.delegate = self
//            
//            otpFields.append(field)
//            stackView.addArrangedSubview(field)
//        }
//        
//        containerView.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
//            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
//            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
//            stackView.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//        private func setupContainer() {
//            containerView.backgroundColor = .white
//            containerView.layer.cornerRadius = 16
//            containerView.clipsToBounds = true
//            view.addSubview(containerView)
//            containerView.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
//                containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
//                containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
//                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        }
//        
//        private func setupHeader() {
//            headerLabel.font = UIFont(name: "HeroNew-Regular", size: 24)
//            headerLabel.text = "Enter OTP"
//            headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
//            headerLabel.textAlignment = .center
//            
//            containerView.addSubview(headerLabel)
//            headerLabel.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
//                headerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
//            ])
//        }
//        
////        private func setupOTPFields() {
////            let stackView = UIStackView()
////            stackView.axis = .horizontal
////            stackView.spacing = 10
////            stackView.distribution = .fillEqually
////            
////            for _ in 0..<5 {
////                let field = UITextField()
////                field.textAlignment = .center
////                field.font = UIFont.systemFont(ofSize: 22)
////                field.borderStyle = .roundedRect
////                field.keyboardType = .numberPad
////                otpFields.append(field)
////                stackView.addArrangedSubview(field)
////            }
////            
////            containerView.addSubview(stackView)
////            stackView.translatesAutoresizingMaskIntoConstraints = false
////            
////            NSLayoutConstraint.activate([
////                stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
////                stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
////                stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
////                stackView.heightAnchor.constraint(equalToConstant: 50)
////            ])
////        }
//        
//        private func setupResendButton() {
//            resendButton.titleLabel?.font = UIFont(name: "HeroNew-Regular", size: 18)
//            resendButton.setTitle("Resend OTP in 60s", for: .normal)
//            resendButton.setTitleColor(.gray, for: .normal)
//            resendButton.isEnabled = false
//            resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
//            
//            containerView.addSubview(resendButton)
//            resendButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                resendButton.topAnchor.constraint(equalTo: otpFields[0].superview!.bottomAnchor, constant: 30),
//                resendButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
//            ])
//        }
//        
//        private func startTimer() {
//            resendButton.isEnabled = false
//            resendButton.setTitle("Resend OTP in \(remainingTime)s", for: .normal)
//            resendButton.setTitleColor(.gray, for: .normal)
//            
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateResendTimer), userInfo: nil, repeats: true)
//        }
//        
//        @objc private func updateResendTimer() {
//            remainingTime -= 1
//            resendButton.setTitle("Resend OTP in \(remainingTime)s", for: .normal)
//            
//            if remainingTime <= 0 {
//                timer?.invalidate()
//                resendButton.setTitle("Resend OTP", for: .normal)
//                resendButton.setTitleColor(.systemBlue, for: .normal)
//                resendButton.isEnabled = true
//            }
//        }
//        
//        @objc private func resendTapped() {
//            print("Resend OTP tapped")
//            remainingTime = 60
//            startTimer()
//            
//            // Call API to resend OTP here if needed
//        }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text, (text + string).count > 1 {
//            return false
//        }
//        
//        if string.count == 1 { // when user type a number
//            if let currentIndex = otpFields.firstIndex(of: textField), currentIndex < otpFields.count - 1 {
//                otpFields[currentIndex + 1].becomeFirstResponder()
//            } else {
//                textField.resignFirstResponder() // last textfield resign keyboard
//                let otpString = otpFields.compactMap { $0.text }.joined()
//                print("OTP: \(otpString)")
//                viewmodel.validateValue(otp: (otpString + string))
//
//            }
//            textField.text = string
//            return false
//        } else if string.isEmpty { // when user press backspace
//            if let currentIndex = otpFields.firstIndex(of: textField), currentIndex > 0 {
//                otpFields[currentIndex - 1].becomeFirstResponder()
//            }
//            textField.text = ""
//            return false
//        }
//        
//        return true
//    }
//
//    }

