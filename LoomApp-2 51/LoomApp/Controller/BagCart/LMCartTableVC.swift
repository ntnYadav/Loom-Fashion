//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit
import SDWebImage
import UIKit
import ImageIO
import MobileCoreServices
import SVGKit

class LMCartTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var navigationControl = false
    @IBOutlet weak var lblCount: UIButton!
    let imgGif = UIImage.gifImageWithName("splas")
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var imgGIF1: SDAnimatedImageView!

    @IBOutlet weak var mainViewPay: UIView!
    @IBOutlet weak var viewOfferAlert: UIView!
    @IBOutlet weak var lblFlate: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var viewPopOffer: UIView!
    @IBOutlet weak var btnSHopping: UIButton!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnChnage: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    let tableView = UITableView()
    lazy fileprivate var viewmodel = LMCartTableMV(hostController: self)
    @IBOutlet weak var lblCOuntBag: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    var addresID:String = keyName.name
    var flagBack:Bool = true
    // Sample data: array of sections, each with an array of rows
    @IBOutlet weak var tblcart: UITableView!
    var flag:Bool = true
    var siwtch1:Bool = false
    var siwtch2:Bool = false

    var dicopuntAmountFinal: Int = 0

    var payableAmount: Double = 0.0
    var finalAmountPayment: String = ""
    var discount: String = ""
    var discountcode: String = ""
    var backBtn: String = ""
    var couponFlag: String = ""

    @IBOutlet weak var btnbottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstriain: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    //    var finalAmountPayment: String = ""
//    var finalAmountPayment: String = ""

    let data = [
        ("Fruits", ["Carrot"])]
    @IBOutlet weak var imgHeart: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCOuntBag.isHidden = true
        lblCOuntBag.text = ""
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)

        
        imgGIF1.isHidden = true
        viewOfferAlert.isHidden = true
        if flagBack == false {
            btnBack.isHidden = false
        }
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light

        // Setup TableView
        tblcart.frame = view.bounds
        tblcart.dataSource = self
        tblcart.delegate   = self
        tblcart.register(UINib(nibName: "CartCustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CartCustomHeaderView")
        tblcart.register(UINib(nibName: "LMCartBagCellCell", bundle: nil), forCellReuseIdentifier: "LMCartBagCellCell")

        
        tblcart.register(UINib(nibName: "activePreparedCell", bundle: nil), forCellReuseIdentifier: "activePreparedCell")

        tblcart.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: "ExpandableCell")
        tblcart.register(UINib(nibName: "priceSubCategoryDetailTableCell", bundle: nil), forCellReuseIdentifier: "priceSubCategoryDetailTableCell")
        
        tblcart.register(UINib(nibName: "WalletDetailTableCell", bundle: nil), forCellReuseIdentifier: "WalletDetailTableCell")
        tblcart.register(UINib(nibName: "WalletDetailTableCell1", bundle: nil), forCellReuseIdentifier: "WalletDetailTableCell1")

        view.addSubview(tableView)
        btnSHopping.layer.borderColor = UIColor.lightGray.cgColor
        btnSHopping.layer.borderWidth = 0.5
        viewmodel.validateGetAddressList()
        viewmodel.validateValueWallet()

        if backBtn == "Product" {
            btnbottomConstraint.constant = 20
            bottomConstriain.constant = 20
            btnBack.isHidden = false
            mainViewPay.isHidden = true
        } else {
            btnBack.isHidden = false
            mainViewPay.isHidden = false
        }

    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                print("Swiped Right")

                
            case .right:
                if navigationControl == true {
                    navigationController?.popViewController(animated: true)

                } else {
                    self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
                }
                print("Swiped Right")
            case .up:
                print("Swiped Up")
            case .down:
                print("Swiped Down")
            default:
                break
            }
        }
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    override func viewWillAppear(_ animated: Bool) {

        viewmodel.validateValueWishListList()

        if AppDelegate.shared.tabbarFlag == true {
            viewmodel.validateValue()
        }
    }
    
    // MARK: - TableView DataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        print("data.count ==\(data.count)")
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            viewmodel.modelproduct?.items.reversed()
            return viewmodel.modelproduct?.items.count ?? 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let obj = viewmodel.modelproduct?.items[indexPath.row]
        if obj?.variantId == "offer" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "LMCartSecondCell", for: indexPath) as! LMCartSecondCell
            cell.selectionStyle = .none

            if viewmodel.modelproduct?.pricingSummary.couponDiscount == 0.0  && AppDelegate.shared.couponFlag == ""{
                cell.btnApply.isHidden = true
                cell.lblOfferName.text = "To get more discount use coupon"
                cell.lblApply.text = ""

            } else {
                cell.btnApply.isHidden = false
                let fullText1 = "COUPON "
                let amountText = (viewmodel.modelproduct?.pricingSummary.couponCode ?? "")
                let codeText = " APPLIED"
                let fullText = fullText1 + amountText + codeText
                let attributedText = NSMutableAttributedString(string: fullText,
                    attributes: [.font: UIFont.systemFont(ofSize: 16)])
                // Manually find the start index of the second word
                // Assume words are separated by spaces
                let words = fullText.components(separatedBy: " ")
                var currentLocation = 0
                for (index, word) in words.enumerated() {
                    let wordLength = word.count
                    if index == 1 { // second word
                        let nsRange = NSRange(location: currentLocation, length: wordLength)
                        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: nsRange)
                        break
                    }
                    currentLocation += wordLength + 1 // +1 for the space
                }
                cell.lblOfferName.attributedText = attributedText

                cell.lblApply.text = "Remove"
                cell.btnApply.tag = indexPath.row
                cell.btnApply.addTarget(self, action: #selector(LMCartTableVC.RemoveCart(_:)), for: .touchUpInside)

            }
            
            //self.tblcart.separatorColor = .clear
            return cell
        } else if obj?.variantId == "otherDetail" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableCell
            cell.selectionStyle = .none

            cell.setupEverytime()
            self.tblcart.separatorColor = .clear
            return cell
            
        } else if obj?.variantId == "WithoutLogin" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "activePreparedCell", for: indexPath) as! activePreparedCell
            cell.selectionStyle = .none
            self.tblcart.separatorColor = .clear
            cell.lbl.text =  "Login to use coupon, wallet & coins"
            
            return cell
        } else if obj?.variantId == "ActiveisPrepaid" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "activePreparedCell", for: indexPath) as! activePreparedCell
            cell.selectionStyle = .none
            self.tblcart.separatorColor = .clear
            cell.lbl.text =  "You'II get EXTRA 10% OFF on PREPARED ORDER"
            
            return cell

        } else if obj?.variantId == "ActiveisPrepaid" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "activePreparedCell", for: indexPath) as! activePreparedCell
            cell.selectionStyle = .none
            self.tblcart.separatorColor = .clear
            
            return cell
        
            
        } else if obj?.variantId == "wallet" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "WalletDetailTableCell", for: indexPath) as! WalletDetailTableCell
            cell.selectionStyle = .none
            self.tblcart.separatorColor = .clear
            
            cell.slider1.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
            cell.switch1.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            cell.switch1.tag = indexPath.row

            let tobj = viewmodel.modelwallet

            if let walletBalance = tobj?.walletBalance{
                cell.lblPrice.text = keyName.rupessymbol + "\(Int(walletBalance))"
            }
                    
            cell.lblPrice1.text = keyName.rupessymbol + "0"
            let balance = Double(tobj?.walletBalance ?? 0)
//            let pointValue = Double(tobj?.pointValue ?? 0)
//            let total = balance * pointValue
            cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(tobj?.walletBalance ?? 0)" + " from wallet"
            cell.lblPrice2.text =  keyName.rupessymbol + "\(Int(tobj?.walletBalance ?? 0))"
            cell.slider1.minimumValue = 0
          
            
            let obj1 = viewmodel.modelproduct?.pricingSummary
            
            
            if Int(tobj?.walletBalance ?? 0) > dicopuntAmountFinal {
                if Int(tobj?.walletBalance ?? 0) < Int(obj1?.finalAmount ?? 0) {
                    
                    
                    cell.lblPrice2.text =  keyName.rupessymbol + "\(Int(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal))"
                    cell.slider1.maximumValue = Float(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal)
                    
                    
                    if self.viewmodel.modelproduct?.pricingSummary.sliderValue == 0 {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal))" + " from wallet"

                        cell.slider1.value = Float(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal)
                    } else {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Float(Int(obj1?.sliderValue ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.sliderValue ?? 0))
                    }
                    viewmodel.modelproduct?.pricingSummary.wallet = Double(Float(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal))
                } else {

                    cell.lblPrice2.text =  keyName.rupessymbol + "\(Int(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal))"
                    cell.slider1.maximumValue = Float(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal)
                    //cell.slider1.maximumValue = Float(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal)
                    
                    
                    if self.viewmodel.modelproduct?.pricingSummary.sliderValue == 0 {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal)
                    } else {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(obj1?.sliderValue ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.sliderValue ?? 0))
                    }
                    
                   // cell.slider1.value = Float(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal)
                    viewmodel.modelproduct?.pricingSummary.wallet = Double(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal)
                }
                
                
            } else {
                if Int(tobj?.walletBalance ?? 0) < Int(obj1?.finalAmount ?? 0) {
                    
                    
                    cell.lblPrice2.text =  keyName.rupessymbol + "\(Int(Int(tobj?.walletBalance ?? 0)))"
                    cell.slider1.maximumValue = Float(Int(tobj?.walletBalance ?? 0))
                    
                    
                    if self.viewmodel.modelproduct?.pricingSummary.sliderValue == 0 {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(tobj?.walletBalance ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(tobj?.walletBalance ?? 0))
                    } else {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Float(Int(obj1?.sliderValue ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.sliderValue ?? 0))
                    }
                    viewmodel.modelproduct?.pricingSummary.wallet = Double(Float(Int(tobj?.walletBalance ?? 0)))
                } else {

                    cell.lblPrice2.text =  keyName.rupessymbol + "\(Int(Int(obj1?.finalAmount ?? 0)))"
                    cell.slider1.maximumValue = Float(Int(obj1?.finalAmount ?? 0))
                    //cell.slider1.maximumValue = Float(Int(tobj?.walletBalance ?? 0) - dicopuntAmountFinal)
                    
                    
                    if self.viewmodel.modelproduct?.pricingSummary.sliderValue == 0 {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(obj1?.finalAmount ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.finalAmount ?? 0))
                    } else {
                        cell.lblContent.text =  "Using " + keyName.rupessymbol + "\(Int(Int(obj1?.sliderValue ?? 0)))" + " from wallet"

                        cell.slider1.value = Float(Int(obj1?.sliderValue ?? 0))
                    }
                    
                   // cell.slider1.value = Float(Int(obj1?.finalAmount ?? 0) - dicopuntAmountFinal)
                    viewmodel.modelproduct?.pricingSummary.wallet = Double(Int(tobj?.walletBalance ?? 0))
                }
            }

        
            cell.onSliderValueChanged = { [weak self] newValue in
                   let roundedValue = round(newValue)
                   let updatedAmount = String(format: "%.2f", roundedValue)
                  // cell.lblPrice2.text = keyName.rupessymbol + updatedAmount
                   cell.lblContent.text = "Using \(keyName.rupessymbol)\(updatedAmount) from wallet"
                   self?.viewmodel.modelproduct?.pricingSummary.wallet = Double(roundedValue)
                   self?.viewmodel.modelproduct?.pricingSummary.sliderValue = Double(roundedValue)
                
                  let aa = indexPath.row
                  let indexPath = IndexPath(row: aa + 2, section: 0)
                self?.tblcart.reloadRows(at: [indexPath], with: .automatic)
               }
           
            
            if let walletBalance = tobj?.walletBalance {
                if Int(walletBalance) == 0 || Int(walletBalance) == Int(0.0){
                    cell.switch1.isEnabled = false
                }
            } else {
                if tobj?.walletBalance == nil {
                    cell.switch1.isEnabled = false
                } else {
                    cell.switch1.isEnabled = true
                }
            }
      
            
            if obj?.color == "yes" {
                cell.switch1.isOn = true // ✅ set initial state to OFF
                cell.viewinner1.isHidden = false
            } else {
                cell.switch1.isOn = false
                cell.viewinner1.isHidden = true
            }

            
            return cell
        } else if obj?.variantId == "wallet1" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "WalletDetailTableCell1", for: indexPath) as! WalletDetailTableCell1
            cell.view2.isHidden = false
            cell.selectionStyle = .none
            self.tblcart.separatorColor = .clear
           // cell.switch2.isOn = siwtch2 // ✅ set initial state to OFF
            cell.switch2.addTarget(self, action: #selector(switchChanged1(_:)), for: .valueChanged)
            cell.switch2.tag = indexPath.row
            let tobj = viewmodel.modelwallet
            
         
            let balance = Double(tobj?.pointsBalance ?? 0)
            let pointValue = Double(tobj?.pointValue ?? 0)
            let total = balance * pointValue
            if cell.switch2.isOn == false {
                viewmodel.modelproduct?.pricingSummary.coinsFinal = 0
            } else {
                viewmodel.modelproduct?.pricingSummary.coinsFinal = total
            }
            cell.lblContent2.text =  "Using \(balance) coins " + "(" + keyName.rupessymbol + "\(Int(total))" + ")"
            cell.lblCoin.text =  "Using \(balance) coins " + "(" + keyName.rupessymbol + "\(Int(total))" + ")"
            cell.lblMax.text =  "Max: " + keyName.rupessymbol + "\(Int(total))" + " coins"
            
            if obj?.size == "yes" {
                cell.switch2.isOn = true // ✅ set initial state to OFF

                cell.viewinner2.isHidden = false
            } else {
                cell.switch2.isOn = false // ✅ set initial state to OFF

                cell.viewinner2.isHidden = true
            }
            
            
            
            if let coin = viewmodel.modelproduct?.pricingSummary.coinsFinal{
                if Int(coin) == 0 || Int(coin) == Int(0.0) || coin == nil{
                    cell.switch2.isEnabled = false
                }
            } else {
                if viewmodel.modelproduct?.pricingSummary.coinsFinal == nil {
                    cell.switch2.isEnabled = false

                } else {
                    cell.switch2.isEnabled = true
                }
            }
            
            
            return cell
        } else if obj?.variantId == "price" {
            let cell = tblcart.dequeueReusableCell(withIdentifier: "priceSubCategoryDetailTableCell", for: indexPath) as! priceSubCategoryDetailTableCell
            cell.selectionStyle = .none
            
            cell.btnDelete.isHidden     = true
            cell.lblYoumayLIke.isHidden = true
            let obj = viewmodel.modelproduct?.pricingSummary
            

//            if let wallet = obj?.wallet {
//                cell.lblWallet.text = "- " + keyName.rupessymbol + "\(wallet)"
//            }
            
//            
//            if let price = obj?.payableAmount {
//                let price = String(format: "%.0f", price)
//                cell.lblGrandTotalPrice.text = keyName.rupessymbol  + "\(price)"
//                let amout = "Pay " + keyName.rupessymbol + " \(price)"
//                btnPay.setTitle(amout, for: .normal)
//                finalAmountPayment = "\(price)"
//            }
            if let baseTotal = obj?.baseTotal {
                let baseTotal1 = String(format: "%.0f", baseTotal)
                cell.lblMRPPrice.text = keyName.rupessymbol  + "\(baseTotal1)"
            }
            if let couponDiscount = obj?.couponDiscount {
                let dicountvaluetemp = String(format: "%.0f", couponDiscount)
                cell.lblCouponDiscountprice.text   = "- " +  keyName.rupessymbol  + "\(dicountvaluetemp)"
                discount = " \(dicountvaluetemp)"
            }
            if let couponDiscount = obj?.couponCode {
                discountcode = " \(couponDiscount)"
            }

            if let sellingPrice = obj?.sellingTotal {
                let sellingPrice = String(format: "%.0f", sellingPrice)
                //cell.lblSellingPrice.text =  keyName.rupessymbol  + "\(sellingPrice)"
            }
            
            if let savings = obj?.savings {
                let savings = String(format: "%.0f", savings)
                cell.lblProductDiscountPrice.text =  "- " + keyName.rupessymbol  + "\(savings)"
            }
            
            
            if let coins = obj?.coinsFinal {
                let coins = String(format: "%.0f", coins)
                cell.lblCoin.text =  "- " + keyName.rupessymbol  + "\(coins)"
            }
            
//            if let wallet = obj?.wallet {
//                let wallet = String(format: "%.0f", wallet)
//                cell.lblCoin.text =  "- " + keyName.rupessymbol  + "\(wallet)"
//            }
            
            if let wallet = obj?.sliderValue {
                let wallet = String(format: "%.0f", wallet)
                cell.lblWallet.text =  "- " + keyName.rupessymbol  + "\(wallet)"
            }
            if let price = obj?.payableAmount {
                let price = String(format: "%.0f", price)
               // cell.lblGrandTotalPrice.text = keyName.rupessymbol  + "\(price)"
                
            }
            
            let coins   = obj?.coinsFinal ?? 0
            let wallet  = obj?.wallet ?? 0
            let savings = obj?.savings ?? 0
            let coupon  = obj?.sliderValue ?? 0
            let amountText = (viewmodel.modelproduct?.pricingSummary.couponDiscount) ?? 0

            let total = coins + wallet + savings + coupon + (Double(amountText))
            
            let baseTotal = obj?.baseTotal ?? 0
            let grandTotal = Double(baseTotal) - total
            
            
            //cell.lblGrandTotalPrice.text = keyName.rupessymbol + "\(grandTotal)"
            cell.lblGrandTotalPrice.text = String(format: "%@%.0f", keyName.rupessymbol, grandTotal)

            let finalTotlal = String(format: "%@%.0f", keyName.rupessymbol, grandTotal)
            let amout = "Pay " + " \(finalTotlal)"
            btnPay.setTitle(amout, for: .normal)
            finalAmountPayment = "\(grandTotal)"
            
           
            
            self.tblcart.separatorColor = .clear
            return cell
            
 //       } else if obj?.variantId == "DiscountShow"{
            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPDashboardHeaderCell", for: indexPath) as! LMPDashboardHeaderCell
//            cell.lblheader.text = "FEATURED CATEGORIES"
//            cell.lblheader.font = UIFont(name: "HeroNew-Bold", size: 20)
        } else {
            if indexPath.section == 1 {
                let cell = tblcart.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableCell
                cell.selectionStyle = .none

                cell.setupEverytime()
                self.tblcart.separatorColor = .clear
                return cell
            } else {
                let cell = tblcart.dequeueReusableCell(withIdentifier: "LMCartBagCellCell", for: indexPath) as! LMCartBagCellCell
                cell.selectionStyle = .none

                self.tblcart.separatorColor = .clear
                
                
                cell.btndelete.addTarget(self, action: #selector(LMCartTableVC.DeleteCart(_:)), for: .touchUpInside)
                cell.btndelete.tag = indexPath.row
                let objModel = viewmodel.modelproduct?.items[indexPath.row]
                
                if let url = (objModel?.productImage){
                    cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imgProduct.sd_setImage(with: URL(string: url))
                    //cell.imgProduct.sd_setImage(with: URL(string: objModel.variantThumbnail?.image ?? ""))
                }
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
//                cell.imgProduct.addGestureRecognizer(tapGesture)
                cell.btnImagClick.addTarget(self, action: #selector(LMCartTableVC.imageClickCart(_:)), for: .touchUpInside)
                cell.btnImagClick.tag = indexPath.row
                
                
                
                cell.lblProductDetail.font = UIFont(name: ConstantFontSize.regular, size: 14)
                cell.lblProductName.font   = UIFont(name: ConstantFontSize.regular, size: 14)
                cell.lblSize.font          = UIFont(name: ConstantFontSize.regular, size: 14)
                cell.lblPrice.font         = UIFont(name: ConstantFontSize.regular, size: 14)

                cell.productQty = objModel?.avlVarQnty ?? 0
                cell.lblProductName.text = objModel?.productTitle
                cell.lblProductDetail.text = (objModel?.color ?? "") + " | " + (objModel?.size ?? "")

                if let qty = (objModel?.quantity){
                    cell.lblSize.text = "  QTY | " + String(qty)
                }

                if let url = (objModel?.productImage){
                    cell.imgProduct.sd_setImage(with: URL(string: url))
                }
                cell.onCollectionItemupdateQty = { [weak self] indexvalue, qty in
                    let objModel = self?.viewmodel.modelproduct?.items[indexvalue]
                        self?.viewmodel.validateUpdateQty(id: objModel?.id ?? "", qty: qty)
                }
                
                if let price = viewmodel.modelproduct?.items[indexPath.row].priceSnapshot {
                    let mrp = price.basePrice!
                    let sellingPrice = price.sellingPrice!
                    let discountPercent = 0
                    let attributedPriceText = createPriceAttributedText(
                        discountPercent: 0,
                        originalPrice: mrp,
                        discountedPrice: sellingPrice
                    )
                    cell.lblPrice.attributedText = attributedPriceText
                }
                
                return cell
            }
        }
    }
  
    @objc func imageClickCart(_ sender : UIButton) {
        let tag = sender.tag
        let objModel = viewmodel.modelproduct?.items[tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
        secondVC.productId        = objModel?.productId ?? ""
        secondVC.defaultVaniantID = objModel?.variantId ?? ""
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
//    @objc func handleImageTap(_ sender: UIButton) {
//        let tag = sender.tag
//        //let obj = viewmodel.model12[tag]
//        let objModel = viewmodel.modelproduct?.items[tag]
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
//        secondVC.productId        = objModel?.productId ?? ""
//        secondVC.defaultVaniantID = objModel?.variantId ?? ""
//        self.navigationController?.pushViewController(secondVC, animated: true)
//        
//            // Do something with index (e.g., open detail, switch tab, etc.)
//        
//    print("Image tapped!")
//    // Navigate or do something
//}
    @objc private func switchChanged(_ sender: UISwitch) {
        let tag = sender.tag
           if sender.isOn {
               siwtch1 = true

               sender.isOn = true
               viewmodel.modelproduct?.items[tag].color = "yes"
               print("Switch turned ON")
           } else {
               sender.isOn = false
               siwtch1 = false

               self.viewmodel.modelproduct?.pricingSummary.sliderValue = 0
               viewmodel.modelproduct?.items[tag].color = "no"
           }
        tblcart.reloadData()
       }
    @objc private func switchChanged1(_ sender: UISwitch) {
        let tag = sender.tag
           if sender.isOn {
               siwtch2 = true
               viewmodel.modelproduct?.items[tag].size = "yes"
   
               //stateLabel.text = "Switch is ON"
               print("Switch turned ON")
           } else {
               siwtch2 = false

               sender.isOn = false

               viewmodel.modelproduct?.pricingSummary.coinsFinal = 0
               viewmodel.modelproduct?.items[tag].size = "no"

               //stateLabel.text = "Switch is OFF"
               print("Switch turned OFF")
           }
        tblcart.reloadData()
       }
    @objc private func sliderChanged(_ sender: UISlider) {
           let currentValue = Int(sender.value)
        
        print("\(currentValue)")
          // lbl.text = "Value: \(currentValue)"
       }
    
    @objc func RemoveCart(_ sender : UIButton) {
        let tag = sender.tag
        dicopuntAmountFinal = 0
        AppDelegate.shared.couponFlag = ""
        viewmodel.modelproduct?.pricingSummary.couponDiscount      = 0.0
        self.viewmodel.modelproduct?.pricingSummary.payableAmount  = self.payableAmount
        self.viewmodel.modelproduct?.pricingSummary.couponCode     = ""
        tblcart.reloadData()
    }
    @objc func DeleteCart(_ sender : UIButton) {
        let tag = sender.tag

        if let items = self.viewmodel.modelproduct?.items, tag < items.count {
            let objModel = items[tag]

            // Remove the item first
            self.viewmodel.modelproduct?.items.remove(at: tag)

            // Now update count
            let remainingCount = self.viewmodel.modelproduct?.items.count ?? 0
            //lblCOuntBag.text = remainingCount > 0 ? "\(remainingCount - 4)" : ""

            // Optionally validate the deletion
            self.viewmodel.validateDeleteCart(id: objModel.id ?? "")

            if self.viewmodel.modelproduct?.items.count == 4 {
                self.viewEmpty.isHidden = false
                tblcart.isHidden = true
            }
            tblcart.reloadData()
        } else {
            print("values")
        }
//        let tag = sender.tag
//        if let objModel = self.viewmodel.modelproduct?.items[tag] {
//            if self.viewmodel.modelproduct?.items.count != 0 {
//                lblCOuntBag.text = "\((self.viewmodel.modelproduct?.items.count ?? 0) - 4)"
//            } else {
//                lblCOuntBag.text = ""
//            }
//            
//            self.viewmodel.validateDeleteCart(id: objModel.id ?? "")
//            self.viewmodel.modelproduct?.items.remove(at: tag)
//            tblcart.reloadData()
//        }
    }
    
    @objc func qty(_ sender : UIButton) {
      let tag = sender.tag
        let objModel = viewmodel.modelproduct?.items[tag]
        
        if objModel?.avlVarQnty ?? 0 <= 5 {
            let input = (objModel?.avlVarQnty)!
            let arr = (1...input).map { "\($0)" }
            RPicker.selectOption(dataArray: arr) {[weak self] (selctedText, atIndex) in
                
            }
        } else {
            RPicker.selectOption(dataArray: THconstant.arrqty) {[weak self] (selctedText, atIndex) in
                
            }
        }
    }
    // MARK: - Header Titles
    func createPriceAttributedText(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
//        let discountString = "↓ \(discountPercent)% "
//        let discountAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.systemGreen,
//            .font: UIFont(name: ConstantFontSize.regular, size: 13)
//        ]
//        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
        let originalPriceString = "₹\(Int(originalPrice)) "
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = "₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.Semibold, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tblcart.dequeueReusableHeaderFooterView(withIdentifier: "CartCustomHeaderView") as! CartCustomHeaderView
        //headerView.sectionTitleLabel.text = arrRecent[section]
        self.tblcart.separatorColor = .clear

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 70
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        print("indexPath.section=== \(indexPath.section)")
        if indexPath.section == 1{
            return 800
        } else {
            let obj = viewmodel.modelproduct?.items[indexPath.row]
            if obj?.variantId == "offer" {
                return 90
            } else if obj?.variantId == "ActiveisPrepaid"{
                return 70
            } else if obj?.variantId == "WithoutLogin"{
                return 70
            } else if obj?.variantId == "price"{
                return 300
            } else if obj?.variantId == "wallet"{
                let obj = viewmodel.modelproduct?.items[indexPath.row]
                
                if obj?.color == "yes" {
                    return 190
                } else  {
                    return 90
                }
                    
                return 223

            } else if obj?.variantId == "wallet1"{
                let obj = viewmodel.modelproduct?.items[indexPath.row]
                
                if obj?.size == "yes"{
                    return 190
               
                } else {
                    return 100
                }
                    
                return 223

            } else {
                return 180

            }
         }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewmodel.modelproduct?.items[indexPath.row]
        if obj?.variantId == "offer" {
             let secondVC = LMCouponVC()
              secondVC.totalAmount = self.payableAmount
              secondVC.couponFlag  = AppDelegate.shared.couponFlag

              secondVC.onCouponSelected = { amountFianl , discoutAmount, distype ,couponID  in
                  AppDelegate.shared.tabbarFlag = false

                  AppDelegate.shared.couponFlag = couponID
                  print("User selected: \(amountFianl)\(discoutAmount)\(distype)")
                  self.viewmodel.modelproduct?.pricingSummary.couponDiscount = discoutAmount
                  self.viewmodel.modelproduct?.pricingSummary.payableAmount  = amountFianl
                  self.viewmodel.modelproduct?.pricingSummary.couponCode     = distype

                  self.dicopuntAmountFinal = Int(discoutAmount) ?? 0

                  print("self.viewmodel.modelproduct?.pricingSummary.payableAmount : \(self.viewmodel.modelproduct?.pricingSummary.payableAmount )")
                  self.flag = false
                  DispatchQueue.main.async {
                      self.tblcart.reloadData()
                  }
                  

                  
                  
                  
                  
                  
                  let attributedString = NSMutableAttributedString(
                      string: "\(distype)",
                      attributes: [
                          .foregroundColor: UIColor.black,
                          .font: UIFont.systemFont(ofSize: 13)
                      ]
                  )

                  let secondPart = NSAttributedString(
                      string: "APPLIED",
                      attributes: [
                          .foregroundColor: UIColor.orange,
                          .font: UIFont.boldSystemFont(ofSize: 12)
                      ]
                  )

                  attributedString.append(secondPart)
                  self.lblFlate.attributedText = attributedString
                  let discoutAmount1 = String(format: "%.0f", discoutAmount)
                  self.lblOffer.text = "You Saved ₹ \(discoutAmount1)"


                                    
                  self.imgGIF1.isHidden = false
                  self.viewOfferAlert.isHidden = false

                  self.imgGIF1.sd_imageIndicator = SDWebImageActivityIndicator.gray
                  self.imgGIF1.sd_setImage(with: URL(string: "https://loomfashion-buk123.s3.ap-south-1.amazonaws.com/Uploads/Admin/Images/1750834019491-345765673.gif"), placeholderImage: UIImage(named: "placeholder"))
                  
                  DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                      self?.imgGIF1.isHidden = true
                      self?.viewOfferAlert.isHidden = true

                      self?.imgGIF1.image = nil
                  }

                  
            }
             navigationController?.pushViewController(secondVC, animated: true)
        }
    }
 
 


    
//    func playGIF() {
//        self.imgGIF1.isHidden = false
//
//        if let path = Bundle.main.path(forResource: "64787-success", ofType: "gif"),
//           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//           let gifImage = SDAnimatedImage(data: data) {
//
//            // Assign a new image object to force restart
//            self.imgGIF1.image = nil
//            self.imgGIF1.stopAnimating()
//
//            // Optional: play only once (loop count = 1)
//            self.imgGIF1.startAnimating()
//            self.imgGIF1.image = gifImage
//
//            let duration = gifImage.duration
//            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
//                self?.imgGIF1.isHidden = true
//                self?.imgGIF1.image = nil
//            }
//        }
//    }

    
    @IBAction func actChangeAddress(_ sender: Any) {
       // self.NavigationController(navigateFrom: self, navigateTo: LMAddresslistVC(), navigateToString: VcIdentifier.LMAddresslistVC)
        
        if THUserDefaultValue.isUserLoging  == false {
            let halfVC = LoginVC()
            halfVC.modalPresentationStyle = .overFullScreen
           present(halfVC, animated: true)
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMAddresslistVC) as? LMAddresslistVC {
                modalVC.flagAddressDirectionCheck = true
                modalVC.addressID = addresID
                modalVC.onAddressSelected = { selected, addressID in
                    print("User selected: \(selected)")
                    self.addresID = addressID
                    self.lblAddress.text = "Address: " + selected
                }
                
                self.navigationController?.pushViewController(modalVC, animated: true)
            }
        }
    }
    
    @IBAction func actWishList(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMWishlistVC(), navigateToString: VcIdentifier.LMWishlistVC)

    }
    @IBAction func actPay(_ sender: Any) {
        if THUserDefaultValue.isUserLoging  == false {
            let halfVC = LoginVC()
            halfVC.modalPresentationStyle = .overFullScreen
           present(halfVC, animated: true)
            
        } else {
            
            if self.lblAddress.text ==  "ADDRESS: Add your address" {
                AlertManager.showAlert(on: self,
                                       title: "Please select the address",
                                       message: "") {
                }
            } else {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let obj = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMPaymentFinalVC) as! LMPaymentFinalVC
//                
//                self.navigationController?.pushViewController(obj, animated: true)
                viewmodel.paymentApi(couponDiscount: discount, addressId: self.addresID, couponCode: discountcode, walletPointsToUse: "0")
            }

            
        //    print(finalAmountPayment)
//            let price = (Int(finalAmountPayment) ?? 0) + 100
//            obj.amountpayment = finalAmountPayment
//            obj.coupondiscountAmount = discount
//            obj.couponCode = discountcode
//            obj.AddressID =  self.addresID
            //obj.couponCode = self.lbl
            

        }
        
    }
    
    @IBAction func btnStartShopping(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)

    }
    @IBAction func actBack(_ sender: Any) {
        
        if navigationControl == true {
            navigationController?.popViewController(animated: true)

        } else {
            self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
        }

    }
    
}
