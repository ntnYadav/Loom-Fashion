//
//  LMCartEmptyVC.swift
//  LoomApp
//
//  Created by Flucent tech on 22/05/25.
//

//
import UIKit

class LMCartEmptyVC: UIViewController {


////Bag screen
        // MARK: - UI Elements

        /// Custom top header view with two buttons
        private let topHeaderView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            // Optionally, set a background color if needed:
            view.backgroundColor = .white
            return view
        }()
        
        /// Back button on the left of the header
        private let backButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(named: "back") // Replace with your back image asset name
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(backdismiss), for: .touchUpInside)
            
            return button
        }()
    /// Title label below the bag image
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "BAG"
        label.font = UIFont(name: ConstantFontSize.Bold, size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        /// Heart (wishlist) button on the right of the header
        private let heartButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(named: "heart_image") // Replace with your heart image asset name
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.backgroundColor = .white

            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        /// Image view showing your bag (middle content)
        private let bagImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "bag_image") // Replace with your bag image asset name
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        /// Title label below the bag image
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "YOUR BAG IS EMPTY"
            label.font = UIFont(name: "HeroNew-bold", size: 18)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        /// Description label with further details
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Your cart is waiting for some stylish finds. Start adding items or check your wishlist."
            label.font = UIFont.systemFont(ofSize: 14)

           // label.font = UIFont(name: "HeroNew-Regular", size: 8)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = UIColor.darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        /// Button: Add From Wishlist
        private let wishlistButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("ADD FROM WISHLIST", for: .normal)
            button.titleLabel?.font = UIFont(name: "HeroNew-Thin", size: 19)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
            return button
        }()
        
        /// Button: Start Shopping
        private let shopButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("START SHOPPING", for: .normal)
            button.titleLabel?.font = UIFont(name: "HeroNew-regular", size: 19)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(wishlistButtonTapped), for: .touchUpInside)
            

            return button
        }()
        
        /// Container view for the bottom buttons (to keep them together)
        private let bottomButtonContainer: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 15
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        // MARK: - Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            setupTopHeader()
            setupContent()
            setupBottomButtons()
        }
        
        // MARK: - Setup Functions
        
    private func setupTopHeader() {
            view.addSubview(topHeaderView)
            topHeaderView.addSubview(backButton)
            topHeaderView.addSubview(heartButton)
            topHeaderView.addSubview(headerTitleLabel) // ← ADD THIS LINE

            NSLayoutConstraint.activate([
                topHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topHeaderView.heightAnchor.constraint(equalToConstant: 60),

                backButton.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor),
                backButton.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 15),
                backButton.widthAnchor.constraint(equalToConstant: 30),
                backButton.heightAnchor.constraint(equalToConstant: 30),

                heartButton.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor),
                heartButton.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: -15),
                heartButton.widthAnchor.constraint(equalToConstant: 30),
                heartButton.heightAnchor.constraint(equalToConstant: 30),

                headerTitleLabel.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor),
                headerTitleLabel.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor)
            ])
        }

        
        private func setupContent() {
            // Add bag image, title and description to the main view
            view.addSubview(bagImageView)
            view.addSubview(titleLabel)
            view.addSubview(descriptionLabel)
            
            NSLayoutConstraint.activate([
                bagImageView.topAnchor.constraint(equalTo: topHeaderView.bottomAnchor, constant: 120),
                bagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                bagImageView.widthAnchor.constraint(equalToConstant: 180),
                bagImageView.heightAnchor.constraint(equalToConstant: 180),
                
                titleLabel.topAnchor.constraint(equalTo: bagImageView.bottomAnchor, constant: 30),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        }
        
        private func setupBottomButtons() {
            // Prepare a stack view containing the two bottom buttons.
            bottomButtonContainer.addArrangedSubview(wishlistButton)
            bottomButtonContainer.addArrangedSubview(shopButton)
            view.addSubview(bottomButtonContainer)
            
            NSLayoutConstraint.activate([
                // Place the container above the bottom safe area with some padding
                bottomButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                bottomButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                bottomButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
            
            // Set consistent height for buttons
            wishlistButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
            shopButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        }
    @objc private func wishlistButtonTapped() {
        print("Wishlist button tapped")
        // Navigate to wishlist screen or show an alert
        self.NavigationController(navigateFrom: self, navigateTo: LMWishlistVC(), navigateToString: VcIdentifier.LMWishlistVC)
    }

    @objc private func shopButtonTapped() {
        print("Start Shopping button tapped")
        // Navigate to product listing or home screen
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)

    }
    @objc private func backdismiss() {
        print("Start Shopping button tapped")
        // Navigate to product listing or home screen
        dismiss(animated: true, completion: nil)

    }
    }
