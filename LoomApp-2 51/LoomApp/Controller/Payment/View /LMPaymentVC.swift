//
//  ViewController.swift
//  paymentscreen
//
//  Created by Flucent tech on 28/05/25.
//

import UIKit
import Razorpay
   

//struct PaymentMethod {
//    let title: String
//    var isExpanded: Bool
//    let isCOD: Bool
//}

class LMPaymentVC: UIViewController{
    
}
//    var razorpayObj : RazorpayCheckout? = nil
//    var merchantDetails : MerchantsDetails = MerchantsDetails.getDefaultData()
//    
//    let razorpayKey = "rzp_test_zBwPgh9zUMzz9y" // Sign up for a Razorpay Account(https://dashboard.razorpay.com/#/access/signin) and generate the API Keys(https://razorpay.com/docs/payment-gateway/dashboard-guide/settings/#api-keys/) from the Razorpay Dashboard.
//    
//    
//    
//            lazy fileprivate var viewmodel = LMPaymentMV(hostController: self)
//
//            let tableView = UITableView(frame: .zero, style: .grouped)
//            let sections = ["Pay Online", "CREDIT / DEBIT CARD", "CASH ON DELIVERY", "EMI", "NETBANKING"]
//            var expandedSection: Int? = 2 // COD by default
//            let subLabel = UILabel()
//
//            var amountpayment: String = "2998"
//            var amountpaymentFinal: String = "2998"
//            var timerun: Int = 0
//
//            var orderID: String = ""
//            let ProductId: String = ""
//            var AddressID: String = ""
//            var couponCode: String = ""
//            var coupondiscountAmount: String = ""
//            var wallet: String = ""
//            var Amount: String = ""
//
//            var countdownLabel: UILabel!
//            var countdownTimer: Timer?
//            var remainingTime: Int = 180 // 3 minutes
//
//            override func viewDidLoad() {
//                super.viewDidLoad()
//                remainingTime = timerun
//                view.backgroundColor = .white
//                tableView.backgroundColor = .white
//                setupTableView()
//                setupHeaderView()
//                startCountdownTimer()
//                
//                if THUserDefaultValue.userpincodeSecond != THUserDefaultValue.isUserPincode  {
//                   
//                    if THUserDefaultValue.userpincodeSecond != "" {
//                        viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.userpincodeSecond ?? "") ?? 0, weight: 0.0, height: 30, breadth: 30, length: 30)
//
//                    } else if THUserDefaultValue.isUserPincode != "" {
//                        viewmodel.validateValue1(Pincode: Int(THUserDefaultValue.isUserPincode ?? "") ?? 0, weight: 0.0, height: 30, breadth: 30, length: 30)
//
//                    }
//                    
//                    
//                }
//                
//               
//            }
//    override func viewWillAppear(_ animated: Bool) {
//        
//    }
//    
//            private func setupTableView() {
//                tableView.translatesAutoresizingMaskIntoConstraints = false
//                tableView.delegate = self
//                tableView.dataSource = self
//                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//                tableView.register(CODCell.self, forCellReuseIdentifier: "codCell")
//                view.addSubview(tableView)
//
//                NSLayoutConstraint.activate([
//                    tableView.topAnchor.constraint(equalTo: view.topAnchor),
//                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//                ])
//            }
//
//            private func setupHeaderView() {
//                let headerView = UIView()
//                headerView.backgroundColor = .white
//
//                let backButton = UIButton(type: .system)
//                backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//                backButton.tintColor = .black
//                backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//
//                let titleLabel = UILabel()
//                titleLabel.text = "PAYMENT"
//                titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//                titleLabel.textAlignment = .center
//
//                countdownLabel = UILabel()
//                countdownLabel.text = "03:00"
//                countdownLabel.font = UIFont.systemFont(ofSize: 14)
//                countdownLabel.textColor = .black
//                countdownLabel.textAlignment = .right
//
//                let topBar = UIStackView(arrangedSubviews: [backButton, titleLabel, countdownLabel])
//                topBar.axis = .horizontal
//                topBar.alignment = .center
//                topBar.distribution = .equalSpacing
//                topBar.translatesAutoresizingMaskIntoConstraints = false
//
//                let truckImage = UIImageView(image: UIImage(named: "track"))
//                truckImage.contentMode = .scaleAspectFit
//                truckImage.tintColor = UIColor(red: 0.88, green: 0.45, blue: 0.36, alpha: 1)
//                truckImage.contentMode = .scaleAspectFit
//
//                subLabel.text = "Pay ₹\(amountpaymentFinal) now to get it by 4 days"
//                subLabel.font = UIFont.systemFont(ofSize: 14)
//                subLabel.textColor = .black
//                subLabel.numberOfLines = 0
//
//                let infoStack = UIStackView(arrangedSubviews: [truckImage, subLabel])
//                infoStack.axis = .horizontal
//                infoStack.spacing = 8
//                infoStack.alignment = .center
//
//                let fullStack = UIStackView(arrangedSubviews: [topBar, infoStack])
//                fullStack.axis = .vertical
//                fullStack.spacing = 12
//                fullStack.translatesAutoresizingMaskIntoConstraints = false
//
//                headerView.addSubview(fullStack)
//
//                NSLayoutConstraint.activate([
//                    backButton.widthAnchor.constraint(equalToConstant: 30),
//                    backButton.heightAnchor.constraint(equalToConstant: 30),
//                    truckImage.widthAnchor.constraint(equalToConstant: 20),
//                    truckImage.heightAnchor.constraint(equalToConstant: 20),
//                    fullStack.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
//                    fullStack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//                    fullStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//                    fullStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
//                ])
//
//                headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
//                tableView.tableHeaderView = headerView
//            }
//
//            @objc private func handleBack() {
//                countdownTimer?.invalidate()
//                navigationController?.popViewController(animated: true)
//            }
//
//            func numberOfSections(in tableView: UITableView) -> Int {
//                return sections.count
//            }
//
//            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                return (expandedSection == section) ? 1 : 0
//            }
//
//            func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//                return 50
//            }
//
//            func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//                let button = UIButton(type: .system)
//                button.tag = section
//                button.setTitle(sections[section], for: .normal)
//                button.setTitleColor(.black, for: .normal)
//                button.contentHorizontalAlignment = .left
//                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//                button.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
//
//                let plusMinus = UILabel()
//                plusMinus.text = (expandedSection == section) ? "–" : "+"
//                plusMinus.font = UIFont.boldSystemFont(ofSize: 14)
//
//                let container = UIStackView(arrangedSubviews: [button, plusMinus])
//                container.axis = .horizontal
//                container.distribution = .equalSpacing
//                container.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//                container.isLayoutMarginsRelativeArrangement = true
//
//                return container
//            }
//
//            @objc func paymentCheckOut(_ sender: UIButton) {
//                viewmodel.paymentCODApi(orderID: orderID)
//            }
//
//            @objc func toggleSection(_ sender: UIButton) {
//                let section = sender.tag
//                
//                if section == 0 {
//                    self.openRazorpayCheckout()
//
//                   // viewmodel.paymentOnlineApi(amount: Double(amountpaymentFinal) ?? 0.0, name: "Name", productName: "ProductName", orderID: orderID)
//
//                } else {
////                    tableView.beginUpdates()
////                    if expandedSection == section {
////                        expandedSection = nil
////                    } else {
////                        expandedSection = section
////                    }
////                    tableView.endUpdates()
//                }
//               
//            }
//    //const { amount, currency = 'INR', receipt, notes, email, contact, paymentMethod, orderId } = req.body;
//    
//    private func openRazorpayCheckout() {
//        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
//        razorpayObj = RazorpayCheckout.initWithKey("rzp_test_zBwPgh9zUMzz9y", andDelegateWithData: self)
//        let options: [AnyHashable:Any] = [
//            "amount":2453.00,
//            "currency":"INR",
//            "name":"Test Payment iOS",
//            "paymentMethod":"razorpay",
//            "orderId":"\(orderID)",
//            "prefill": [
//                    "contact": "9797979797",
//                    "email": "foo@bar.com"
//                ],
//            "theme":[
//                "color":"#000000"
//            ]
//        ]
//        if let rzp = self.razorpayObj {
//            rzp.open(options)
//        } else {
//            print("Unable to initialize")
//        }
//    }
//    
//    
////    "amount":2453.00,
////    "currency":"INR",
////    "name":"Test Payment iOS",
////    "contact":"997755952",
////    "paymentMethod":"razorpay",
////    "image": "https://pbs.twimg.com/profile_images/1271385506505347074/QIc_CCEg_400x400.jpg",
////    "order_id":"\(orderID)",
////    "prefill": [
////        "contact": "9797979797",
////        "email": "foo@bar.com"
////    ],
////    "theme":[
////        "color":"#000000"
////    ]
////]
//    
//    
//    private func presentAlert(withTitle title: String?, message : String?) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            let OKAction = UIAlertAction(title: "Okay", style: .default)
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//    
//    @objc func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
//        self.presentAlert(withTitle: "Payment Successful", message: response?.description)
//    }
//    
//    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
//        self.presentAlert(withTitle: "Payment Failed", message: str+"\n"+response!.description)
//    }
//            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                if indexPath.section == 2 {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "codCell", for: indexPath) as! CODCell
//                    cell.backgroundColor = .white
//                    cell.selectionStyle = .none
//
//                    cell.button.addTarget(self, action: #selector(paymentCheckOut(_:)), for: .touchUpInside)
//                    cell.configure(with: "PAY ₹\(amountpayment)")
//                    return cell
//                }
//                if indexPath.section == 0 {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "codCell", for: indexPath) as! CODCell
//                    cell.backgroundColor = .white
//                    cell.selectionStyle = .none
//
//                    cell.button.addTarget(self, action: #selector(paymentCheckOut(_:)), for: .touchUpInside)
//                    cell.configure(with: "PAY ₹\(amountpayment)")
//                    return cell
//                }
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//                cell.backgroundColor = .white
//
//                cell.textLabel?.text = "Coming soon..."
//                return cell
//            }
//
//            // MARK: - Countdown Timer
//            func startCountdownTimer() {
//                updateCountdownLabel()
//                countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
//            }
//
//            @objc func updateCountdown() {
//                if remainingTime > 0 {
//                    remainingTime -= 1
//                    updateCountdownLabel()
//                } else {
//                    countdownTimer?.invalidate()
//                    countdownLabel.text = "Expired"
//                    AlertManager.showAlert(on: self,title: "",message: "Session expired") {
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                }
//            }
//
//            func updateCountdownLabel() {
//                let minutes = remainingTime / 60
//                let seconds = remainingTime % 60
//                countdownLabel.textColor = .red
//                countdownLabel.text = "Session Expired in : " + String(format: "%02d:%02d", minutes, seconds)
//            }
//        }
//
//    class CODCell: UITableViewCell {
//
//        private let label: UILabel = {
//            let label = UILabel()
//            label.text = "Cash on delivery is available for this order"
//           // label.font = UIFont(name: ConstantFontSize.regular, size: 14)
//            label.textColor = .black
//            return label
//        }()
//
//        let button: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("PAY ₹2998", for: .normal)
//            button.setTitleColor(.white, for: .normal)
//           // button.titleLabel?.font = UIFont(name: ConstantFontSize.regular, size: 16)
//            button.backgroundColor = .black
//            button.layer.cornerRadius = 0
//            return button
//        }()
//
//        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//            super.init(style: style, reuseIdentifier: reuseIdentifier)
//            setup()
//        }
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//        func configure(with title: String) {
//            button.setTitle(title, for: .normal)
//        }
//
//        private func setup() {
//            let stack = UIStackView(arrangedSubviews: [label, button])
//            stack.axis = .vertical
//            stack.spacing = 12
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            
//            contentView.addSubview(stack)
//
//            NSLayoutConstraint.activate([
//                stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//                stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//                stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//                stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
//                button.heightAnchor.constraint(equalToConstant: 44)
//            ])
//            contentView.backgroundColor = .white
//             backgroundColor = .white
//        }
//    }


