//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit


class LMorderlistCell : UITableViewCell {
 
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgProduxct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderType: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
class LMorderCell : UITableViewCell {
 
    @IBOutlet weak var imgProduxct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LMorderShippingCell : UITableViewCell {
 
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblHouseAddress: UILabel!
    
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LMorderFotterlistCell : UITableViewCell {
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LMOtherOrderCell : UITableViewCell {
 
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbldot: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblProductTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LMOtherOrderHeaderCell : UITableViewCell {
 
    @IBOutlet weak var lblHeadertile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
class LMOrderStatusCell : UITableViewCell{
    private let baselineView = UIView()
    private let progressBarView = UIView()
    private var progressHeightConstraint: NSLayoutConstraint?
    var itemStatusTimestamps: [ItemStatusTimestampDetail]? = []
    private var dots: [UIView] = []
    private var numberLabels: [UILabel] = []
    private var labels: [UILabel] = []
    var itemStatus: String? 

    let actionButton = UIButton(type: .system)  // Added button

    var strInt: Int = 1 // Step to animate to (1-based index)
    private let stageTitles = ["", "Order Confirmed", "Shipped", "In Transit", "Out For Delivery", "Delivered"]

    override func awakeFromNib() {
        self.backgroundColor = .white

        createSteps(count: 2, strItem: "", dateFormate: "", otherStatusTime: "")  // Change to 5 for all stages
        animateToStep(2)

        setupActionButton()
    }

    func createSteps(count: Int, strItem:String, dateFormate:String, otherStatusTime:String) {
        // Clear previous views
        [dots, numberLabels, labels].forEach { $0.forEach { $0.removeFromSuperview() } }
        dots.removeAll()
        numberLabels.removeAll()
        labels.removeAll()

        baselineView.removeFromSuperview()
        progressBarView.removeFromSuperview()

        guard count > 0 else { return }

        let startY: CGFloat = 10
        let spacing: CGFloat = 90

        // Baseline gray line
        baselineView.backgroundColor = .lightGray
        baselineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(baselineView)

        NSLayoutConstraint.activate([
            baselineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 33),
            baselineView.widthAnchor.constraint(equalToConstant: 3),
            baselineView.topAnchor.constraint(equalTo: self.topAnchor, constant: startY),
            baselineView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: startY + spacing * CGFloat(count - 1))
        ])

        // Progress bar (black animated)
        progressBarView.backgroundColor = .black.withAlphaComponent(0.9)
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(progressBarView)

        NSLayoutConstraint.activate([
            progressBarView.leadingAnchor.constraint(equalTo: baselineView.leadingAnchor),
            progressBarView.widthAnchor.constraint(equalToConstant: 3),
            progressBarView.topAnchor.constraint(equalTo: baselineView.topAnchor)
        ])

        progressHeightConstraint = progressBarView.heightAnchor.constraint(equalToConstant: 0)
        progressHeightConstraint?.isActive = true

        // Create dots, numbers and stage labels
        for i in 0..<count {
            let dot = UIView()
            dot.backgroundColor = .white
            dot.layer.cornerRadius = 13
            dot.layer.borderWidth = 1
            dot.layer.borderColor = UIColor.black.cgColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(dot)

            NSLayoutConstraint.activate([
                dot.centerXAnchor.constraint(equalTo: progressBarView.centerXAnchor),
                dot.topAnchor.constraint(equalTo: self.topAnchor, constant: startY + spacing * CGFloat(i)),
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
            let title = i + 1 < stageTitles.count ? stageTitles[i + 1] : "Order Confirmed"
            
            var value = ""

            if i == 0 {
                value = "ORDER CONFIRMED" + "\n" + dateFormate

            }
            
            
            label.textColor = .black

                if strItem == "CONFIRMED" {
                    //value = title + "\n" + dateFormate
                    if i == 1 {
                        value = "DELIVERED"
                    }

                } else if strItem == "SHIPPED" {
                    if i == 1 {
                        
                        value = "SHIPPED" + "\n" + otherStatusTime
                    }

                } else if strItem == "IN_TRANSIT" {
                    if i == 1 {
                        value = "IN TRANSIT" + "\n" + otherStatusTime
                    }


                } else if strItem == "OUT_FOR_DELIVERY" {
                    if i == 1 {
                        value = "OUT FOR DELIVERY" + "\n" + otherStatusTime
                    }


                } else if strItem == "CANCELLED" {
                    if i == 1 {
                        value = "CANCELLED" + "\n" + otherStatusTime
                        label.textColor = .red
                    }


                } else if strItem == "DELIVERED" {
                    if i == 1 {
                        value = "DELIVERED" + "\n" + otherStatusTime
                        label.textColor = .red
                    }
                
        } else if strItem == "RETURN_REQUESTED" {
            if i == 1 {
                value = "RETURN REQUESTED" + "\n" + otherStatusTime
                label.textColor = .black
            }
        
    } else if strItem == "RETURN_APPROVED" {
        if i == 1 {
            value = "RETURN APPROVED" + "\n" + otherStatusTime
            label.textColor = .black
        }
    
        } else if strItem == "RETURN_PICKUP_SCHEDULED" {
            if i == 1 {
                value = "RETURN PICKUP SCHEDULED" + "\n" + otherStatusTime
                label.textColor = .black
            }
        
    } else if strItem == "RETURN_PICKED_UP" {
        if i == 1 {
            value = "RETURN PICKED UP" + "\n" + otherStatusTime
            label.textColor = .black
        }
    }
/*  'RETURN_REQUESTED', 'RETURN_APPROVED', 'RETURN_IN_TRANSIT', 'RETURN_RECEIVED',
 'REFUND_INITIATED', 'REFUND_COMPLETED',
 'REPLACEMENT_REQUESTED', 'REPLACEMENT_DISPATCHED', 'REPLACEMENT_DELIVERED',*/
            
            label.text = value
            label.font = UIFont(name: ConstantFontSize.regular, size: 13)

            label.numberOfLines = 2
            if dateFormate == "" {
                label.numberOfLines = 1
            }
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 12),
                label.centerYAnchor.constraint(equalTo: dot.centerYAnchor)
            ])

            labels.append(label)
        }
    }

     func setupActionButton() {
        guard dots.count >= 2 else { return } // Ensure at least 2 dots

        actionButton.setTitle("See All Updates", for: .normal)
        actionButton.tintColor = .orange
        actionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(actionButton)

        NSLayoutConstraint.activate([
            // Position button left aligned, below second dot with 16 padding
            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            actionButton.topAnchor.constraint(equalTo: dots[1].bottomAnchor, constant: 16),
            // Optional: fixed height and width
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Add button action example
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc private func actionButtonTapped() {
        print("Action button tapped")
        // Your button action code here
    }

    func animateToStep(_ stepNumber: Int, completion: (() -> Void)? = nil) {
        guard stepNumber > 0, stepNumber <= dots.count else {
            completion?()
            return
        }

        // If step == 1, just fill first dot, no progress line
        if stepNumber == 1 {
            dots[0].backgroundColor = .black
            numberLabels[0].textColor = .white
            labels[0].textColor = .black

            progressHeightConstraint?.constant = 0
            self.layoutIfNeeded()
            completion?()
            return
        }

        // Animate to step normally for step > 1
        animateStep(index: -1, targetIndex: stepNumber - 1, completion: completion)
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
    private func animateStep(index: Int, targetIndex: Int, completion: (() -> Void)? = nil) {
        if index >= targetIndex {
            completion?()
            return
        }

        let startDot = dots[0]
        let nextDot = dots[index + 1]

        let startPoint = startDot.superview?.convert(startDot.center, to: self) ?? startDot.center
        let nextPoint = nextDot.superview?.convert(nextDot.center, to: self) ?? nextDot.center
        let totalHeight = nextPoint.y - startPoint.y

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.8, animations: {
                self.progressHeightConstraint?.constant = totalHeight
                self.layoutIfNeeded()
            }, completion: { _ in
                

                self.numberLabels[index + 1].textColor = .white
                self.dots[0].backgroundColor = .black
                self.labels[0].textColor = .black
                
                if self.itemStatus == "CONFIRMED" {
                    if index == 0 {
                        self.numberLabels[index + 1].textColor = .black
                    }

                } else if self.itemStatus == "SHIPPED" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                    }
                } else if self.itemStatus == "IN_TRANSIT" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                    }
                } else if self.itemStatus == "OUT_FOR_DELIVERY" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                    }
                } else if self.itemStatus == "CANCELLED" {
                    if index == 0 {
                        self.dots[1].backgroundColor = .red
                        self.dots[1].layer.borderColor = UIColor.red.cgColor
                        self.numberLabels[index + 1].text = "X"
                        self.numberLabels[index + 1].textColor = .white
                    }

                } else if self.itemStatus == "DELIVERED" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].text = "X"
                        self.numberLabels[index + 1].textColor = .white
                    }
                } else if self.itemStatus == "RETURN_REQUESTED" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                        self.numberLabels[index + 1].text = "2"
                    }
                } else if self.itemStatus == "RETURN_APPROVED" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                        self.numberLabels[index + 1].text = "2"
                    }
                } else if self.itemStatus == "RETURN_PICKUP_SCHEDULED" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                        self.numberLabels[index + 1].text = "2"
                    }
                } else if self.itemStatus == "RETURN_PICKED_UP" {
                    if index == 0 {
                        self.dots[1].layer.borderColor = UIColor.black.cgColor
                        self.numberLabels[index + 1].textColor = .white
                        self.numberLabels[index + 1].text = "2"
                    }
                }
                
                self.numberLabels[index + 1].text = "2"

                
          
                
             
                self.animateStep(index: index + 1, targetIndex: targetIndex, completion: completion)
            })
        }
    }
    
}
    
//    private var progressTimer: Timer?
//
//
//    private var isUISetupDone = false
//    var checKFlagCancel:Bool = true
//
//    let dot1 = UIView()
//    let dot2 = UIView()
//    let progressLine = UIView()
//
//    let label1 = UILabel()
//    let label2 = UILabel()
//    let dotLabel1 = UILabel()
//    let dotLabel2 = UILabel()
////    let check1 = UIImageView()
////    let check2 = UIImageView()
//
//    let actionButton = UIButton(type: .system)
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.backgroundColor = .white
//        setupTimelineUI()
//        animateProgress(str: "")
//    }
//    func cancel(checKFlag:Bool){
//        checKFlagCancel = checKFlag
//        setupTimelineUI()
//        animateProgress(str: "")
//    }
//    func startProgressAnimationLoop() {
//        // Invalidate previous timer if any
//        progressTimer?.invalidate()
//
//        // Start a new timer
//        progressTimer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { [weak self] _ in
//            self?.resetAndAnimateProgress()
//        }
//
//        // Animate once immediately
//        resetAndAnimateProgress()
//    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        progressTimer?.invalidate()
//        progressTimer = nil
//    }
//
//    private func resetAndAnimateProgress() {
//        // Reset to initial state
//        self.progressLine.constraints.first { $0.firstAttribute == .height }?.constant = 0
//        self.dot2.backgroundColor = .systemGray4
//        self.label2.textColor = .darkGray
//        self.layoutIfNeeded()
//
//        // Animate
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            UIView.animate(withDuration: 1.0, animations: {
//                self.progressLine.constraints.first { $0.firstAttribute == .height }?.constant = self.dot2.center.y - self.dot1.center.y
//                self.layoutIfNeeded()
//            }) { _ in
//                self.dot2.backgroundColor = .black
//                self.label2.textColor = .red
//            }
//        }
//    }
//
//    func configureCell(str:String, dateStr:String) {
//            if !isUISetupDone {
//                setupTimelineUI()
//                isUISetupDone = true
//            }
//        animateProgress(str: str)
//        }
//
//    func configureCell(isCancelled: Bool,str:String, dateStr:String) {
//        self.checKFlagCancel = isCancelled
//
//        if !isUISetupDone {
//            setupTimelineUI()
//            isUISetupDone = true
//        }
//
//        //updateLabelTexts()
//        if str == "CONFIRMED" {
//
//            label1.text = "CONFIRMED" + "\n" + dateStr
//            label2.text = "DELIVERED"
//
//
//        } else if str == "SHIPPED" {
//            label2.text = "SHIPPED" + "\n" + dateStr
//
//        } else if str == "IN_TRANSIT" {
//            label2.text = "IN TRANSIT" + "\n" + dateStr
//
//        } else if str == "OUT_FOR_DELIVERY" {
//            label2.text = "OUT FOR DELIVERY" + "\n" + dateStr
//
//        } else if str == "CANCELLED" {
//            label2.text = "CANCELLED" + "\n" + dateStr
//            self.dotLabel2.text = "X"
//        } else {
//            label2.text = "DELIVERED" + "\n" + dateStr
//
//        }
//
//        startProgressAnimationLoop()
//    }
//    private func updateLabelTexts() {
//
//
//
//        label1.text = "Order Confirmed"
//        //label2.text = checKFlagCancel ? "Delivered" : "Delivered"
//    }
//    func setupTimelineUI() {
//        progressLine.backgroundColor = .black
//        progressLine.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(progressLine)
//
//        [dot1, dot2].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.layer.cornerRadius = 10
//            $0.clipsToBounds = true
//            $0.backgroundColor = .systemGray4
//            self.addSubview($0)
//        }
//
//        [dotLabel1, dotLabel2].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.textColor = .white
//            $0.font = .systemFont(ofSize: 10, weight: .bold)
//            $0.textAlignment = .center
//        }
//
//        dotLabel1.text = "1"
//        dotLabel2.text = "2"
//
//        dot1.addSubview(dotLabel1)
//        dot2.addSubview(dotLabel2)
//
//        NSLayoutConstraint.activate([
//            dotLabel1.centerXAnchor.constraint(equalTo: dot1.centerXAnchor),
//            dotLabel1.centerYAnchor.constraint(equalTo: dot1.centerYAnchor),
//
//            dotLabel2.centerXAnchor.constraint(equalTo: dot2.centerXAnchor),
//            dotLabel2.centerYAnchor.constraint(equalTo: dot2.centerYAnchor),
//        ])
//
//
//        [label1, label2].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.font = .systemFont(ofSize: 12, weight: .medium)
//            $0.textColor = .darkGray
//            self.addSubview($0)
//        }
//
//        label1.text = "Order Confirmed"
//        label2.text = "Delivered"
//
//        if checKFlagCancel == false {
//            label2.text = "Cancelled"
//        }
//
//        // Button
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.setTitle("See All Updates ", for: .normal)
//        actionButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//        actionButton.tintColor = .orange
//        actionButton.semanticContentAttribute = .forceRightToLeft
//        self.addSubview(actionButton)
//
//        NSLayoutConstraint.activate([
//            dot1.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            dot1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            dot1.widthAnchor.constraint(equalToConstant: 20),
//            dot1.heightAnchor.constraint(equalToConstant: 20),
//
//            dot2.topAnchor.constraint(equalTo: dot1.bottomAnchor, constant: 70),
//            dot2.centerXAnchor.constraint(equalTo: dot1.centerXAnchor),
//            dot2.widthAnchor.constraint(equalToConstant: 20),
//            dot2.heightAnchor.constraint(equalToConstant: 20),
//
//            label1.centerYAnchor.constraint(equalTo: dot1.centerYAnchor),
//            label1.leadingAnchor.constraint(equalTo: dot1.trailingAnchor, constant: 16),
//
//            label2.centerYAnchor.constraint(equalTo: dot2.centerYAnchor),
//            label2.leadingAnchor.constraint(equalTo: dot2.trailingAnchor, constant: 16),
//
//            progressLine.centerXAnchor.constraint(equalTo: dot1.centerXAnchor),
//            progressLine.topAnchor.constraint(equalTo: dot1.centerYAnchor),
//            progressLine.widthAnchor.constraint(equalToConstant: 4),
//            progressLine.heightAnchor.constraint(equalToConstant: 0),
//
//            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            actionButton.topAnchor.constraint(equalTo: dot2.bottomAnchor, constant: 20),
//        ])
//        dot1.backgroundColor = .black
//    }
//    func animateProgress(str:String) {
//        // Reset state before animation
//
//        if str == "CANCELLED" {
//            dot2.backgroundColor = .red
//            label2.textColor     = .red
//        } else {
//            dot2.backgroundColor = .systemGray4
//            label2.textColor     = .darkGray
//        }
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            UIView.animate(withDuration: 1.0, animations: {
//                self.progressLine.constraints.first { $0.firstAttribute == .height }?.constant = self.dot2.center.y - self.dot1.center.y
//                self.layoutIfNeeded()
//            }) { _ in
//
//                if str == "CANCELLED" {
//                    self.dot2.backgroundColor = .red
//                    self.label2.textColor = .red
//                } else {
//                    self.dot2.backgroundColor = .black
//                    self.label2.textColor = .black
//                }
//
//
//            }
//        }
//    }
//
//}
//
//
//
