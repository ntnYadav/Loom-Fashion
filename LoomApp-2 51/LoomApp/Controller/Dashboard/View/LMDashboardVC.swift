//
//  ViewController.swift
//
//  Created by chetu on 02/04/25.
//

import UIKit
import AVKit
import SwiftUI
import SDWebImage

class LMDashboardVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    lazy fileprivate var viewmodel = LMDashboardMV(hostController: self)
    var isLoading = false
    var currentPage = 1
    var mobileBrand = [MobileBrand]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "customShopHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "customShopHeaderView")
        overrideUserInterfaceStyle = .light
        mobileBrand.append(MobileBrand.init(brandName: "Apple", modelName: ["iPhone 5s","iPhone 6","iPhoneß 6s"]))
        mobileBrand.append(MobileBrand.init(brandName: "Samsung", modelName: ["Samsung M Series"]))
       viewmodel.validateValue()
       viewmodel.getCategoryApi()
    }
   
    override func viewWillAppear(_ animated: Bool) {
//        let vc = ReviewViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        mainTableView.contentInsetAdjustmentBehavior = .never

        self.mainTableView.reloadData()
     
        mainTableView.sectionHeaderTopPadding = 0 // iOS 15+

        
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
    
    func navigateToFinalDestination() {
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
      }
    }

extension LMDashboardVC : UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let section = 0 // First section
        let headerRect = mainTableView.rectForHeader(inSection: 1)
        let offsetY = scrollView.contentOffset.y
        let topInset = (scrollView.adjustedContentInset.top + 50)
        print("topInset===\(topInset)")
        print("offsetY===\(offsetY)")

        if offsetY >= headerRect.origin.y - topInset {
            print("Header is pinned at top ✅")
        } else {
            print("Header is not pinned yet ⬇️")
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mobileBrand.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0 // Set your desired height
        }
        return 185 // Set your desired height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = mainTableView.dequeueReusableHeaderFooterView(withIdentifier: "customShopHeaderView") as! customShopHeaderView
        if viewmodel.model?.subcategories.count != nil {
            headerView.subcategoriesitem.removeAll()
            headerView.subcategoriesitem = viewmodel.model!.subcategories1 ?? []
           // headerView.subcategoriesitem.append(Subcategory.init(_id: "0", name: "All", image: "", sequence: 0))
            headerView.initsetup()
            headerView.onCollectionItemTag = { [weak self] productname in

                self?.viewmodel.getProductListing(productID: productname, tagValue: productname, page: "1", limit: "50", subcategoryId: productname)
                         }
                     }
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.mainTableView.separatorColor = .clear
        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
                let cell = dequeueCell(ofType: Cell1.self, for: indexPath)
                cell.selectionStyle = .none

                if viewmodel.modelBanner?.count != nil {
                    cell.modelBanner = viewmodel.modelBanner ?? []
                }
                
                
                
                cell.onproductItemTapSearchBar = { [weak self] collectionIndexPath in
                    self?.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)

                }
                cell.setInit()
                return cell

            case 1:
                let cell = dequeueCell(ofType: HeaderCell.self, for: indexPath)
                cell.selectionStyle = .none

                cell.lblMainHeader.text = "FEATURED CATEGORIES"
                cell.lblMainHeader.font = UIFont(name: "HeroNew-Semibold", size: 18)
                cell.lblsubHeader.isHidden = true
                cell.headerLabel.isHidden = true
                cell.lblMainHeader.isHidden = false
                return cell
            case 2:
                let cell = dequeueCell(ofType: Cell2.self, for: indexPath)
                cell.selectionStyle = .none

                if viewmodel.model?.subcategories.count != nil {
                                cell.subcategoriesitem = viewmodel.model!.subcategories
                                cell.initsetupColletionview()
                                cell.onCollectionItemTap = { [weak self] collectionIndexPath, productname in
                                    print(collectionIndexPath)
                                    self?.navigateToProductDetail(productId: collectionIndexPath, productName: productname)
                        }
                }
                return cell
                
        default:
                return UITableViewCell()
            }
        } else if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                let cell = dequeueCell(ofType: Cell9.self, for: indexPath)
                cell.selectionStyle = .none

                    if viewmodel.model?.products.count != nil {
                        cell.productsdetail = viewmodel.model?.products ?? []
                        cell.initSet()
                        cell.scrollToTop()

                    }
                
                cell.onproductItemTap = { [weak self] collectionIndexPath, variantId in
                    print(collectionIndexPath)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
                    secondVC.productId        = collectionIndexPath
                    secondVC.defaultVaniantID = variantId
                    self?.navigationController?.pushViewController(secondVC, animated: true)
                }
                    return cell
            default:
                return UITableViewCell()
            }
       }
        return UITableViewCell()
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 640
            case 1:
                return 80
            case 2:
                guard let subcategories = viewmodel.model?.subcategories else {
                    return 0
                }
                

                    let height = UIScreen.main.bounds.height

                    switch height {
//                    case 568:
//                        return 0//"iPhone SE (1st Gen)"
//                    case 667:
//                        return 0//"iPhone 6/7/8 or SE (2nd/3rd Gen)"
//                    case 736:
//                        return 0//iPhone 6+/7+/8+"
//                    case 812:
//                        return 0//"iPhone X, XS, 11 Pro, or 12/13 Mini"
//                    case 844:
//                        return subcategories.count == 1 ? 190 : CGFloat(70 * subcategories.count)
//                        //return 0//iPhone 12/13/14"
//                    case 852:
//                        return 0//iPhone 14 Pro or iPhone 15"
//                    case 896:
//                        return 0//iPhone XR, 11"
                    case 926:
                        return subcategories.count == 1 ? 190 : CGFloat(70 * subcategories.count)
                        return 0//iPhone 12/13/14 Pro Max"
                    case 932:
                        return subcategories.count == 1 ? 190 : CGFloat(75 * subcategories.count)

                    default:
                        return subcategories.count == 1 ? 190 : CGFloat(75 * subcategories.count)

                    }
                

                
                
            default:
                return UITableView.automaticDimension
            }

        case 1:
            switch indexPath.row {
            case 0:
                guard let products = viewmodel.model?.products else {
                    return 0
                }
                return products.count == 1 ? 400 : CGFloat(240 * products.count)
            default:
                return UITableView.automaticDimension
            }

        default:
            return UITableView.automaticDimension
        }
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == (viewmodel.model?.products.count) ?? 0 - 1 && !isLoading {
//            currentPage += 1
//        }
//    }
    
}

class Cell1 : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    var onproductItemTap: ((String) -> Void)?
    var onproductItemTapSearchBar: ((String) -> Void)?

    var marquee = MarqueeView()
    @IBOutlet weak var viewMarqueContainer: UIView!

    var modelBanner : [Banner?] = []
    @IBOutlet weak var viewMarque: MarqueeLabel!
    @IBOutlet weak var viewPager: UIView!
    @IBOutlet weak var lblMarque: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    let searchBar = UISearchBar()
    
    @IBOutlet weak var pageview: UIPageControl!
    var timer = Timer()
    var counter = 0
    let placeholderLabel = UILabel()
    let dotsContainer = UIStackView()
    var progressView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        marquee.frame = viewMarqueContainer.bounds
        marquee.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        viewMarqueContainer.addSubview(marquee)

        marquee.startMarquee(text: "🔥 Mega Sale Live | 50% OFF | Limited Time Offer | Shop Now!");
        
        searchBarSetup()
        progressbar()
        collectionView1.delegate = self
        collectionView1.dataSource = self

        DispatchQueue.main.async {
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    func setInit() {
        progressbar()
        collectionView1.reloadData()
    }

    func progressbar(){
          dotsContainer.axis = .horizontal
          dotsContainer.alignment = .center
          dotsContainer.distribution = .equalSpacing
          dotsContainer.spacing = 12
          dotsContainer.translatesAutoresizingMaskIntoConstraints = false

          viewPager.addSubview(dotsContainer)

          NSLayoutConstraint.activate([
              dotsContainer.centerXAnchor.constraint(equalTo: viewPager.centerXAnchor),
              dotsContainer.bottomAnchor.constraint(equalTo: viewPager.bottomAnchor, constant: -8),
              dotsContainer.heightAnchor.constraint(equalToConstant: 10)
          ])
           setupDotsWithProgressBar(currentIndex: 0, totalDots: modelBanner.count)

    }
    func setupDotsWithProgressBar(currentIndex: Int, totalDots: Int, selectedSize: CGFloat = 40, unselectedSize: CGFloat = 5) {
           dotsContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
   
           for i in 0..<totalDots {
               if i == currentIndex {
                   // Create outer frame
                   let frame = UIView()
                   frame.backgroundColor = UIColor.white
                   frame.layer.cornerRadius = unselectedSize / 2
                   frame.clipsToBounds = true
                   frame.translatesAutoresizingMaskIntoConstraints = false
                   frame.widthAnchor.constraint(equalToConstant: selectedSize).isActive = true
                   frame.heightAnchor.constraint(equalToConstant: unselectedSize).isActive = true
   
                   // Create inner progress view
                   let progress = UIView()
                   progress.backgroundColor = UIColor.lightGray
                   progress.layer.cornerRadius = unselectedSize / 2
                   progress.translatesAutoresizingMaskIntoConstraints = false
   
                   frame.addSubview(progress)
                   dotsContainer.addArrangedSubview(frame)
   
                   // Set initial width constraint for animation
                   let widthConstraint = progress.widthAnchor.constraint(equalToConstant: 0)
                   NSLayoutConstraint.activate([
                       progress.leadingAnchor.constraint(equalTo: frame.leadingAnchor),
                       progress.topAnchor.constraint(equalTo: frame.topAnchor),
                       progress.bottomAnchor.constraint(equalTo: frame.bottomAnchor),
                       widthConstraint
                   ])
   
                   // Animate progress bar
                   animateProgressBar(widthConstraint: widthConstraint, targetWidth: selectedSize)
               } else {
                   let dot = UIView()
                   dot.backgroundColor = UIColor.white
                   dot.layer.cornerRadius = unselectedSize / 2
                   dot.translatesAutoresizingMaskIntoConstraints = false
                   dot.widthAnchor.constraint(equalToConstant: unselectedSize).isActive = true
                   dot.heightAnchor.constraint(equalToConstant: unselectedSize).isActive = true
                   dotsContainer.addArrangedSubview(dot)
               }
           }
       }
   
       func animateProgressBar(widthConstraint: NSLayoutConstraint, targetWidth: CGFloat) {
            self.layoutIfNeeded()
           widthConstraint.constant = targetWidth
           UIView.animate(withDuration: 3.0) { // 3 seconds, similar to AUTO_SLIDE_TIME
               self.layoutIfNeeded()
           }
       }
   
    @objc func changeImage() {
     
     if counter < modelBanner.count {
         let index = IndexPath.init(item: counter, section: 0)
         let obj = modelBanner[counter]

         self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)

         searchBar.placeholder = ""
         guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
         if let title = obj?.title {
             placeholderLabel.text = "       \(title)"
         }
         placeholderLabel.font = textField.font
         placeholderLabel.textColor = .white
         placeholderLabel.alpha = 0
         placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
         textField.addSubview(placeholderLabel)

         // Animate from bottom to top
         UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
             self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
             self.placeholderLabel.alpha = 1
         }, completion: nil)
         UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
             self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
             self.placeholderLabel.alpha = 1
         }, completion: nil)
         counter += 1

     } else {
         if modelBanner.count != 0 {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)
             self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             counter = 1
         }
     }
  }
    // self.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)
    func searchBarSetup() {
                
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        placeholderLabel.textColor = .white

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setImage(UIImage(systemName: "searchbar.jpg"), for: .search, state: .normal)
        searchBar.tintColor = .white
        contentView.addSubview(searchBar)
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let imageV = textFieldInsideSearchBar?.leftView as! UIImageView
        imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageV.tintColor = UIColor.white
        
        
        guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }

        placeholderLabel.font = textField.font
        placeholderLabel.textColor = .white
        placeholderLabel.alpha = 0
        placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
        textField.addSubview(placeholderLabel)
        
      // Change border color
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor  = UIColor.white
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.borderWidth = 1.5
            textField.layer.cornerRadius = 0
            textField.clipsToBounds = true
            
        }
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView1.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    // Called when editing begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing began")
        onproductItemTapSearchBar!("")
        textField.resignFirstResponder()

    }

    // Called when editing ends
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Editing ended")
        textField.resignFirstResponder()

    }

    // Called when Return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Hides the keyboard
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "collectionViewCell1", for: indexPath) as! collectionViewCell1
        cell.lblShopNow.layer.cornerRadius = 10
        cell.clipsToBounds = true
        let obj = modelBanner[indexPath.row]
        
        if obj?.mobileImage == nil {
            
            cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.webVideo ?? keyName.emptyStr))
        } else {
            
            cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.mobileImage ?? keyName.emptyStr))
        }
        
//        cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.mobileImage ?? keyName.emptyStr))

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Full height
    }
    
    // Called when user starts editing in the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("SearchBar began editing")
        onproductItemTapSearchBar?("")
    }

   
}

class Cell2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var subcategoriesitem: [Subcategory] = []
    var onCollectionItemTap: ((String,String) -> Void)?
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView2.delegate = self
        collectionView2.dataSource = self
        //collectionView2.backgroundColor = .blue
    }
    func initsetupColletionview() {
         collectionView2.reloadData()
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategoriesitem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "collectionViewCell2", for: indexPath) as! collectionViewCell2
        let obj = subcategoriesitem[indexPath.row]
        cell.imgCollectionViewCell2.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgCollectionViewCell2.sd_setImage(with: URL(string: obj.image ?? ""))
        cell.lblCategory.text = obj.name
        cell.lblCategory.font = UIFont(name: "HeroNew-Semibold", size: 18)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width  = (collectionView.frame.width-10)/3
        return CGSize(width: width, height: (width + 60))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = subcategoriesitem[indexPath.row]
        onCollectionItemTap?(obj._id ?? "", obj.name)
    }
}

class Cell9: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var onproductItemTap: ((String,String) -> Void)?
    @IBOutlet weak var collectionView9: UICollectionView!
    var productsdetail: [Product] = []
    var productsdetail1: [product] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        //collectionView9.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)


//        if let layout = collectionView9.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .vertical
//        }
//        
//        collectionView9.alwaysBounceVertical = false
//        collectionView9.alwaysBounceHorizontal = false
//        collectionView9.showsHorizontalScrollIndicator = false
        
        collectionView9.delegate = self
        collectionView9.dataSource = self
        collectionView9.register(UINib(nibName: "ProductDetailCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCell")
        
        collectionView9.isScrollEnabled = true
        collectionView9.delaysContentTouches = false
        collectionView9.canCancelContentTouches = true

    }
    func scrollToTop() {
        if productsdetail.count > 0 {
            //collectionView9.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    override func prepareForReuse() {
            super.prepareForReuse()
        //
        //collectionView9.setContentOffset(.zero, animated: false)
        }
//    func initSet() {
//        if let layout = collectionView9.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .vertical
//        }
//        
//        collectionView9.alwaysBounceVertical = false
//        collectionView9.alwaysBounceHorizontal = false
//        collectionView9.showsHorizontalScrollIndicator = false
//        collectionView9.reloadData()
//    }
    func initSet() {
        if let layout = collectionView9.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.invalidateLayout()
        }

        collectionView9.alwaysBounceVertical = false
        collectionView9.alwaysBounceHorizontal = false
        collectionView9.showsHorizontalScrollIndicator = false
        collectionView9.isScrollEnabled = true // ✅ Enable scrolling here
        collectionView9.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView9.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productsdetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView9.dequeueReusableCell(withReuseIdentifier: "ProductDetailCell", for: indexPath) as! ProductDetailCell

            let objModel = productsdetail[indexPath.row]
            cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProduct.sd_setImage(with: URL(string: objModel.variantThumbnail?.image ?? ""))
            cell.lblProductName.text = objModel.title
            cell.lblProductName.font = UIFont(name: "HeroNew-Regular", size: 15)
        if let price = objModel.lowestSellingPrice{
            cell.lblProductPrice.text = keyName.rupessymbol + " \(price)"
        }
            if let colorcode = objModel.colorPreview?.count {
                if colorcode > 3 {
                    cell.lblCount.isHidden = false
                    if let countlavbel = objModel.totalColorCount {
                        cell.lblCount.text = "+ \((countlavbel - 3))"
                    }
                }
                if colorcode == 1 {
                    let uiColor = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.isHidden = true
                    cell.lbl3.isHidden = true
                    
                } else if colorcode == 2 {
                    let uiColor  = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                    let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? "")
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.backgroundColor = uiColor1
                    cell.lbl3.isHidden = true
                } else {
                    let uiColor  =  LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                    let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? "")
                    let uiColor2 = LMGlobal.shared.colorFromString(objModel.colorPreview?[2] ?? "")
                    
                   
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.backgroundColor = uiColor1
                    cell.lbl3.backgroundColor = uiColor2
                }
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objModel = productsdetail[indexPath.row]
        onproductItemTap?(objModel.id ?? "", objModel.variantThumbnail?.variantId ?? "")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        scrollToTop()
        let spacing: CGFloat = 6
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width * 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}


class collectionViewCell1 : UICollectionViewCell{
    
    @IBOutlet weak var imgCollectionViewCell1: UIImageView!
    
    @IBOutlet weak var lblShopNow: UILabel!
}

class collectionViewCell2 : UICollectionViewCell{
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgCollectionViewCell2: UIImageView!
}

class HeaderCell: UITableViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var lblMainHeader: UILabel!
    @IBOutlet weak var lblsubHeader: UILabel!

}

private extension LMDashboardVC {
    
    func dequeueCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell of type \(T.self)")
        }
        return cell
    }
    func navigateToProductDetail(productId:String, productName:String) {
        let objProduct = self.storyboard?.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetailVC) as! LMProductDetailVC
        objProduct.productId   = productId
        objProduct.productName = productName
        self.navigationController?.pushViewController(objProduct, animated: true)
    }
}




