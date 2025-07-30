// Full screen for "All Offers for You" in Swift UIKit

import UIKit
import UIKit
import ImageIO
import MobileCoreServices
struct Offer {
    let tag: String
    let tagColor: UIColor
    let image: UIImage
    let title: String
    let description: String
    let promoCode: String
    let promoBorderColor: UIColor
}

class LMCouponVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var onCouponSelected: ((Double, Double , String,String) -> Void)?

    lazy private var viewmodel = LMCouponMV(hostController: self)

    let titleLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let promoTextField = UITextField()
    let tableView = UITableView()
    var couponFlag: String = ""

    var offers: [Offer] = []
    var filteredOffers: [PromoCode] = []
    var isSearching: Bool = false
    var totalAmount: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupPromoField()
        setupTableView()
        loadMockOffers()
        viewmodel.validateCoupon()

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
    func setupHeader() {
        titleLabel.text = "Coupon"
        titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 18)
        titleLabel.textAlignment = .center
        closeButton.setImage(UIImage(named: "back"), for: .normal)

        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Center the title horizontally and pin to top
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Set close button to right, aligned vertically with title
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupPromoField() {
        promoTextField.placeholder = "Search Here..."
        promoTextField.borderStyle = .roundedRect
        promoTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        view.addSubview(promoTextField)
        promoTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            promoTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            promoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            promoTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CouponCell.self, forCellReuseIdentifier: "CouponCell")
        tableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: promoTextField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func loadMockOffers() {
        offers = [
            Offer(tag: "Cashback Offer", tagColor: UIColor.systemTeal, image: UIImage(named: "cashback") ?? UIImage(), title: "Win upto ₹50 Cashbackwin 100% cashback up to ₹50 on Mobile Recharge of ₹19", description: "Get a chance towin 100% cashback up to ₹50 on Mobile Recharge of ₹19  win 100% cashback up to ₹50 on Mobile Recharge of ₹19 ... T&C", promoCode: "FREEHIT", promoBorderColor: UIColor.systemGreen),
            Offer(tag: "Deal", tagColor: UIColor.systemTeal, image: UIImage(named: "sony") ?? UIImage(), title: "Sony liv, Zee5 and 38 OTTs Powerplay Pack worth ₹399 at ₹99", description: "Do a Mobile Recharge of ₹19 or more and get Sony liv, Zee5 and 38 OTTs ... T&C", promoCode: "RECHOTT", promoBorderColor: UIColor.systemGreen),
            Offer(tag: "Deal", tagColor: UIColor.systemTeal, image: UIImage(named: "levis") ?? UIImage(), title: "Get Extra Rs 500 off on Levi's", description: "Get Minimum 50% Off + Extra ₹500 Off Levi's deal on Mobile Recharge of ... T&C", promoCode: "RECHLEVIS", promoBorderColor: UIColor.systemGreen),
            Offer(tag: "Deal", tagColor: UIColor.systemTeal, image: UIImage(named: "paytm") ?? UIImage(), title: "Paytm Gold worth ₹1,00,000", description: "Get Flat 1% instant discount on digital gold on your next mobile prepaid ... T&C", promoCode: "MOBILEGOLD", promoBorderColor: UIColor.systemGreen),
        ]
        tableView.reloadData()
    }

    @objc func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12 // Adjust space here
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          //  return viewmodel.model?.results.count ?? 0
        return isSearching ? filteredOffers.count : viewmodel.model?.results.count ?? 0
        
        }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isSearching ? filteredOffers.count : offers.count
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "CouponCell", for: indexPath) as? CouponCell else {
               return UITableViewCell()
           }
           cell.selectionStyle = .none
           cell.applyButton.tag = indexPath.row
        
           cell.applyButton.addTarget(self, action: #selector(LMCouponVC.applyDiscount(_:)), for: .touchUpInside)
        //cell.configure(with: offer)
        
        let offer = isSearching ? filteredOffers[indexPath.row] : viewmodel.model?.results[indexPath.row]
        cell.configure(with: offer!)
        
        if couponFlag == offer?.id {
                 cell.applyButton.isUserInteractionEnabled = true
                 cell.applyButton.backgroundColor = .lightGray
                 cell.applyButton.setTitle("Applied", for: .normal)

             } else {
                 cell.applyButton.setTitle("Apply", for: .normal)
                 
                 if Double(offer?.minimumPurchase ?? 0) <  totalAmount {
                     cell.applyButton.backgroundColor = .black
                 } else {
                     cell.applyButton.backgroundColor = .lightGray
                 }
                 cell.applyButton.addTarget(self, action: #selector(LMCouponVC.applyDiscount(_:)), for: .touchUpInside)
             }

           return cell
       }

    @objc func delegateaddress(_ sender : UIButton) {
        let tag = sender.tag
    }
    
    @objc func applyDiscount(_ sender : UIButton) {
        let tag = sender.tag
        let obj = viewmodel.model?.results[tag]
        print(obj)
        if Double(obj?.minimumPurchase ?? 0) <  totalAmount {
            if obj?.discountType == keyName.percentage {
                let finalAmount = applyPercentageDiscount(to: Double(totalAmount), percentage: Double(obj?.discountValue ?? 0))

            
                let dicountvalue = totalAmount - finalAmount
                let dicountvaluetemp = String(format: "%.0f", dicountvalue)
                let finalAmountTemp = String(format: "%.0f", finalAmount)

                onCouponSelected?(Double(finalAmountTemp) ?? 0, Double(dicountvaluetemp) ?? 0.0, obj?.code ?? keyName.emptyStr, obj?.id ?? "")
            } else {
                let finalAmount = applyFlatDiscount(to: Double(totalAmount), flatDiscount: Double(obj?.discountValue ?? 0))
                let dicountvalue = totalAmount - finalAmount
                let dicountvaluetemp = String(format: "%.0f", dicountvalue)
                let finalAmountTemp = String(format: "%.0f", finalAmount)

                onCouponSelected?(Double(finalAmountTemp) ?? 0, Double(dicountvaluetemp) ?? 0.0, obj?.code ?? keyName.emptyStr, obj?.id ?? "")
            }
            navigationController?.popViewController(animated: true)

        } else {
            
        }
        //applyFlatDiscount
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredOffers = (viewmodel.model?.results.filter {
            $0.code.lowercased().contains(searchText.lowercased())
        })!
        tableView.reloadData()
    }

    func applyFlatDiscount(to amount: Double, flatDiscount: Double) -> Double {
        return max(0, amount - flatDiscount)
    }

    /// Applies a percentage discount to the given amount.
    /// - Parameters:
    ///   - amount: The original amount.
    ///   - percentage: The discount percentage (e.g., 10 for 10%).
    /// - Returns: The discounted amount.
    func applyPercentageDiscount(to amount: Double, percentage: Double) -> Double {
        let discount = amount * (percentage / 100)
        return max(0, amount - discount)
    }
//    let priceAfterFlat = applyFlatDiscount(to: originalPrice, flatDiscount: 200)
//    print("Flat Discount: \(priceAfterFlat)")  // 800.0
//
//    let priceAfterPercent = applyPercentageDiscount(to: originalPrice, percentage: 10)
//    print("Percentage Discount: \(priceAfterP
}

class CouponCell: UITableViewCell {

    let tagLabel = UILabel()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let promoCodeLabel = UILabel()
    let applyButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    private let containerView = UIView()

    func setupViews() {
        contentView.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.layer.cornerRadius = 0
            containerView.layer.borderWidth = 0.5
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.backgroundColor = .white
            containerView.clipsToBounds = true

           
        backgroundColor = .white
        layer.cornerRadius = 0
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        clipsToBounds = true

        tagLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        tagLabel.textColor = .white
        tagLabel.backgroundColor = .gray
        tagLabel.layer.cornerRadius = 0
        tagLabel.clipsToBounds = true
        tagLabel.textAlignment = .center

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 0
        iconImageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0

        
        
        descriptionLabel.font = UIFont(name: ConstantFontSize.regular, size: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.numberOfLines = 0

        promoCodeLabel.font = UIFont(name: ConstantFontSize.regular, size: 14)
        promoCodeLabel.textAlignment = .center
        promoCodeLabel.layer.cornerRadius = 0
        promoCodeLabel.layer.borderWidth = 0.2
        promoCodeLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
        promoCodeLabel.clipsToBounds = true
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .black
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 0

        [tagLabel, iconImageView, titleLabel, descriptionLabel, promoCodeLabel, applyButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            

            
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            tagLabel.heightAnchor.constraint(equalToConstant: 20),

            iconImageView.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 8),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),

            
            
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            
            promoCodeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            promoCodeLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            promoCodeLabel.heightAnchor.constraint(equalToConstant: 30),
            promoCodeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 110),
            promoCodeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),

            
            
//            promoCodeLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 25),
//            promoCodeLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
//           // promoCodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
//            promoCodeLabel.widthAnchor.constraint(equalToConstant: 120),
//            promoCodeLabel.heightAnchor.constraint(equalToConstant: 30),

//            applyButton.centerYAnchor.constraint(equalTo: promoCodeLabel.centerYAnchor),
//            applyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//            applyButton.widthAnchor.constraint(equalToConstant: 80),
//            applyButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            
                applyButton.centerYAnchor.constraint(equalTo: promoCodeLabel.centerYAnchor),
                applyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -7),
                applyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
                applyButton.widthAnchor.constraint(equalToConstant: 90),
                applyButton.heightAnchor.constraint(equalToConstant: 30),
                promoCodeLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16),
           // applyButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16),


            //containerView.bottomAnchor.constraint(greaterThanOrEqualTo: promoCodeLabel.bottomAnchor, constant: 12),

            

           // NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.bottomAnchor.constraint(equalTo: promoCodeLabel.bottomAnchor, constant: 12)

//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), // <-- important
            
           // ])
        ])
    }
    func setLabel(_ label: UILabel, text: String, lineSpacing: CGFloat = 6) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attributedString = NSAttributedString(
            string: text,
            attributes: [.paragraphStyle: paragraphStyle]
        )
        label.attributedText = attributedString
    }
        func configure(with offer: PromoCode) {
            tagLabel.text = "  \(offer.codeType)  "
            tagLabel.backgroundColor = UIColor.systemTeal
            iconImageView.image = UIImage(named: "cashback") ?? UIImage()
            setLabel(titleLabel, text: offer.title, lineSpacing: 8)
            setLabel(descriptionLabel, text: offer.description, lineSpacing: 6)
            promoCodeLabel.text  = "  \(offer.code)  "
        }
//    func configure(with offer: Offer) {
//        tagLabel.text = "  \(offer.tag)  "
//        tagLabel.backgroundColor = offer.tagColor
//        iconImageView.image = offer.image
//        titleLabel.text = offer.title
//        descriptionLabel.text = offer.description
//        promoCodeLabel.text = offer.promoCode
//        promoCodeLabel.layer.borderColor = UIColor.lightGray.cgColor
//    }
}



