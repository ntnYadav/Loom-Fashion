//
//  LMCartPopUpVC.swift
//  LoomApp
//
//  Created by Flucent tech on 16/05/25.
//
import UIKit

class LMNotifyVC: UIViewController {

    let containerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupContainer()
    }

    func setupContainer() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 350),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        setupContent()
    }

    func setupContent() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16

        containerView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24)
        ])

        // Title
        let titleLabel = UILabel()
        titleLabel.text = "SELECT A SIZE"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        stack.addArrangedSubview(titleLabel)

        // Subtitle
        let subtitle = UILabel()
        subtitle.text = "If the style comes back in stock, we will inform you immediately on your provided contact details"
        subtitle.font = .systemFont(ofSize: 14)
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        stack.addArrangedSubview(subtitle)

        // Size buttons
        let sizeStack = UIStackView()
        sizeStack.axis = .horizontal
        sizeStack.spacing = 16

        ["S", "M"].forEach { size in
            let btn = UIButton(type: .system)
            btn.setTitle(size, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.black.cgColor
            btn.widthAnchor.constraint(equalToConstant: 60).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
            sizeStack.addArrangedSubview(btn)
        }
        stack.addArrangedSubview(sizeStack)

        // Notify Title
        let notifyTitle = UILabel()
        notifyTitle.text = "WE WILL NOTIFY YOU"
        notifyTitle.font = .boldSystemFont(ofSize: 16)
        notifyTitle.textAlignment = .center
        stack.addArrangedSubview(notifyTitle)

        // Phone label
        let phoneLabel = UILabel()
        phoneLabel.text = "+91 9977755952"
        phoneLabel.font = .systemFont(ofSize: 15)
        phoneLabel.textColor = .darkGray
        phoneLabel.textAlignment = .center
        stack.addArrangedSubview(phoneLabel)

        // Notify Button
        let notifyBtn = UIButton(type: .system)
        notifyBtn.setTitle("NOTIFY ME", for: .normal)
        notifyBtn.backgroundColor = .black
        notifyBtn.setTitleColor(.white, for: .normal)
        notifyBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        notifyBtn.layer.cornerRadius = 4

        containerView.addSubview(notifyBtn)
        notifyBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notifyBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            notifyBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            notifyBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            notifyBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

