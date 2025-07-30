//
//  dele.swift
//  LoomApp
//
//  Created by Flucent tech on 08/05/25.
//

import UIKit

class DeleteAccountBottomSheetVC: UIViewController {

    var onDeleteTapped: (() -> Void)?
    var onKeepTapped: (() -> Void)?

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    private let deleteButton = UIButton(type: .system)
    private let keepButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupContainer()
        setupTitle()
        setupInfoText()
        setupButtons()
    }

    private func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        view.addGestureRecognizer(tap)
    }

    private func setupContainer() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

    private func setupTitle() {
        let dragIndicator = UIView()
        dragIndicator.backgroundColor = .black
        dragIndicator.layer.cornerRadius = 2.5
        containerView.addSubview(dragIndicator)
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            dragIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicator.widthAnchor.constraint(equalToConstant: 40),
            dragIndicator.heightAnchor.constraint(equalToConstant: 5)
        ])

        titleLabel.text = "Are you sure you want to delete this account?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: dragIndicator.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }

    private func setupInfoText() {
        infoLabel.text = """
1. You will lose access to your order history, saved details, wishlist, reward points, and any other account-related information upon deletion.
2. Any pending orders, refunds, exchanges, or grievances will not be accessible once the account is deleted.
3. LOOM FASHION reserves the right to refuse or delay deletion in case of unresolved issues such as pending orders, shipments, cancellations, or any other service-related matters.
4. New User Coupons may not be extended if an account is created using the same mobile number or ID.
"""
        infoLabel.font = UIFont.systemFont(ofSize: 13)
        infoLabel.numberOfLines = 0

        containerView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            infoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }

    private func setupButtons() {
        deleteButton.setTitle("DELETE", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)

        keepButton.setTitle("KEEP", for: .normal)
        keepButton.setTitleColor(.white, for: .normal)
        keepButton.backgroundColor = .black
        keepButton.addTarget(self, action: #selector(keepTapped), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [deleteButton, keepButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually

        containerView.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func deleteTapped() {
        dismiss(animated: true) {
            self.onDeleteTapped?()
        }
    }

    @objc private func keepTapped() {
        dismiss(animated: true) {
            self.onKeepTapped?()
        }
    }

    @objc private func dismissSheet() {
        dismiss(animated: true, completion: nil)
    }
}
