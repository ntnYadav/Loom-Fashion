import UIKit
import SDWebImage

class LMWishlistVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblWishListCount: UILabel!
    
    @IBOutlet weak var tblWishlist: UITableView!
    @IBOutlet weak var viewEmpty: UIView!
    lazy fileprivate var viewmodel = LMWishlistMV(hostController: self)
    var strClickAct: String = ""
    var arrCotegory = ["All", "Shirts", "T-shirts", "Jeans", "Trouser", "Jacket", "Sweaters", "Sweatshirt", "Shorts", "All", "Shirts", "T-shirts", "Jeans", "Trouser", "Jacket", "Sweaters", "Sweatshirt", "Shorts"]
    var selectedCell = [IndexPath]()
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var actShop: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWishListCount.isHidden = true

        tblWishlist.delegate = self
        tblWishlist.dataSource = self
        viewmodel.validateValueWishListList()
        viewmodel.getCartApi()
        
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

    @IBAction func actShopping(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.model12.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblWishlist.dequeueReusableCell(withIdentifier: "LMwishlistCell", for: indexPath) as! LMwishlistCell
        
        cell.selectionStyle = .none
        cell.btnDelete.tag = indexPath.row
        cell.btnmovvetoBag.tag = indexPath.row
        let objModel = viewmodel.model12[indexPath.row]
        cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgProduct.sd_setImage(with: URL(string: objModel.variantThumbnail?.image ?? ""))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
        cell.imgProduct.addGestureRecognizer(tapGesture)
        
        cell.lblProductname.text = objModel.title
        cell.lblSize.text = objModel.variantThumbnail?.color
        
            let mrp = objModel.lowestMRP ?? 0
            let sellingPrice = objModel.lowestSellingPrice
            let discountPercent = 0
            let attributedPriceText = createPriceAttributedText(
                discountPercent: 0,
                originalPrice: mrp,
                discountedPrice: sellingPrice ?? 0
            )
            cell.lblPrice.attributedText = attributedPriceText
       // }
        
        //if objModel.colorDetails?.sizes?[0].stock?.status == "OUT_OF_STOCK" {
           let  title = "MOVE TO BAG"
            let attributeString = NSMutableAttributedString(string: title, attributes: [
                .foregroundColor: UIColor.black,
                .font:  UIFont(name: ConstantFontSize.Bold, size: 16)
            ])

            cell.btnmovvetoBag.setAttributedTitle(attributeString, for: .normal)
       // }
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(Delete(_:)), for: .touchUpInside)
        cell.btnmovvetoBag.addTarget(self, action: #selector(movetoBag(_:)), for: .touchUpInside)
        cell.btnMovetoBag11.addTarget(self, action: #selector(handleImageTap(_:)), for: .touchUpInside)
        cell.btnMovetoBag11.tag = indexPath.row
        
        return cell
    }
    
        @objc func handleImageTap(_ sender: UIButton) {
            let tag = sender.tag
            let obj = viewmodel.model12[tag]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
            secondVC.productId        = obj.id ?? ""
            secondVC.defaultVaniantID = obj.variantThumbnail?.variantId ?? ""
            self.navigationController?.pushViewController(secondVC, animated: true)
            
                // Do something with index (e.g., open detail, switch tab, etc.)
            
        print("Image tapped!")
        // Navigate or do something
    }
    // MARK: - Action Methods
    @objc func Delete(_ sender: UIButton) {
        let tag = sender.tag
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let objModel = viewmodel.model12[tag]
        //viewmodel.deleteValue(productId: objModel.id ?? "", vaiantID: objModel.requestedVariantId ?? "")
        
        
        viewmodel.callWishListAPIDelete(productId: objModel.id ?? "", strColor: objModel.variantThumbnail?.color ?? "", strVaiantId:objModel.variantThumbnail?.variantId ?? "")
        //viewmodel.callRemoveWishListAPI(productId: objModel.id ?? "", strColor: objModel.colorDetails?.color ?? "", strVaiantId: objModel.requestedVariantId ?? "")
        //arrCotegory.remove(at: sender.tag)  // Remove the item from array
        viewmodel.model12.remove(at: tag)
        if viewmodel.model12.count != 0 {
            let countValue = viewmodel.model12.count
        } else {
            viewEmpty.isHidden = false
        }
        tblWishlist.reloadData()
    }
    func createPriceAttributedText(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()


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
    @objc func movetoBag(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let objModel = viewmodel.model12[sender.tag]
        var arrSize: [String] = []
        var arrSizeq1: [String] = []

      //  let arrSize1: [String] = objModel.variants?.compactMap { $0.size } ?? []

        if let sizes = objModel.colorDetails?.sizes {
            for variant in sizes {
                if variant.stock?.status == "OUT_OF_STOCK" {
                } else {
                    arrSizeq1.append(variant.size ?? "")
                }
                arrSize.append(variant.size ?? "")
            }
        }

        if arrSizeq1.count != 0 {
            let deleteSheet = LMSizeVC()
            deleteSheet.modalPresentationStyle = .overFullScreen
            deleteSheet.modalTransitionStyle = .coverVertical
            deleteSheet.arrSize = objModel.colorDetails?.sizes
            deleteSheet.indeId = sender.tag

            deleteSheet.onKeepTapped = { selectID, vaientId in
                let objModel = self.viewmodel.model12[selectID]
               // self.viewmodel.validateValueWishListMove(productId: objModel.id ?? "", vaiantId: vaientId ?? "")

                self.viewmodel.validateValueWishListMove(productId: objModel.id ?? "", vaiantId: vaientId, color: objModel.colorDetails?.color ?? "")

                print("User kept account")
            }
            present(deleteSheet, animated: true)
            
//            RPicker.selectOption(dataArray: arrSize) {[weak self] (selctedText, atIndex) in
//                
//                self?.viewmodel.deleteValue(productId: objModel.id ?? "", vaiantID: objModel.variantThumbnail?.variantId ?? "")
//                
//                let variantID =  viewmodel.modelproduct?.variantsColor?[0].sizes
//                if let mediumSize = variantID?.first(where: { $0.size == THUserDefaultValue.isUsercolorsize }) {
//                    print("M size is available with price: \(mediumSize.variantId)")
//                    viewmodel.validateAddToCart(productID: productId, variantId: mediumSize.variantId ?? "", qty: 1)
//                }
//
//                
//                self?.viewmodel.model12.remove(at:sender.tag)
//                self?.tblWishlist.reloadData()
//                
//                print("selctedText\(selctedText) atIndex\(atIndex)")
//                
//            }
        } else {
            AlertManager.showAlert(on: self,
                                   title: "",
                                   message: "All product out of stock") {
            }
        }
//        let item = arrCotegory[sender.tag]
//        print("\(item) moved to bag")  // Handle the item as you need
//        
//        // Optionally remove from wishlist:
//        arrCotegory.remove(at: sender.tag)
        
      
        viewmodel.deleteValue(productId: objModel.id ?? "", vaiantID: objModel.variantThumbnail?.variantId ?? "")
//       
//        viewmodel.model12.remove(at:sender.tag)
//        tblWishlist.reloadData()
//        
        
    }

    @IBAction func actBag(_ sender: Any) {
        // Handle bag action here
       // AppDelegate.shared.tabbarBag = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMCartTableVC) as! LMCartTableVC
        secondVC.backBtn = "Product"
        secondVC.navigationControl = true
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }

    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Timer (Optional)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        counter = 0
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()  // Stop timer when the view disappears
    }

//    @objc func updateTimer() {
//        counter += 1
//        print("Counter: \(counter)")
//    }
}
