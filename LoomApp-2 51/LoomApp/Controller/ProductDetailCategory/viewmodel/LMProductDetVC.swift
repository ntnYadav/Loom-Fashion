//
//  ViewController.swift
//  BottomSlideDemo
//
//  Created by chetu on 13/05/25.
//

import UIKit
import SwiftUI
import Combine
import SVGKit


class PagerViewModel: ObservableObject {
    @Published var selectedIndex: Int = 0
}

class LMProductDetVC: UIViewController ,UIGestureRecognizerDelegate, UITextFieldDelegate {
    @IBOutlet weak var imgLike: UIImageView!
    var previousContentOffset: CGFloat = 0
    @IBOutlet weak var btnHeart1: UIButton!
    @IBOutlet weak var imgBag: UIImageView!
    @IBOutlet weak var btnline: UIButton!
    @IBOutlet weak var viewpager: UIView!
    
    @IBOutlet weak var imgBagFinal: UIImageView!
    @IBOutlet weak var backImgfinal: UIImageView!
    var sizeChartUrl: String?
    let pagerModel = PagerViewModel()
    var timer = Timer()
    var currentIndex = 0
    var colorName = ""
    var flag  = true
    var sharedValientID = ""

    lazy fileprivate var viewmodel = LMProductDetailFinalMV(hostController: self)
    var productId:String = keyName.emptyStr
    var defaultVaniantID:String = keyName.emptyStr

    @IBOutlet weak var viewheader: UIView!
    @IBOutlet weak var marqueeContainer: UIView!
    @IBOutlet weak var marqueeLabel: UILabel!
    // MARK: - IBOutlets
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var collectionShirts: UICollectionView!
    @IBOutlet weak var sheetTopConst: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    private var panGesture: UIPanGestureRecognizer!
    private var fullViewYPosition: CGFloat = 94
    private var partialViewYPosition: CGFloat = (UIScreen.main.bounds.height - 100) * 0.75
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [Section] = [
        Section(title: "", items: ["Apple"], isExpanded: true),
        Section(title: "DETAILS ", items: ["Carrot"], isExpanded: false),
        Section(title: "OFFERS  ", items: ["Carrot"], isExpanded: false),
        Section(title: "REVIEWS  ", items: ["Carrot"], isExpanded: false),
        Section(title: "DELIVERY ", items: ["Carrot"], isExpanded: false),
        Section(title: "RETURN  ", items: ["Carrot"], isExpanded: false),
        Section(title: "YOU MAY ALSO LIKE", items: ["Carrot"], isExpanded: true),
    ]
    @IBOutlet weak var pagerContainerView: UIView!

    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBagFinal.image = SVGKImage(named: "ic_bagfinal")?.uiImage
        backImgfinal.image = SVGKImage(named: "ic_backfinal")?.uiImage
        imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
        
        THUserDefaultValue.isUserScrolling = false
        //btnline.isHidden = false
        self.viewheader.backgroundColor = .clear
        THUserDefaultValue.isUsercolorsize = nil
        
        tableView.isScrollEnabled = false
        collectionShirts.dataSource = self
        collectionShirts.delegate = self
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
        panGesture.delegate = self
        tableView.addGestureRecognizer(panGesture)
        
        sheetTopConst.constant = -((UIScreen.main.bounds.height - 100) * 0.75)
        viewHeight.constant = UIScreen.main.bounds.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        collectionShirts.showsHorizontalScrollIndicator = false
        collectionShirts.collectionViewLayout = layout
        collectionShirts.isPagingEnabled = true
        collectionShirts.register(UINib(nibName: CellIdentifier.LMPlaycell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.LMPlaycell)
        sharedValientID = defaultVaniantID
        initsetup()
        setupMarqueeContainer()
        setupTableView()
        viewmodel.validateValue(productId: productId, defaultVaniantID: defaultVaniantID)
        startAutoScrollTimer()
        viewmodel.validateCoupon()
        viewmodel.validateProductDetail()
        viewmodel.validateReviewDetail(productId:productId)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = formatter.string(from: Date())
        let dateValue = THUserDefaultValue.userdatefrmate ?? ""
        
        //isCurrentDateGreaterThan(dateValue, currentDateString)
        let result = isCurrentDateGreaterThan(dateValue,currentDateString)//isCurrentDateGreaterThan("2024-06-10", "2024-06-15")
        if result == true {
            print("Is current date true \(result)")
            
            let pincode = THUserDefaultValue.isUserPincode ?? ""
            
            
            let safeWeight = (viewmodel.modelproduct?.dimensions?.widthCm ?? 0.0) > 0 ? viewmodel.modelproduct?.dimensions?.widthCm ?? 0.5 : 0.5
            let safeHeight = (viewmodel.modelproduct?.dimensions?.heightCm ?? 0.0) > 0 ? viewmodel.modelproduct?.dimensions?.heightCm ?? 2.0 : 2.0
            let safeLength = (viewmodel.modelproduct?.dimensions?.widthCm ?? 0.0) > 0 ? viewmodel.modelproduct?.dimensions?.widthCm ?? 30.0 : 30.0
            let safeBreadth = (viewmodel.modelproduct?.weightInKg ?? 0.0) > 0 ? viewmodel.modelproduct?.weightInKg ?? 30.0 : 30.0
            print("dimensions11?.widthCm==\(safeBreadth)==\(safeLength)===\(safeHeight)==\(safeWeight)")
            viewmodel.validatePincodeValue(
                Pincode: pincode,
                weight: safeWeight,
                height: safeHeight,
                breadth: safeBreadth,
                length: safeLength
            )
          
        } else{
            print("Is current date False \(result)")
        }
        print(result)
        
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
    
    func isCurrentDateGreaterThan(_ dateStr1: String, _ dateStr2: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Change format as per your input

        guard let date1 = formatter.date(from: dateStr1),
              let date2 = formatter.date(from: dateStr2) else {
            return false
        }

        let currentDate = Date()
        
        return currentDate > date1 && currentDate > date2
    }
    func startAutoScrollTimer() {
        if THUserDefaultValue.isUserScrolling == false {
            
            let pagerView = VerticalPagerView(viewModel: pagerModel, arrCount: viewmodel.modelproduct?.variants?[0].images ?? [])
            let hostingController = UIHostingController(rootView: pagerView)
            hostingController.view.backgroundColor = .clear
            hostingController.view.isOpaque = false
            addChild(hostingController)
            pagerContainerView.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: pagerContainerView.leadingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: pagerContainerView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: pagerContainerView.bottomAnchor),
                hostingController.view.widthAnchor.constraint(equalToConstant: 340)  // fixed width a bit wider than SwiftUI's 300
            ])
        } else {
            THUserDefaultValue.isUserScrolling = false 
        }
   }

    func initsetup() {
        tableView.register(UINib(nibName: "LMProductHeader", bundle: nil), forCellReuseIdentifier: "LMProductHeader")
        tableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        tableView.register(UINib(nibName: "DevliaryCell", bundle: nil), forCellReuseIdentifier: "DevliaryCell")
        tableView.register(UINib(nibName: "ReturnHTMLcell", bundle: nil), forCellReuseIdentifier: "ReturnHTMLcell")
        tableView.register(UINib(nibName: "LMLastCell", bundle: nil), forCellReuseIdentifier: "LMLastCell")
        tableView.register(UINib(nibName: "LMPrductDetailHeader", bundle: nil), forCellReuseIdentifier: "LMPrductDetailHeader")
        tableView.register(UINib(nibName: CellIdentifier.DetailHTMLcell, bundle: nil), forCellReuseIdentifier: CellIdentifier.DetailHTMLcell)
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMOrderlistVC) as! LMOrderlistVC
//        self.navigationController?.pushViewController(secondVC, animated: true)
        
           setupMarqueeLabel()
           startVerticalMarquee()
       }
    func setupMarqueeContainer() {
                        // Create a container at the bottom
                        marqueeContainer.backgroundColor = .black
                        marqueeContainer.clipsToBounds = true
                marqueeContainer.translatesAutoresizingMaskIntoConstraints = false
        }
            
                    func setupMarqueeLabel() {
                        // Add label after layout is complete
                        marqueeLabel.text = "⬆️ New arrivals just dropped! Swipe up to explore ⬆️"
                        marqueeLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
                        marqueeLabel.textColor = .white
                        marqueeLabel.sizeToFit()
            
                        // Start below the container
                        marqueeLabel.frame = CGRect(
                            x: 10,
                            y: marqueeContainer.bounds.height,
                            width: marqueeLabel.frame.width,
                            height: marqueeLabel.frame.height
                        )
            
                        marqueeContainer.addSubview(marqueeLabel)
                    }
            
                    func startVerticalMarquee() {
                        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveLinear, .repeat], animations: {
                            self.marqueeLabel.frame.origin.y = -self.marqueeLabel.frame.height
                        }, completion: nil)
                    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionShirts.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = collectionShirts.bounds.size
            layout.invalidateLayout()
        }
    }
    func setupTableView() {
        tableView.sectionHeaderTopPadding = 0 // iOS 15+
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          tableView.isHidden = false
          tableView.reloadData()
          tableView.setNeedsLayout()
        
//        if let filePath = Bundle.main.path(forResource: "ic_bag", ofType: "svg") {
//            let svgImage = SVGKImage(contentsOfFile: filePath)
//            imgBag.image = svgImage?.uiImage
//        } else {
//            print("❌ SVG file not found in bundle.")
//        }
//        
//        if let filePath = Bundle.main.path(forResource: "ic_bag", ofType: "svg") {
//            let svgImage = SVGKImage(contentsOfFile: filePath)
//            imgBag.image = svgImage?.uiImage
//        } else {
//            print("❌ SVG file not found in bundle.")
//        }
        
       
    }
    
    
    // MARK: - IBActions
    // Allow both gestures to recognize at the same time (tableView and sheet drag)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == panGesture,
              let pan = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }

        let velocity = pan.velocity(in: view)
        let isVerticalPan = abs(velocity.y) > abs(velocity.x)
        let isQuickTap = abs(velocity.y) < 80

        if !isVerticalPan || isQuickTap {
            return false
        }

        let isDraggingDown = velocity.y > 0
        let sheetIsExpanded = sheetView.frame.origin.y <= fullViewYPosition + 1
        let tableIsAtTop = tableView.contentOffset.y <= 0

        return !sheetIsExpanded || (isDraggingDown && tableIsAtTop)
    }


    // MARK: - SelectorMethods
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Prevent handling if it's just a tap (very low translation)
        let isTap = abs(translation.y) < 5 && abs(velocity.y) < 100
        if isTap {
            return
        }

        switch gesture.state {
        case .changed:
            let newY = sheetView.frame.origin.y + translation.y
            btnline.isHidden = false
            viewheader.backgroundColor = .clear

            if tableView.contentOffset.y <= 0 {
                sheetView.frame.origin.y = max(fullViewYPosition, min(partialViewYPosition, newY))
                gesture.setTranslation(.zero, in: view)
                tableView.isScrollEnabled = false
            } else {
                tableView.isScrollEnabled = true
            }

        case .ended, .cancelled:
            let shouldExpand = velocity.y < 0
            let targetY = shouldExpand ? fullViewYPosition : partialViewYPosition

            UIView.animate(withDuration: 0.3) {
                self.sheetView.frame.origin.y = targetY
            } completion: { _ in
                let isExpanded = (targetY == self.fullViewYPosition)
                self.btnline.isHidden = isExpanded
                //self.viewheader.isHidden = !isExpanded
                self.viewheader.backgroundColor = isExpanded ? .white : .clear
                self.tableView.isScrollEnabled = isExpanded
            }

        default:
            break
        }
    }

    // MARK: - ClassMethods
    private func setupContainerView() {
        let screenHeight = UIScreen.main.bounds.height
        let containerHeight = screenHeight
        sheetView.frame = CGRect(x: 0, y: screenHeight, width: view.bounds.width, height: containerHeight)
        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 16
        sheetView.clipsToBounds = true
        view.addSubview(sheetView)
        // Animate to partial position on launch
        UIView.animate(withDuration: 0.3) {
            self.sheetView.frame.origin.y = self.partialViewYPosition
        }
    }
    
    @IBAction func actBag(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMCartTableVC) as! LMCartTableVC
        secondVC.backBtn = "Product"
        secondVC.navigationControl = true
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actAddToBag(_ sender: Any) {
        self.viewheader.backgroundColor = .clear
//        if THUserDefaultValue.isUserLoging  == false {
//            let halfVC = LoginVC()
//            halfVC.modalPresentationStyle = .overFullScreen
//            self.present(halfVC, animated: true)
//        } else {
            if THUserDefaultValue.isUsercolorsize == nil {
                AlertManager.showAlert(on: self,
                                       title: "Please select the product size",
                                       message: "") {
                }

            } else {
                
                let variantID =  viewmodel.modelproduct?.variantsColor?[0].sizes
                if let mediumSize = variantID?.first(where: { $0.size == THUserDefaultValue.isUsercolorsize }) {
                    print("M size is available with price: \(mediumSize.variantId)")
                    viewmodel.validateAddToCart(productID: productId, variantId: mediumSize.variantId ?? "", qty: 1)
                }
            }
        //}
    }
    func shareContent(from viewController: UIViewController) {
        // Content to share
        let text = "Check out Loom Fashion!"
        let url = URL(string: "https://www.loomfashion.co.in/product/\(productId)?variantId=\(sharedValientID)")!
        let image = UIImage(named: "loomupdated") // Optional image from assets
        var itemsToShare: [Any] = [text, url]
        if let image = image {
            itemsToShare.append(image)
        }

        // Initialize activity view controller
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // For iPads (required to prevent crash)
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                                  y: viewController.view.bounds.midY,
                                                  width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        // Present share sheet
        viewController.present(activityVC, animated: true, completion: nil)
    }

//    @IBAction func actLike(_ sender: Any) {
//        var objModel = viewmodel.modelproduct?.variants?[0].variantId
//       // viewmodel.modelproduct?.variants?[0].images
//        if objModel?.isWishlisted == nil {
//            viewmodel.model?.products.isWishlisted = true
//        } else {
//        if objModel?.isWishlisted == false {
//            viewmodel.model?.products.isWishlisted = true
//        } else {
//            viewmodel.model?.products.isWishlisted = false
//        }
//    }
//        
//        let indexPath = IndexPath(item: tag, section: 0)
//        DispatchQueue.main.async {
//            self.collectionShirts.reloadData()
//        }
//
//        var color1 = ""
//        if self.colorName == "" {
//            color1 = viewmodel.modelproduct?.variantsColor?[0].value ?? ""
//        } else {
//            color1 = self.colorName
//
//        }
//        
//        viewmodel.callWishListAPI(productId: viewmodel.modelproduct?.productId, strColor: viewmodel.modelproduct?.variants?[0].variantId ?? "", strVaiantId:viewmodel.modelproduct?.variants?[0].variantId )
//    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension LMProductDetVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollToNextItem() {
        let itemCount = collectionShirts.numberOfItems(inSection: 0)
        if itemCount == 0 { return }
        
        currentIndex = (currentIndex + 1) % itemCount
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        
        collectionShirts.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // Update pagerModel here as well
        pagerModel.selectedIndex = currentIndex
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Store the initial content offset before the swipe
        previousContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: scrollView.bounds.width / 2,
                                  y: scrollView.contentOffset.y + scrollView.bounds.height / 2)
//////
        if let indexPath = collectionShirts.indexPathForItem(at: centerPoint) {
            currentIndex = indexPath.item
            pagerModel.selectedIndex = currentIndex
            print("Visible index (vertical): \(currentIndex)")
            
        } else {
            print("Could not determine visible index")
        }
    }

    @objc func likeaction(_ sender : UIButton) {
      //  if THUserDefaultValue.isUserLoging == true {
            
            let objModel = viewmodel.modelproduct?.variantsColor?[0].sizes?[0]
            print(objModel)
            if objModel?.isWishlisted == false {
                viewmodel.modelproduct?.variantsColor?[0].sizes?[0].isWishlisted = true
                imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
            } else {
                imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
                viewmodel.modelproduct?.variantsColor?[0].sizes?[0].isWishlisted = false
            }
            
            if self.colorName == "" {
                let color1 = (viewmodel.modelproduct?.variantsColor?[0].value) ?? ""
                viewmodel.callWishListAPI(productId: viewmodel.modelproduct?.productId ?? "", strColor: color1, strVaiantId:viewmodel.modelproduct?.variantsColor?[0].sizes?[0].variantId ?? "")
            } else {
                viewmodel.callWishListAPI(productId: viewmodel.modelproduct?.productId ?? "", strColor: self.colorName, strVaiantId:viewmodel.modelproduct?.variantsColor?[0].sizes?[0].variantId ?? "")
            }
            
            
           
//        } else {
//               let halfVC = LoginVC()
//               halfVC.modalPresentationStyle = .overFullScreen
//               self.present(halfVC, animated: true)
//           
//        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // startAutoScrollTimer()

        return viewmodel.modelproduct?.variants?[0].images?.count ?? 0 //viewmodel.modelproduct?.sizestemp?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Your code here
        print("im tapped here")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPlaycell", for: indexPath) as! LMPlaycell

        let obj = viewmodel.modelproduct?.variants?[0].images?[indexPath.row] ?? keyName.emptyStr
        DispatchQueue.main.async {
            cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProduct.sd_setImage(with: URL(string: obj))
        }
        cell.imgProduct.tag = indexPath.item // or your identifier
        cell.imgProduct.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cell.imgProduct.addGestureRecognizer(tapGesture)
        
        btnHeart1.addTarget(self, action: #selector(LMProductDetVC.likeaction(_:)), for: .touchUpInside)
        let objModel = viewmodel.modelproduct?.variantsColor?[0].sizes?[0]
        if objModel?.isWishlisted == false {
            imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
        } else {
            imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
        }
        

       // cell.btnHeart.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //cell.progressbar()
        cell.btnback.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        cell.btnBag.addTarget(self, action: #selector(movetoBag), for: .touchUpInside)

        cell.setup()
        return cell
    }
    @objc func movetoBag() {
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMAddresslistVC) as? LMAddresslistVC {
            // self.NavigationController(navigateFrom: self, navigateTo: LMAddresslistVC(), navigateToString: VcIdentifier.LMAddresslistVC)
             
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMCartTableVC) as? LMCartTableVC {
                 modalVC.flagBack = false
                 modalVC.navigationControl = true

                 self.navigationController?.pushViewController(modalVC, animated: true)
             }
          
         //}
    }
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        let index = imageView.tag
        let obj = viewmodel.modelproduct?.variants?[0].images?[index] ?? keyName.emptyStr
    let fullVC = LMFullImageVC()
    fullVC.imgUrl = obj
    fullVC.modalPresentationStyle = .fullScreen
    present(fullVC, animated: true, completion: nil)
}

}
extension LMProductDetVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude // Removes footer spacing
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].title.isEmpty ? 0.01 : 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.separatorColor = .clear
        if indexPath.row == 0 && indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.LMProductHeader, for: indexPath) as! LMProductHeader
                cell.selectionStyle = .none
            if self.colorName == "" {
                let color1 = viewmodel.modelproduct?.variantsColor?[0].value
                cell.lblTitle.text = (viewmodel.modelproduct?.title ?? keyName.emptyStr) + " " + (color1 ?? "")
            } else {
                cell.lblTitle.text = (viewmodel.modelproduct?.title ?? keyName.emptyStr) + " " + self.colorName

            }
                 //print(viewmodel.modelproduct)
               // cell.lblprice.text = keyName.rupessymbol + "\(viewmodel.modelproduct?.variants?[0].price.mrp ?? 0)"
               // cell.lblRating.text = "\(viewmodel.modelproduct?.averageRating)"
                sizeChartUrl = viewmodel.modelproduct?.sizeChart ?? ""
            
           

                cell.btnChart.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                cell.btnShare.addTarget(self, action: #selector(sharedImage), for: .touchUpInside)
            
                if let price = viewmodel.modelproduct?.variants?[0].price {
//                    let mrp = price.mrp
//                    let sellingPrice = price.sellingPrice
//                    let discountPercent = price.discountPercents
//                    let attributedPriceText = createPriceAttributedText(
//                        discountPercent: 0,
//                        originalPrice: mrp!,
//                        discountedPrice: sellingPrice!
//                    )
//                    cell.lblprice.attributedText = attributedPriceText
                    
                    
                    
                    
                    let mrp = price.mrp
                    let sellingPrice = price.sellingPrice
                    let discountPercent = price.discountPercents
                    
                    if mrp == sellingPrice {
                    
                        let attributedPriceText = LMGlobal.shared.createPriceAttributedTextWithout(
                                           discountPercent: 0,
                                           originalPrice: 0,
                                           discountedPrice: sellingPrice ?? 0
                                       )
                        cell.lblprice.attributedText = attributedPriceText
                    } else {
                        let attributedPriceText = createPriceAttributedText(
                            discountPercent: 0,
                            originalPrice: mrp!,
                            discountedPrice: sellingPrice!
                        )
                        cell.lblprice.attributedText = attributedPriceText
                        
                    }

                    
                    
                    
                }
            
            
            
            
            
            
            
            
            
            if let price = viewmodel.modelproduct?.variants?.first?.price {
                
                if price.discountType == "flat" {

                    let discount = Int(price.mrp ?? 0) - Int(price.sellingPrice ?? 0)
                    
                    if discount != 0 {
                        cell.lbldiscountPrice.isHidden = false
                        cell.imgBackground.isHidden = false
                        cell.lbldiscountPrice.text = "  ₹\(discount) OFF!"
                      //  cell.lbldiscountPrice.textColor = .white

                        cell.imgBackground.image = UIImage(named: "red-orange")
                    } else {
                        cell.lbldiscountPrice.isHidden = true
                        cell.imgBackground.isHidden = true
                    }
                    
                } else {
                    if let discountPercent = price.discountPercents, discountPercent != 0 {
                        
                        
                        
                        cell.imgBackground.image = UIImage(named: "green")
                        if let finalDiscountPercent1 = price.discountPercents {
                            
                            let formatted = String(format: "%.0f", discountPercent)
                            if finalDiscountPercent1 != 0 {
                                cell.lbldiscountPrice.isHidden = false
                                cell.imgBackground.isHidden = false
                              
                                
                                let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                               // cell.lbldiscountPrice.textColor = .white
                                cell.lbldiscountPrice.text = "  \(formatted)% OFF!"

                                cell.lbldiscountPrice.text = "  ₹\(formatted) % OFF!"
                            } else {
                               cell.lbldiscountPrice.isHidden = true
                               cell.imgBackground.isHidden = true
                            }
                        }

                        
                        
                        
                        
                        let formatted = String(format: "%.0f", discountPercent)
                        cell.lbldiscountPrice.isHidden = false
                        cell.imgBackground.isHidden = false
                        cell.lbldiscountPrice.text = "  \(formatted)% OFF!"
                        cell.lbldiscountPrice.textColor = .white

                        cell.imgBackground.image = UIImage(named: "green gradient")
                    } else {
                        cell.lbldiscountPrice.isHidden = true
                        cell.imgBackground.isHidden = true
                    }
                }
            } else {
              
                
            }

            
            
            
            
//            if objModel.discountType == "flat" {
//                let discount = Int(objModel.lowestMRP ?? 0) - Int(objModel.lowestSellingPrice ?? 0)
////                        cell.lbldiscountPrice.text = "  ₹\(discount) OFF!"
////                    cell.imgBackground.image = UIImage(named: "red")
//                if discount != 0 {
//                    cell.lbldiscountPrice.text = "  ₹\(discount) OFF!"
//                    cell.imgBackground.image = UIImage(named: "red")
//                } else {
//                   cell.lbldiscountPrice.isHidden = true
//                   cell.imgBackground.isHidden = true
//                }
//            } else {
//                cell.imgBackground.image = UIImage(named: "green")
//                if let finalDiscountPercent1 = objModel.finalDiscountPercent {
//                    
//                    let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
//                    if finalDiscountPercent1 != 0 {
//                        let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
//                        cell.lbldiscountPrice.text = "  ₹\(formatted) % OFF!"
//                    } else {
//                       cell.lbldiscountPrice.isHidden = true
//                       cell.imgBackground.isHidden = true
//                    }
//                }
//            }
//            
//            
            
            
            if let rating = viewmodel.modelproduct?.averageRating {
                cell.btnrating.setTitle("\(rating)", for: .normal)

            }
//                    let attributed = NSMutableAttributedString(string: " \(rating)", attributes: [
//                        .font: UIFont(name: ConstantFontSize.Bold, size: 15),.foregroundColor: UIColor.black
//                    ])
//                    let boldText = NSAttributedString(string: " ratings ", attributes: [
//                        .font: UIFont(name: ConstantFontSize.regular, size: 14),
//                        .foregroundColor: UIColor.lightGray
//                    ])
//                    attributed.append(boldText)
//                    cell.lblRating.attributedText = attributed
//                }
                if let review = viewmodel.modelproduct?.reviewCount {
                    
                    let attributed1 = NSMutableAttributedString(string: " \(review)", attributes: [
                        .font: UIFont(name: ConstantFontSize.Bold, size: 15),.foregroundColor: UIColor.black
                    ])
                    let boldText1 = NSAttributedString(string: "  review ", attributes: [
                        .font: UIFont(name: ConstantFontSize.regular, size: 14),
                        .foregroundColor: UIColor.lightGray
                    ])
                    attributed1.append(boldText1)
                    cell.lblReview.attributedText = attributed1
                }
                cell.arrColor = viewmodel.modelproduct?.colors ?? []
                cell.arrSize  = viewmodel.modelproduct?.variantsColor?[0].sizes ?? []
                cell.onCollectionItemTag = { [weak self] arr in
                    print(arr)
                    self?.btnline.isHidden = false
                    self?.viewheader.backgroundColor = .clear
                        self?.colorName =  arr.value ?? ""
                        self?.viewmodel.modelproduct?.variantsColor?[0].sizes = arr.sizes
                        self?.viewmodel.modelproduct?.variants?[0].images     = arr.sizes?[0].images
                        self?.viewmodel.modelproduct?.variants?[0].price      = arr.sizes?[0].price
                    self?.sharedValientID = self?.viewmodel.modelproduct?.variantsColor?[0].sizes?[0].variantId ?? ""

                        self?.collectionShirts.reloadData()
                        self?.tableView.reloadData()
                }
                
                cell.onCollectionItemcolorSize = { [weak self] indevalue, sizeArr in
                    
                    self?.btnline.isHidden = false
                   // self?.viewheader.backgroundColor = .clear

                    self?.viewmodel.modelproduct?.variantsColor?[0].sizes = sizeArr
                    self?.viewmodel.modelproduct?.variants?[0].price      = sizeArr[indevalue].price
                    self?.collectionShirts.reloadData()
                    self?.tableView.reloadData()
                }
                cell.initalSetup()
                return cell
            } else if indexPath.row == 0 && indexPath.section == 1{ //Detail
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.DetailHTMLcell, for: indexPath) as! DetailHTMLcell
                cell.selectionStyle = .none
                let htmlString = viewmodel.modelproduct?.formatedDescription ?? keyName.emptyStr
                
                let fullHTML = wrapHTMLContent("""
                                               \(htmlString)
                                               """)

                // Convert to NSAttributedString
                if let attributedString = htmlToAttributedString(fullHTML) {
                    cell.txtViewDesc.attributedText = attributedString
                }
                return cell
            } else if indexPath.row == 0 && indexPath.section == 2{//Retview
                let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferCell
                cell.selectionStyle = .none

                if viewmodel.modelCoupon?.results.count != 0 {
                    let model = viewmodel.modelCoupon?.results[0]
                    cell.lblcouponTtile.text = model?.title
                    cell.lblCouponCode.text =  "CODE: " + (model?.code ?? "")
                    
                    if viewmodel.modelCoupon?.results.count == 2 {
                        let model1 = viewmodel.modelCoupon?.results[1]
                        cell.lblcouponTtile.text = model1?.title
                        cell.lblCouponCode.text =  "CODE: " + (model1?.code ?? "")
                    } else {
                        cell.img1.isHidden = true
                    }
                } else {
                    cell.lblCouponCode.text =  " No active offer"
                    cell.img1.isHidden = true
                    cell.img2.isHidden = true
                }
                return cell
            }else if indexPath.row == 0 && indexPath.section == 3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LMPrductDetailHeader", for: indexPath) as! LMPrductDetailHeader
                cell.selectionStyle = .none

                if let rating = viewmodel.modelproduct?.averageRating {
                    cell.lblRating.text = "\(rating) "
                }
                cell.btnView.addTarget(self, action: #selector(LMProductDetVC.moreVeview(_:)), for: .touchUpInside)

                if viewmodel.modelReview.count != 0 {
                    cell.customerImages = viewmodel.customerImages
                    if viewmodel.modelReview.count == 1 {
                        cell.heightConstraintView.constant = 0
                        let obj = viewmodel.modelReview[0]
                        cell.modelReviewdata = obj.images
                        cell.lblfirstUserName.text = obj.userName
                        if let rating = obj.rating  {
                            cell.lblUserRating.text    = " \(Int(rating)) ☆"
                        }
                        cell.lblfirstComment.text    = "\(obj.comment ?? "")"
                        
                    } else if viewmodel.modelReview.count == 2 || viewmodel.modelReview.count >= 2{
                        let obj = viewmodel.modelReview[0]
                        cell.modelReviewdata = obj.images
                        cell.lblfirstUserName.text = obj.userName
                        if let rating = obj.rating  {
                            cell.lblUserRating.text    = " \(Int(rating)) ☆"
                        }
                        //cell.lblUserRating.text    = " \(obj.rating ?? 0) ☆"
                        cell.lblfirstComment.text  = "\(obj.comment ?? "")"
                        
                        if obj.images?.count == 0 {
                            //cell.heightConstraintView.constant    = 0
                            cell.firstViewConstraintHeight.constant = 80
                            cell.FirstheightConstraintView.constant = 80
                        }
                        
                        
//                        @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
//                        @IBOutlet weak var collection2hieght: NSLayoutConstraint!
//                        
//                        @IBOutlet weak var seconViewHightConstraint: NSLayoutConstraint!
//                        @IBOutlet weak var firstViewConstraintHeight: NSLayoutConstraint!
//                        @IBOutlet weak var FirstheightConstraintView: NSLayoutConstraint!
//                        
                        
                        let obj1 = viewmodel.modelReview[1]
                        if obj1.images?.count == 0 {
//                            cell.collection2hieght.constant    = 0
//                            cell.seconViewHightConstraint.constant = 70
                        }
                        cell.modelReviewdata1 = obj1.images
                        if let rating = obj1.rating  {
                            cell.lblSecondUserRating.text = " \(Int(rating)) ☆"
                        }
                        cell.lblSecondUser.text = obj1.userName
                        cell.lblSecondDesc.text = "\(obj1.comment ?? "")"
                        
                    } else {
                        cell.lblRating.text = "0 "
                    }
                    
                   
                    cell.initalCollectionCall()
                } else {
                    cell.lblRating.text = "0 "
                }
                return cell
            }else if indexPath.row == 0 && indexPath.section == 4 {//returm
                let cell = tableView.dequeueReusableCell(withIdentifier: "DevliaryCell", for: indexPath) as! DevliaryCell
                
                cell.selectionStyle = .none
                if THUserDefaultValue.isUserPincodeLoging  == true {
                    cell.view24.isHidden      = false
                    cell.imgTraqck.isHidden   = false
                    let dateformate = THUserDefaultValue.userdatefrmate ?? ""

                   // let threeDaysAgo = dateThreeDaysAgo()
                    let formatted = addThreeDays(to: dateformate)
                    
                    
                   // (to: dateformate)

                    let pincode = THUserDefaultValue.isUserPincode ?? ""
                    if pincode == "" {
                        
                    } else {
                        
                    }
                    let StrEstimate1 = formatted.components(separatedBy: ",").first ?? ""

                    let fullText = "Delivery to \(pincode) by \(StrEstimate1)"
                    let attributedText = NSMutableAttributedString(string: fullText)

                    if let range = fullText.range(of: pincode) {
                        let nsRange = NSRange(range, in: fullText)
                        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
                        // Optional: also bold it or change color
                        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: nsRange)
                    }

                    cell.lblPincode.attributedText = attributedText
                    
                    cell.btnDelivery.addTarget(self, action: #selector(openPincodeController), for: .touchUpInside)

                    
                    //cell.btnDelivery.setTitle("Delivery to \(THUserDefaultValue.isUserPincode ?? "")", for: .normal)
                } else {
                    cell.view24.isHidden      = true
                    cell.imgTraqck.isHidden   = true

                }
                
                return cell
            }else if indexPath.row == 0 && indexPath.section == 5{//returm
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.DetailHTMLcell, for: indexPath) as! DetailHTMLcell
                cell.selectionStyle = .none
                showRefundPolicy(in: cell.txtViewDesc)

                return cell

            }else if indexPath.row == 0 && indexPath.section == 6{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LMLastCell", for: indexPath) as! LMLastCell
                
                if viewmodel.modelproduct?.similarProducts?.count != nil ||  viewmodel.modelproduct?.similarProducts?.count != 0  {
                    cell.productsdetail = viewmodel.modelproduct?.similarProducts ?? []
                    cell.initSet()
                    
                    cell.onproductItemTapLike = { [weak self] collectionIndexPath, variantId , color in
                        print(collectionIndexPath)
                        self?.viewmodel.callWishListAPI(productId: collectionIndexPath, strColor: color, strVaiantId:variantId)

                    }
                    
                    cell.onproductItemTap1 = { [weak self] collectionIndexPath, variantId in
                        print(collectionIndexPath)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
                        secondVC.productId        = collectionIndexPath
                        secondVC.defaultVaniantID = variantId
                        self?.navigationController?.pushViewController(secondVC, animated: true)
                    }
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
                return cell
            }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
//        return cell
    }
    
    func extractNumber(_ str: String) -> Int {
        return Int(str.filter { $0.isNumber }) ?? Int.max
    }
    @objc func moreVeview(_ sender : UIButton) {
      let tag = sender.tag
        THUserDefaultValue.isUserScrolling = true
        self.viewheader.backgroundColor = .clear

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMReviewRateListVC) as! LMReviewRateListVC
        secondVC.productId      = productId
        self.navigationController?.pushViewController(secondVC, animated: true)
        
  

    }
    func addThreeDays(to inputDateString: String) -> String {
        let formatter = DateFormatter()
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.locale = Locale(identifier: "en_IN") // ✅ Indian locale

        formatter.dateFormat = "MMM dd, yyyy"  // Matches: "Jun 20, 2025"

        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MMM dd, yyyy"
        let currentDateString = formatter1.string(from: Date())
        
        
        
        guard let date = formatter.date(from: currentDateString) else {
            print("❌ Invalid input date string: \(inputDateString)")
            return ""
        }

        if let savedDays = Int(THUserDefaultValue.userdateDays ?? "") {
            
            if savedDays >= 5 {
                
                if let newDate = Calendar.current.date(byAdding: .day, value: (savedDays - 2), to: date) {
                    return formatter.string(from: newDate)
                }
                // ✅ savedDays is greater than or equal to currentDays
            } else {
                guard let date = formatter.date(from: inputDateString) else {
                    print("❌ Invalid input date string: \(inputDateString)")
                    return ""
                }
                
                if let newDate = Calendar.current.date(byAdding: .day, value: 0, to: date) {
                    return formatter.string(from: newDate)
                }
                // ❌ savedDays is less than currentDays
            }

        }
        
        
     
        return ""
    }
    // MARK: - Section Header
    
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
   
        let headerHeight: CGFloat = 50
        let width = tableView.frame.width
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: headerHeight))
        headerView.backgroundColor = .white
        headerView.tag = section
        headerView.isUserInteractionEnabled = true
        // MARK: - Top Border
    let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0.2))
        
        headerView.addSubview(topBorder)
       let imageView = UIImageView(frame: CGRect(x: width - 36, y: (headerHeight - 20)/2, width: 20, height: 20))
        // MARK: - Bottom Border
    let bottomBorder = UIView(frame: CGRect(x: 0, y: headerHeight - 1, width: width, height: 0.2))
    
    if section == 0 {
        topBorder.isHidden = true
        topBorder.backgroundColor = .white
        bottomBorder.isHidden = true
        bottomBorder.backgroundColor = .white
        imageView.isHidden = true
    } else {
        topBorder.isHidden = false
        imageView.isHidden = false
        topBorder.backgroundColor = .lightGray
        bottomBorder.isHidden = false
        bottomBorder.backgroundColor = .lightGray
    }
        headerView.addSubview(bottomBorder)

        // MARK: - Left Label
    var leftLabel = UILabel(frame: CGRect(x: 16, y: 5, width: collectionShirts.frame.width, height: headerHeight - 10))
        leftLabel.text = sections[section].title
        leftLabel.font = UIFont(name: ConstantFontSize.regular, size: 14)
        leftLabel.textAlignment = .left
        headerView.addSubview(leftLabel)

        // MARK: - Center Label
        let centerLabel = UILabel(frame: CGRect(x: 0, y: 5, width: collectionShirts.frame.width - 10, height: headerHeight - 10))
        centerLabel.text = sections[section].title
        centerLabel.font = UIFont(name: ConstantFontSize.regular, size: 16)
        centerLabel.textAlignment = .center
        headerView.addSubview(centerLabel)

        // MARK: - Right Image (Plus/Minus)
        imageView.contentMode = .scaleAspectFit
        let isExpanded = sections[section].isExpanded
        if isExpanded {
            //leftLabel = UILabel(frame: CGRect(x: 0, y: 5, width: collectionShirts.frame.width, height: headerHeight - 10))
            centerLabel.isHidden = false
            leftLabel.isHidden = true

            leftLabel.textAlignment = .center
            imageView.image = UIImage(named: "Minus")
            
            // Make sure image is in Assets.xcassets
        } else {
           // leftLabel = UILabel(frame: CGRect(x: 16, y: 5, width: collectionShirts.frame.width, height: headerHeight - 10))
            centerLabel.isHidden = true
            leftLabel.isHidden = false

            leftLabel.textAlignment = .left
            imageView.image = UIImage(named: "Plus")
      
        }
        headerView.addSubview(imageView)
        // MARK: - Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExpandCollapse(_:)))
        headerView.addGestureRecognizer(tapGesture)
    
    if section == 6 {
        imageView.isHidden = true
        centerLabel.font = UIFont(name: ConstantFontSize.Bold, size: 16)
    }
        return headerView
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don’t do: tableView.isHidden = true
    }
    @objc func handleExpandCollapse(_ gesture: UITapGestureRecognizer) {
        guard let section = gesture.view?.tag else { return }
        if section != 6 {
            if section == 4 {
                
                let pincode = THUserDefaultValue.isUserPincode ?? ""
                if pincode == "" {
                    
                       // viewheader.isHidden = true
                        //btnline.isHidden = false
                        self.viewheader.backgroundColor = .white
                        print("viewmodel.modelproduct?.dimensions==\(viewmodel.modelproduct?.dimensions)")
                        let deleteSheet = LMPincodeVC()
                        deleteSheet.dimensions11 = viewmodel.modelproduct?.dimensions
                        deleteSheet.widgthKM11   = viewmodel.modelproduct?.weightInKg ?? 0.0
                        deleteSheet.modalPresentationStyle = .overFullScreen
                        deleteSheet.modalTransitionStyle = .coverVertical
                        
                        deleteSheet.onApplyTapped = { [weak self] indevalue, sizeArr in
                            THUserDefaultValue.isUserPincodeLoging = true
                            print("User confirmed delete\(indevalue)\(sizeArr)")
                            THUserDefaultValue.isUserPincode   = indevalue
                            
                                self?.sections = [
                                Section(title: "", items: ["Apple"], isExpanded: true),
                                Section(title: "DETAILS ", items: ["Carrot"], isExpanded: false),
                                Section(title: "OFFERS  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "REVIEWS  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "DELIVERY ", items: ["Carrot"], isExpanded: true),
                                Section(title: "RETURN  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "YOU MAY ALSO LIKE", items: ["Carrot"], isExpanded: true),
                            ]
                            
                            
                           
                            self?.tableView.reloadData()
                        }
                        present(deleteSheet, animated: true)
                    
                } else {
                    if THUserDefaultValue.isUserPincodeLoging == true {
                        sections[section].isExpanded.toggle()
                        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
                    } else {
                       // viewheader.isHidden = true
                        //btnline.isHidden = false
                        self.viewheader.backgroundColor = .white
                        print("viewmodel.modelproduct?.dimensions==\(viewmodel.modelproduct?.dimensions)")
                        let deleteSheet = LMPincodeVC()
                        deleteSheet.dimensions11 = viewmodel.modelproduct?.dimensions
                        deleteSheet.widgthKM11   = viewmodel.modelproduct?.weightInKg ?? 0.0
                        deleteSheet.modalPresentationStyle = .overFullScreen
                        deleteSheet.modalTransitionStyle = .coverVertical
                        
                        deleteSheet.onApplyTapped = { [weak self] indevalue, sizeArr in
                            THUserDefaultValue.isUserPincodeLoging = true
                            print("User confirmed delete\(indevalue)\(sizeArr)")
                            THUserDefaultValue.isUserPincode   = indevalue
                            
                                self?.sections = [
                                Section(title: "", items: ["Apple"], isExpanded: true),
                                Section(title: "DETAILS ", items: ["Carrot"], isExpanded: false),
                                Section(title: "OFFERS  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "REVIEWS  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "DELIVERY ", items: ["Carrot"], isExpanded: true),
                                Section(title: "RETURN  ", items: ["Carrot"], isExpanded: false),
                                Section(title: "YOU MAY ALSO LIKE", items: ["Carrot"], isExpanded: true),
                            ]
                            
                            
                           
                            self?.tableView.reloadData()
                        }
                        present(deleteSheet, animated: true)
                    }
                }
                
          
            } else {
                sections[section].isExpanded.toggle()
                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr

        if indexPath.row == 0 && indexPath.section == 0{
            return 420
        }else if indexPath.row == 0 && indexPath.section == 1{
            let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr
            let textHeight = htmlString.height(withConstrainedWidth: tableView.frame.width - 40, font: UIFont(name: ConstantFontSize.regular, size: 16)!)
                return textHeight + 450
        } else if indexPath.row == 0 && indexPath.section == 2 {
            if viewmodel.modelCoupon?.results.count != 0 {
                if viewmodel.modelCoupon?.results.count == 1 {
                    return 70
                } else if viewmodel.modelCoupon?.results.count == 2 {
                    return 130
                }
            } else {
                return 130
            }
            return 130
        } else if indexPath.row == 0 && indexPath.section == 3 {
            
                guard viewmodel.modelReview.count > indexPath.row else {
                    return 100
                }

            if viewmodel.modelReview.count != 0 {
                
                if viewmodel.modelReview.count == 1 {
                    let obj = viewmodel.modelReview[0]
                    let commentText = obj.comment ?? ""
                    let hasText = !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    let imageCount = obj.images?.count ?? 0
                    let hasImages = imageCount > 0
                    var totalHeight: CGFloat = 20 // Top + bottom padding
                    // ➤ Text Height
                    if hasText {
                        let font = UIFont(name: ConstantFontSize.regular, size: 16) ?? .systemFont(ofSize: 16)
                        let maxWidth = tableView.bounds.width - 32 // 16pt left/right
                        let boundingRect = NSString(string: commentText).boundingRect(
                            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                            attributes: [.font: font],
                            context: nil
                        )
                        totalHeight += ceil(boundingRect.height)
                    }
                    // ➤ Image Height
                    if hasImages {
                        totalHeight += 120 // Image height
                        totalHeight += 10  // Spacing
                    }
                    
                    if viewmodel.customerImages.count != 0 {
                        return (totalHeight + 190)

                    }
                    return (totalHeight + 250)
                    
                    
                } else if viewmodel.modelReview.count == 2 || viewmodel.modelReview.count >= 2 {
                    
                    let obj = viewmodel.modelReview[0]
                    let commentText = obj.comment ?? ""
                    let hasText = !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    let imageCount = obj.images?.count ?? 0
                    let hasImages = imageCount > 0
                    var totalHeight: CGFloat = 20 // Top + bottom padding
                    // ➤ Text Height
                    if hasText {
                        let font = UIFont(name: ConstantFontSize.regular, size: 16) ?? .systemFont(ofSize: 16)
                        let maxWidth = tableView.bounds.width - 32 // 16pt left/right
                        let boundingRect = NSString(string: commentText).boundingRect(
                            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                            attributes: [.font: font],
                            context: nil
                        )
                        totalHeight += ceil(boundingRect.height)
                    }
                    // ➤ Image Height
                    if hasImages {
                        totalHeight += 120 // Image height
                        totalHeight += 10  // Spacing
                    }
                    
                    
                    let obj1 = viewmodel.modelReview[1]
                    let commentText1 = obj.comment ?? ""
                    let hasText1 = !commentText1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    let imageCount1 = obj1.images?.count ?? 0
                    let hasImages1 = imageCount1 > 0
                    var totalHeight1: CGFloat = 20 // Top + bottom padding
                    // ➤ Text Height
                    if hasText1 {
                        let font = UIFont(name: ConstantFontSize.regular, size: 16) ?? .systemFont(ofSize: 16)
                        let maxWidth1 = tableView.bounds.width - 32 // 16pt left/right
                        let boundingRect1 = NSString(string: commentText1).boundingRect(
                            with: CGSize(width: maxWidth1, height: .greatestFiniteMagnitude),
                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                            attributes: [.font: font],
                            context: nil
                        )
                        totalHeight1 += ceil(boundingRect1.height)
                    }
                    // ➤ Image Height
                    if hasImages1 {
                        totalHeight1 += 120 // Image height
                        totalHeight1 += 10  // Spacing
                    }
                    
                    
                    
                    
                    if viewmodel.customerImages.count != 0 {
                        return (totalHeight + totalHeight1 + 390)

                    }

                    
                    
                    return (totalHeight + totalHeight1 + 450)
                    
                }
                
                return 100
                
            
            }
            return 0

        }else if indexPath.row == 0 && indexPath.section == 4 {
            return 90
        }else if indexPath.row == 0 && indexPath.section == 5 {
            return 320
        }else if indexPath.row == 0 && indexPath.section == 6 {
            guard let arrCount = viewmodel.modelproduct?.similarProducts?.count else { return 0 }
            
            if (arrCount % 2) == 0 {
                print("Array has an even number of elements.")
                return CGFloat(200 * arrCount)

            } else {
                print("Array has an odd number of elements.")
                return CGFloat(200 * arrCount)

            }
            
            return CGFloat(190 * arrCount)
        } else {
        
            return 0
        }
    }
    @objc func openPincodeController() {
       // viewheader.isHidden = true
        btnline.isHidden = false
        self.viewheader.backgroundColor = .white

        print("viewmodel.modelproduct?.dimensions==\(viewmodel.modelproduct?.dimensions)")
        let deleteSheet = LMPincodeVC()
        deleteSheet.dimensions11 = viewmodel.modelproduct?.dimensions
        deleteSheet.widgthKM11  = viewmodel.modelproduct?.weightInKg ?? 0.0
        deleteSheet.modalPresentationStyle = .overFullScreen
        deleteSheet.modalTransitionStyle = .coverVertical
        deleteSheet.onApplyTapped = { [weak self] indevalue, sizeArr in
            //print("User confirmed delete\(indevalue)\(sizeArr)")
            THUserDefaultValue.isUserPincode   = indevalue
            self?.tableView.reloadData()
        }
        present(deleteSheet, animated: true)

    }
    @objc func sharedImage() {
        self.viewheader.backgroundColor = .white

        shareContent(from: self)
    }
    @objc func backButtonTapped() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let chartVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMChartVC) as? LMChartVC {
//            chartVC.sizeChartUrl = sizeChartUrl ?? ""
//            chartVC.modalPresentationStyle = .overFullScreen
//            chartVC.modalTransitionStyle = .crossDissolve
//            self.present(chartVC, animated: true, completion: nil)
//            
//            
 
        let fullVC = LMFullImageVC()
        fullVC.imgUrl = sizeChartUrl ?? ""
        fullVC.modalPresentationStyle = .fullScreen
        fullVC.modalPresentationStyle = .overFullScreen
        fullVC.modalTransitionStyle = .crossDissolve
        present(fullVC, animated: true, completion: nil)
        
    
    }
    func htmlToAttributedString(_ html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print("❌ HTML Parsing failed:", error)
            return nil
        }
    }
    private func wrapHTMLContent(_ bodyHTML: String) -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <style>
            body { font-family: HeroNew-Regular; font-size: 15px; color: #000; }
            p { margin: 10px 0; }
            strong { font-weight: bold; display: block; margin-top: 12px; }
        </style>
        </head>
        <body>
        \(bodyHTML)
        </body>
        </html>
        """
    }
    func showRefundPolicy(in textView: UITextView) {
        let htmlString = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <style>
            body {
              font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
              padding: 16px;
              color: #333;
              line-height: 1.6;
            }
            h2 {
              color: #000;
              font-size: 20px;
              margin-top: 24px;
            }
            h3 {
              color: #444;
              font-size: 17px;
              margin-top: 20px;
            }
            ul {
              padding-left: 20px;
              margin: 8px 0;
            }
            li {
              margin-bottom: 6px;
            }
            .note {
              color: #d32f2f;
              font-weight: bold;
            }
            a {
              color: #0066cc;
              text-decoration: none;
            }
          </style>
        </head>
        <body>

                  <p>1.
        Hassle-free returns within 7 days under specific product and promotion conditions.</p>

                          <p>2.
        Refunds for prepaid orders revert to the original payment method, while COD orders receive a wallet refund.</p>

                          <p>3.
        Report defective, incorrect, or damaged items within 24 hours of delivery.</p>

                          <p>4.
        Products bought during special promotions like BOGO are not eligible for returns.</p>

                          <p>5.
        For excessive returns, reverse shipment fee upto Rs 100 can be charged, which will be deducted from the refund.</p>

                          <p>6.
        Non-returnable items include accessories, sunglasses, perfumes, masks, and innerwear due to hygiene concerns.</p>
        
        </body>
        </html>

        """

        guard let data = htmlString.data(using: .utf8) else {
            textView.text = "Failed to load content."
            return
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            textView.attributedText = attributedString
        } catch {
            textView.text = "Error rendering HTML: \(error.localizedDescription)"
        }
    }

    func strikethroughText(_ text: String, color: UIColor = .black) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    func createPriceAttributedText(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
//        let discountString = "↓ \(discountPercent)%   "
//        let discountAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.red,
//            .font: UIFont(name: ConstantFontSize.regular, size: 13)
//        ]
//        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
        let originalPriceString = "₹\(Int(originalPrice))"
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = "   ₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }
}

import SwiftUI
import SVGKit
import SDWebImage
struct VerticalPagerView: View {
    @ObservedObject var viewModel: PagerViewModel
    let arrCount: [String] // or any array of items

    var body: some View {
        HStack(spacing: 0) {
            // Vertical Dots
            VStack {
                ForEach(0..<arrCount.count, id: \.self) { index in
                    Capsule()
                        .frame(width: viewModel.selectedIndex == index ? 10 : 8,
                               height: viewModel.selectedIndex == index ? 24 : 8)
                        .foregroundColor(viewModel.selectedIndex == index ? .black : .black)
                        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                        .padding(.vertical, 4)
                }
            }
            .padding(.leading, 10)

            // Pager
            TabView(selection: $viewModel.selectedIndex) {
                ForEach(0..<arrCount.count, id: \.self) { index in
                    ZStack {
                        Color.clear
//                        Text(arrCount[index])
//                            .font(.largeTitle)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .rotationEffect(.degrees(-90))
            .frame(width: 300, height: 500)
            .clipped()
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: -200)
        }
        .background(Color.clear) // <-- Add this

    }
   
}
