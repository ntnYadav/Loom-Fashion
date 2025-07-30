//
//  dele.swift
//  LoomApp
//
//  Created by Flucent tech on 08/05/25.
//

import UIKit

class LMPincodeVC: UIViewController,UITextFieldDelegate {

    
        var onApplyTapped: ((String, [String]?) -> Void)?
        lazy private var viewmodel = LMPincodeVM(hostController: self)
        var dimensions11: Dimensions? = nil
        var widgthKM11:Double = 30.0
        private let containerView = UIView()
        private let textField = UITextField()
         let infoLabel = UILabel()
        private let applyButton = UIButton(type: .system)
        private let customKeyboardView = UIView()

        private var containerBottomConstraint: NSLayoutConstraint?

        override func viewDidLoad() {
            super.viewDidLoad()
            infoLabel.text = ""
            setupKeyboardObservers()
            setupBackground()
            setupContainer()
            setupTextField()
            setupApplyButton()
            setupCustomKeyboard()
            infoLabel.text = ""

        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            textField.delegate = self
            textField.inputView = UIView() // Disable system keyboard
            textField.becomeFirstResponder()
        }

        private func setupBackground() {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc private func backgroundTapped(_ gesture: UITapGestureRecognizer) {
            let location = gesture.location(in: view)
            if !containerView.frame.contains(location) {
                dismiss(animated: true, completion: nil)
            }
        }

        private func setupContainer() {
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 0
            containerView.clipsToBounds = true
            view.addSubview(containerView)

            containerView.translatesAutoresizingMaskIntoConstraints = false
           // containerBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            containerBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -0)

            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerBottomConstraint!,
                containerView.heightAnchor.constraint(equalToConstant: 370)
            ])
        }

        private func setupTextField() {
            textField.placeholder = "Enter Pincode"
            textField.borderStyle = .roundedRect
            textField.clearButtonMode = .whileEditing
            containerView.addSubview(textField)

            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
                textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                textField.heightAnchor.constraint(equalToConstant: 44)
            ])

            infoLabel.text = ""
            infoLabel.textColor = .red
            infoLabel.font = UIFont.systemFont(ofSize: 14)
            containerView.addSubview(infoLabel)
            infoLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                infoLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
                infoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                infoLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        }

        private func setupApplyButton() {
            applyButton.setTitle("APPLY", for: .normal)
            applyButton.setTitleColor(.white, for: .normal)
            applyButton.backgroundColor = .black
            applyButton.layer.cornerRadius = 8
            applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)

            containerView.addSubview(applyButton)
            applyButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                applyButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
                applyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                applyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                applyButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }

        private func setupCustomKeyboard() {
            customKeyboardView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(customKeyboardView)

            NSLayoutConstraint.activate([
                customKeyboardView.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 20),
                customKeyboardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                customKeyboardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                customKeyboardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            ])

            let buttonTitles: [[String]] = [
                ["1", "2", "3"],
                ["4", "5", "6"],
                ["7", "8", "9"],
                [".", "0", "X"]
            ]

            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            customKeyboardView.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: customKeyboardView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: customKeyboardView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: customKeyboardView.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: customKeyboardView.bottomAnchor)
            ])

            for row in buttonTitles {
                let rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.spacing = 10
                rowStack.distribution = .fillEqually

                for title in row {
                    let button = UIButton(type: .system)
                    button.setTitle(title, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = .darkGray
                    button.layer.cornerRadius = 8
                    button.addTarget(self, action: #selector(keyboardButtonTapped(_:)), for: .touchUpInside)
                    rowStack.addArrangedSubview(button)
                }

                stackView.addArrangedSubview(rowStack)
            }
        }

        @objc private func keyboardButtonTapped(_ sender: UIButton) {
            guard let input = sender.currentTitle else { return }

            if input == "X" {
                textField.text = String(textField.text?.dropLast() ?? "")
            } else {
                let current = textField.text ?? ""
                if current.count < 6 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input)) {
                    textField.text = current + input
                }
            }
        }

        // MARK: - Keyboard Handling

        private func setupKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        @objc private func keyboardWillShow(notification: Notification) {
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                  let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

            let bottomInset = view.safeAreaInsets.bottom
            containerBottomConstraint?.constant = -keyboardFrame.height + bottomInset

            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }

        @objc private func keyboardWillHide(notification: Notification) {
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
            containerBottomConstraint?.constant = 0

            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }

        // MARK: - Actions

        @objc private func applyTapped() {
            let pin = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
            
            if pin == "" {
                infoLabel.textColor = .red
                infoLabel.text = "Please enter the pincode"
                return
            }

            guard pin.count == 6, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: pin)) else {
                infoLabel.textColor = .red
                infoLabel.text = "Please enter a valid 6-digit pincode"
                return
            }

            infoLabel.textColor = .darkGray
            infoLabel.text = ""//Please enter the pincode code"
            //dimensions: Optional(LoomApp.Dimensions(lengthCm: 10, widthCm: 5, heightCm: 10)), weightInKg: Optional(0.7)
            let safeWeight = (dimensions11?.widthCm ?? 0.0) > 0 ? dimensions11?.widthCm ?? 0.5 : 0.5
            let safeHeight = (dimensions11?.heightCm ?? 0.0) > 0 ? dimensions11?.heightCm ?? 2.0 : 2.0
            let safeLength = (dimensions11?.lengthCm ?? 0.0) > 0 ? dimensions11?.lengthCm ?? 30.0 : 30.0
            let safeBreadth = (widgthKM11) > 0 ? widgthKM11 ?? 30.0 : 30.0
            print("dimensions11?.widthCm==\(safeBreadth)==\(safeLength)===\(safeHeight)==\(safeWeight)")
            print("dimensions11?.widthCm==\(dimensions11)")
            viewmodel.validateValue1(
                Pincode: pin,
                weight: safeWeight,
                height: safeHeight,
                breadth: safeBreadth,
                length: safeLength
            )
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }
