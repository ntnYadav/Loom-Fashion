//
//  LMSheet.swift
//  LoomApp
//
//  Created by Flucent tech on 02/05/25.
//


import UIKit

class LMSheetVC: UIViewController {
       
    var onDismiss: ((Set<String>) -> Void)?
        let styles = [
            "Basic Casuals",
            "Daily Formals",
            "Street Style",
            "Summer Casuals",
            "Vibrant Colors"
        ]
        var selectedStyles = Set<String>()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupUI()
        }

        func setupUI() {
            // Done button on top
            let doneButton = UIButton(type: .system)
            doneButton.setTitle("Done", for: .normal)
            doneButton.setTitleColor(.systemOrange, for: .normal)
            doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
            view.addSubview(doneButton)
            doneButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])

            var previousView: UIView = doneButton
            
            // Add title
            let titleLabel = UILabel()
            titleLabel.text = "Select a style that matches your vibe"
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            view.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            previousView = titleLabel
            for (index, style) in styles.enumerated() {
                let button = UIButton(type: .custom)
                button.setTitle(style, for: .normal)
                button.setTitleColor(.black, for: .normal) // Same for both states
                button.setTitleColor(.black, for: .selected)
                button.backgroundColor = .white // constant background

                button.contentHorizontalAlignment = .left
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

                // Set images for selection
                button.setImage(UIImage(systemName: "square"), for: .normal)
                button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
                
                button.tintColor = button.isSelected ? .black : .lightGray

                // Add spacing between image and title
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

                button.tag = index
                button.addTarget(self, action: #selector(toggleStyle(_:)), for: .touchUpInside)

                view.addSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 15),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    button.heightAnchor.constraint(equalToConstant: 30)
                ])

                previousView = button
            }
        }
    
        @objc func toggleStyle(_ sender: UIButton) {
            let style = styles[sender.tag]
            sender.isSelected.toggle()
            if sender.isSelected {
                selectedStyles.insert(style)
            } else {
                selectedStyles.remove(style)
            }
            updateButtonAppearance(sender)

        }
    func updateButtonAppearance(_ button: UIButton) {
        // Text color
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .selected)

        // Background stays white
        button.backgroundColor = .white

        // Set image based on state
        
        let imageName = button.isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
        button.tintColor = button.isSelected ? .black : .lightGray

        // Maintain padding
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
        @objc func doneTapped() {
            print("Selected Styles: \(Array(selectedStyles))")
            onDismiss?(selectedStyles)
            dismiss(animated: true)
        }
    }
