//
//  LMOrderCartpop.swift
//  LoomApp
//
//  Created by Flucent tech on 03/06/25.
//


import UIKit
import WebKit

class LMOrderCartpop: UIViewController {


    let containerView = UIView()
    let gifWebView = WKWebView()
    let titleLabel = UILabel()
    let orderIdLabel = UILabel()
    let savingsLabel = UILabel()
    let continueButton = UIButton(type: .system)
    let trackButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupContainer()
        setupGIF()
        setupLabels()
        setupButtons()
    }

    private func setupContainer() {
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true

        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func setupGIF() {
        gifWebView.isOpaque = false
        gifWebView.backgroundColor = .clear
        gifWebView.scrollView.isScrollEnabled = false
        containerView.addSubview(gifWebView)
        gifWebView.translatesAutoresizingMaskIntoConstraints = false

        if let gifPath = Bundle.main.path(forResource: "64787-success", ofType: "gif") {
            let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath))
            gifWebView.load(gifData!, mimeType: "image/gif", characterEncodingName: "", baseURL: URL(fileURLWithPath: gifPath))
        }

        NSLayoutConstraint.activate([
            gifWebView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            gifWebView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            gifWebView.widthAnchor.constraint(equalToConstant: 80),
            gifWebView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupLabels() {
        titleLabel.text = "Order Placed Successfully"
        titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 18)
        titleLabel.textAlignment = .center

        orderIdLabel.text = "Order Id : ORD-20250603-00015"
        orderIdLabel.font = UIFont(name: ConstantFontSize.regular, size: 14)
        orderIdLabel.textColor = .darkGray
        orderIdLabel.textAlignment = .center

        savingsLabel.text = ""
        savingsLabel.font = UIFont(name: ConstantFontSize.regular, size: 14)
        savingsLabel.textColor = .darkGray
        savingsLabel.textAlignment = .center

        [titleLabel, orderIdLabel, savingsLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: gifWebView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            orderIdLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            orderIdLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            orderIdLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            savingsLabel.topAnchor.constraint(equalTo: orderIdLabel.bottomAnchor, constant: 4),
            savingsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            savingsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    @objc func backtoShopping(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMTabBarVC) as! LMTabBarVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func actTrack(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMOrderlistVC) as! LMOrderlistVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    private func setupButtons() {
        continueButton.setTitle("Continue Shop...", for: .normal)
        continueButton.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 14)

        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .black
        continueButton.layer.cornerRadius = 0
        continueButton.addTarget(self, action: #selector(backtoShopping(_:)), for: .touchUpInside)

        trackButton.setTitle("Track Orders", for: .normal)
        trackButton.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 14)

        trackButton.setTitleColor(.black, for: .normal)
        trackButton.layer.borderWidth = 1
        trackButton.layer.borderColor = UIColor.black.cgColor
        trackButton.layer.cornerRadius = 0
        trackButton.addTarget(self, action: #selector(actTrack(_:)), for: .touchUpInside)


        let stackView = UIStackView(arrangedSubviews: [continueButton, trackButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually

        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: savingsLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}
