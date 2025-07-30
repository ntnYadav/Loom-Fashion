//
//  LMAlertViewADDtoCartVC.swift
//  LoomApp
//
//  Created by Flucent tech on 21/05/25.
//
import UIKit


class LMAlertViewADDtoCartVC: UIViewController {



        private let backgroundView = UIView()
        private let contentView = UIView()

        private let imageView: UIImageView = {
            let iv = UIImageView(image: UIImage(systemName: "chartImage"))
            iv.contentMode = .scaleAspectFit
            iv.tintColor = .systemPink
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()

        private let label: UILabel = {
            let label = UILabel()
            label.text = "Enjoy exclusive benefits!"
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont(name: ConstantFontSize.regular, size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let actionButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Get Started", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = 0
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupBackground()
            setupContent()
            setupDismissGesture()
        }

        private func setupBackground() {
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.addSubview(backgroundView)

            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }

        private func setupContent() {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 16
            contentView.clipsToBounds = true
            view.addSubview(contentView)

            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            // Add subviews
            contentView.addSubview(imageView)
            contentView.addSubview(label)
            contentView.addSubview(actionButton)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
                imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 80),
                imageView.widthAnchor.constraint(equalToConstant: 80),

                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

                actionButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
                actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                actionButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        private func setupDismissGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
            backgroundView.addGestureRecognizer(tapGesture)
        }

        @objc private func dismissSelf() {
            dismiss(animated: true)
        }
    }
