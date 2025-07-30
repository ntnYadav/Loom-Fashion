//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit

class LMOrderStatusVC: UIViewController {

        


            private let baselineView = UIView()
            private let progressBarView = UIView()
            private var progressHeightConstraint: NSLayoutConstraint?

            private var dots: [UIView] = []
            private var numberLabels: [UILabel] = []
            private var labels: [UILabel] = []
            var strInt: Int = 1
            var itemStatusTimestamps: [ItemStatusTimestampDetail]? = nil
            private var stageTitles: [String] = [ "", "Order Confirmed", "Shipped", "In Transit", "Out For Delivery", "Delivered"]

            override func viewDidLoad() {
                super.viewDidLoad()
          
                if strInt <= 6 {
                    stageTitles = [ "", "Order Confirmed", "Shipped", "In Transit", "Out For Delivery", "Delivered", "Return requested    ","Return approved", "Return pickup scheduled","Return picked up" ]
                }
                view.backgroundColor = .white
                setupHeader()
                if strInt < 5 {
                    createSteps(count: 5)
                } else {
                    createSteps(count: 9)
                }
                animateToStep(strInt)
                itemStatusTimestamps
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

            private func setupHeader() {
                let headerView = UIView()
                headerView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(headerView)
                headerView.backgroundColor = .white

                NSLayoutConstraint.activate([
                    headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    headerView.heightAnchor.constraint(equalToConstant: 50)
                ])

                let backButton = UIButton(type: .system)
                backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
                backButton.tintColor = .black
                backButton.translatesAutoresizingMaskIntoConstraints = false
                backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

                headerView.addSubview(backButton)

                NSLayoutConstraint.activate([
                    backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                    backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    backButton.widthAnchor.constraint(equalToConstant: 30),
                    backButton.heightAnchor.constraint(equalToConstant: 30)
                ])

                let titleLabel = UILabel()
                titleLabel.text = "Order Status"
                titleLabel.font = .boldSystemFont(ofSize: 18)
                titleLabel.textColor = .black
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                headerView.addSubview(titleLabel)

                NSLayoutConstraint.activate([
                    titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                    titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
                ])
            }

            func createSteps(count: Int) {
                dots.forEach { $0.removeFromSuperview() }
                numberLabels.forEach { $0.removeFromSuperview() }
                labels.forEach { $0.removeFromSuperview() }
                dots.removeAll()
                numberLabels.removeAll()
                labels.removeAll()

                baselineView.removeFromSuperview()
                progressBarView.removeFromSuperview()

                guard count > 0 else { return }

                
                let startY: CGFloat  = 130
                var spacing: CGFloat = 120
                if strInt < 5 {
                    spacing = 120
                } else {
                    spacing = 70
                }

                baselineView.backgroundColor = .lightGray
                baselineView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(baselineView)

                NSLayoutConstraint.activate([
                    baselineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30 + 3),
                    baselineView.widthAnchor.constraint(equalToConstant: 3),
                    baselineView.topAnchor.constraint(equalTo: view.topAnchor, constant: startY),
                    baselineView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: startY + spacing * CGFloat(count - 1))
                ])

                progressBarView.backgroundColor = .black.withAlphaComponent(0.8)
                progressBarView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(progressBarView)

                NSLayoutConstraint.activate([
                    progressBarView.leadingAnchor.constraint(equalTo: baselineView.leadingAnchor),
                    progressBarView.widthAnchor.constraint(equalToConstant: 3),
                    progressBarView.topAnchor.constraint(equalTo: baselineView.topAnchor)
                ])

                progressHeightConstraint = progressBarView.heightAnchor.constraint(equalToConstant: 0)
                progressHeightConstraint?.isActive = true

                for i in 0..<count {
                    let dot = UIView()
                    dot.backgroundColor = .white
                    dot.layer.cornerRadius = 13
                    dot.layer.borderColor = UIColor.gray.cgColor
                    dot.layer.borderWidth = 0.5
                    dot.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(dot)

                    NSLayoutConstraint.activate([
                        dot.centerXAnchor.constraint(equalTo: progressBarView.centerXAnchor),
                        dot.topAnchor.constraint(equalTo: view.topAnchor, constant: startY + spacing * CGFloat(i)),
                        dot.widthAnchor.constraint(equalToConstant: 26),
                        dot.heightAnchor.constraint(equalToConstant: 26)
                    ])

                    dots.append(dot)

                    let numberLabel = UILabel()
                    numberLabel.text = "\(i + 1)"
                    numberLabel.textColor = .black
                    numberLabel.font = .boldSystemFont(ofSize: 12)
                    numberLabel.textAlignment = .center
                    numberLabel.translatesAutoresizingMaskIntoConstraints = false
                    dot.addSubview(numberLabel)

                    NSLayoutConstraint.activate([
                        numberLabel.centerXAnchor.constraint(equalTo: dot.centerXAnchor),
                        numberLabel.centerYAnchor.constraint(equalTo: dot.centerYAnchor)
                    ])

                    numberLabels.append(numberLabel)

                    let label = UILabel()
                    
                    
                    
                
                    
                    
                    
                
                 
                    
                    
                    //            'PENDING', 'CONFIRMED', 'SHIPPED', 'IN_TRANSIT', 'OUT_FOR_DELIVERY',
                    //                'DELIVERED', 'CANCELLED', 'EXPIRED',
                    //                'RETURN_REQUESTED', 'RETURN_APPROVED', 'RETURN_IN_TRANSIT', 'RETURN_RECEIVED',
                    //                'REFUND_INITIATED', 'REFUND_COMPLETED',
                    //                'REPLACEMENT_REQUESTED', 'REPLACEMENT_DISPATCHED', 'REPLACEMENT_DELIVERED'
                   // private var stageTitles: [String] = [ "", "Order Confirmed", "Shipped", "In Transit", "Out For Delivery", "Delivered"]

                    let vaue =  i + 1 < stageTitles.count ? stageTitles[i + 1] : "Order Confirmed"
                    var date:String = ""

                    if vaue == "Order Confirmed" {
                        if let confirmedDetail = itemStatusTimestamps?.first(where: { $0.status == "CONFIRMED" }), let _ = confirmedDetail.timestamp {
                            let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                            let status = confirmedDetail.status ?? ""
                            date = orderda ?? ""
                            let attributedText = NSMutableAttributedString(string: vaue + "\n", attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 15),
                                .foregroundColor: UIColor.black
                            ])
                            attributedText.append(NSAttributedString(string: date, attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.black
                            ]))
                            
                           // label.attributedText = attributedText
                        }

                    } else if vaue == "Shipped" {
                        if let confirmedDetail = itemStatusTimestamps?.first(where: { $0.status == "SHIPPED" }), let _ = confirmedDetail.timestamp {
                            let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                            let status = confirmedDetail.status ?? ""
                            date = orderda ?? ""
                            let attributedText = NSMutableAttributedString(string: vaue + "\n", attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 15),
                                .foregroundColor: UIColor.black
                            ])
                            attributedText.append(NSAttributedString(string: date, attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.black
                            ]))
                            
                           // label.attributedText = attributedText
                        }

                    } else if vaue == "In Transit" {
                        if let confirmedDetail = itemStatusTimestamps?.first(where: { $0.status == "IN_TRANSIT" }), let _ = confirmedDetail.timestamp {
                            let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                            let status = confirmedDetail.status ?? ""
                            date = orderda ?? ""
                            let attributedText = NSMutableAttributedString(string: vaue + "\n", attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 15),
                                .foregroundColor: UIColor.black
                            ])
                            attributedText.append(NSAttributedString(string: date, attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.black
                            ]))
                            
                           // label.attributedText = attributedText
                        }

                    } else if vaue == "Out For Delivery" {
                        if let confirmedDetail = itemStatusTimestamps?.first(where: { $0.status == "OUT_FOR_DELIVERY" }), let _ = confirmedDetail.timestamp {
                            let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                            let status = confirmedDetail.status ?? ""
                            date = orderda ?? ""
                            let attributedText = NSMutableAttributedString(string: vaue + "\n", attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 15),
                                .foregroundColor: UIColor.black
                            ])
                            attributedText.append(NSAttributedString(string: date, attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.black
                            ]))
                            
                            //label.attributedText = attributedText
                        }

                    } else {
                        if let confirmedDetail = itemStatusTimestamps?.first(where: { $0.status == "DELIVERED" }), let _ = confirmedDetail.timestamp {
                            let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                            let status = confirmedDetail.status ?? ""
                            date = orderda ?? ""
                            let attributedText = NSMutableAttributedString(string: vaue + "\n", attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 15),
                                .foregroundColor: UIColor.black
                            ])
                            attributedText.append(NSAttributedString(string: date, attributes: [
                                .font:  UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.black
                            ]))
                            
                           // label.attributedText = attributedText
                        }

                    }
                    
                    
                  
                    
                    //label.text = vaue + "\n" + date
                    
                    let attributedText = NSMutableAttributedString(
                        string: vaue + "\n",
                        attributes: [
                            .font: UIFont(name: ConstantFontSize.regular, size: 15),
                            .foregroundColor: UIColor.black
                        ]
                    )

                    if date == "" {
                        label.numberOfLines = 1

                    } else {
                        attributedText.append(NSAttributedString(
                            string: date,
                            attributes: [
                                .font: UIFont(name: ConstantFontSize.regular, size: 13),
                                .foregroundColor: UIColor.darkGray
                            ]
                        ))
                        label.numberOfLines = 2

                    }
                  
                    label.attributedText = attributedText
                    

                    label.textColor = .darkGray
                    //label.font = .systemFont(ofSize: 14)
                    label.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(label)

                    NSLayoutConstraint.activate([
                        label.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 12),
                        label.centerYAnchor.constraint(equalTo: dot.centerYAnchor)
                    ])

                    labels.append(label)
                }
            }

    func formatISODateToReadable(_ isoDateString: String, timeZone: TimeZone = .current) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoDateString) else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy, h:mm a"
        formatter.timeZone = timeZone

        return formatter.string(from: date)
    }
            func animateToStep(_ stepNumber: Int, completion: (() -> Void)? = nil) {
                guard stepNumber > 0, stepNumber <= dots.count else {
                    completion?()
                    return
                }
                animateStep(index: -1, targetIndex: stepNumber - 1, completion: completion)
            }

            func animateStep(index: Int, targetIndex: Int, completion: (() -> Void)? = nil) {
                if index >= targetIndex {
                    completion?()
                    return
                }

                let startDot = dots[0]
                let nextDot = dots[index + 1]

                let startPoint = startDot.superview?.convert(startDot.center, to: view) ?? startDot.center
                let nextPoint = nextDot.superview?.convert(nextDot.center, to: view) ?? nextDot.center
                let totalHeight = nextPoint.y - startPoint.y

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UIView.animate(withDuration: 0.8, animations: {
                        self.progressHeightConstraint?.constant = totalHeight
                        self.view.layoutIfNeeded()
                    }, completion: { _ in
                        self.dots[index + 1].backgroundColor = .black
                        self.numberLabels[index + 1].textColor = .white
                        self.labels[index + 1].textColor = .black
                        self.animateStep(index: index + 1, targetIndex: targetIndex, completion: completion)
                    })
                }
            }

      @objc func backButtonTapped() {
          navigationController?.popViewController(animated: true)
      }
        }
