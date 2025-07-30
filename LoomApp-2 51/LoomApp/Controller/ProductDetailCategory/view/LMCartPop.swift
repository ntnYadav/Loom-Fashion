import UIKit

class LMCartPop: UIViewController {
    var onSelected: ((String) -> Void)?


        let containerView = UIView()
        let contentHolderView = UIView()
        let cartImageView = UIImageView()
        let successLabel = UILabel()
        let viewBagButton = UIButton()
        let backgroundView = UIView()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupActions()
            animatePopupIn()
        }

        func setupUI() {
            view.backgroundColor = .clear

            // Dimmed background
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(backgroundView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            // Popup container pinned to bottom
            view.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.backgroundColor = UIColor.systemGray6
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // Changed to bottomAnchor
                containerView.heightAnchor.constraint(equalToConstant: 200)
            ])

            // Content holder inside popup
            containerView.addSubview(contentHolderView)
            contentHolderView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentHolderView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
                contentHolderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                contentHolderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                contentHolderView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

            // Cart image
            cartImageView.image = UIImage(systemName: "cart.fill")
            cartImageView.tintColor = .black
            cartImageView.translatesAutoresizingMaskIntoConstraints = false
            contentHolderView.addSubview(cartImageView)

            // Success label
            successLabel.text = "Added To Cart Successfully"
            successLabel.textColor = .darkGray
            successLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            successLabel.textAlignment = .center
            successLabel.translatesAutoresizingMaskIntoConstraints = false
            contentHolderView.addSubview(successLabel)

            // View bag button
            viewBagButton.setTitle("VIEW BAG", for: .normal)
            viewBagButton.setTitleColor(.white, for: .normal)
            viewBagButton.backgroundColor = .black
            viewBagButton.layer.cornerRadius = 0
            viewBagButton.translatesAutoresizingMaskIntoConstraints = false
            contentHolderView.addSubview(viewBagButton)

            // Layout content
            NSLayoutConstraint.activate([
                // Button 30pt above bottom
                viewBagButton.bottomAnchor.constraint(equalTo: contentHolderView.bottomAnchor, constant: -30),
                viewBagButton.leadingAnchor.constraint(equalTo: contentHolderView.leadingAnchor, constant: 16),
                viewBagButton.trailingAnchor.constraint(equalTo: contentHolderView.trailingAnchor, constant: -16),
                viewBagButton.heightAnchor.constraint(equalToConstant: 44),

                // Label above button
                successLabel.bottomAnchor.constraint(equalTo: viewBagButton.topAnchor, constant: -20),
                successLabel.centerXAnchor.constraint(equalTo: contentHolderView.centerXAnchor),

                // Image above label
                cartImageView.bottomAnchor.constraint(equalTo: successLabel.topAnchor, constant: -20),
                cartImageView.centerXAnchor.constraint(equalTo: contentHolderView.centerXAnchor),
                cartImageView.widthAnchor.constraint(equalToConstant: 50),
                cartImageView.heightAnchor.constraint(equalToConstant: 50),
            ])
        }

        func setupActions() {
            viewBagButton.addTarget(self, action: #selector(viewBagButtonTapped), for: .touchUpInside)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
            backgroundView.addGestureRecognizer(tapGesture)
        }

        @objc func viewBagButtonTapped() {
            onSelected?("")
            self.navigationController?.popViewController(animated: true)
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: 250)
                self.backgroundView.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: false)
            })        }

        @objc func backgroundTapped() {
            dismissPopup()
        }

        func dismissPopup() {
            self.navigationController?.popViewController(animated: true)
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: 250)
                self.backgroundView.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: false)
            })
        }

        func animatePopupIn() {
            containerView.transform = CGAffineTransform(translationX: 0, y: 250)
            backgroundView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.containerView.transform = .identity
                self.backgroundView.alpha = 1
            }
        }
    }


