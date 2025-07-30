//
//  POp.swift
//  
//
//  Created by Flucent tech on 08/05/25.
//

import UIKit

class LogoutBottomSheetVC: UIViewController {
    
    var onYesTapped: (() -> Void)?
    var onNoTapped: (() -> Void)?

    private let containerView = UIView()
    private let messageLabel = UILabel()
    private let yesButton = UIButton(type: .system)
    private let noButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupContainer()
        setupMessage()
        setupButtons()
    }

    private func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        view.addGestureRecognizer(tap)
    }

    private func setupContainer() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 0
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    private func setupMessage() {
        messageLabel.text = "Are you sure you want to log out of your account?"
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)

        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }

    private func setupButtons() {
        yesButton.setTitle("YES", for: .normal)
        yesButton.layer.borderWidth = 1
        yesButton.layer.borderColor = UIColor.black.cgColor
        yesButton.setTitleColor(.black, for: .normal)
        yesButton.addTarget(self, action: #selector(yesTapped), for: .touchUpInside)

        noButton.setTitle("NO", for: .normal)
        noButton.backgroundColor = .black
        noButton.setTitleColor(.white, for: .normal)
        noButton.addTarget(self, action: #selector(noTapped), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [yesButton, noButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually

        containerView.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func yesTapped() {
            dismiss(animated: true) {
                self.onYesTapped?()
        }
    }

    @objc private func noTapped() {
        dismiss(animated: true) {
            self.onNoTapped?()
        }

      
    }

    @objc private func dismissSheet() {
        dismiss(animated: true, completion: nil)
    }
}
