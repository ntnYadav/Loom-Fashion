//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit
import SwiftUI
import SDWebImage
import SVGKit


class LMDashboardHomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy fileprivate var viewmodel = LMDashboardHomeVM(hostController: self)
    var mobileBrand = [MobileBrand]()

    @IBOutlet weak var mainview: UIView!
    var refreshControl = UIRefreshControl()

        var collectionView: UICollectionView!

        override func viewDidLoad() {
             super.viewDidLoad()
            
            
            if THUserDefaultValue.isUserLoging  == false {
                if THUserDefaultValue.authTokenTemp == nil {
                    let identifier = UUID().uuidString
                    THUserDefaultValue.authTokenTemp = identifier
                }
            } else {
               
            }
             
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("ReloadDashboard"), object: nil)

            mobileBrand.append(MobileBrand.init(brandName: "Apple", modelName: ["iPhone 5s","iPhone 6","iPhoneß 6s"]))
            mobileBrand.append(MobileBrand.init(brandName: "Samsung", modelName: ["Samsung M Series"]))
            
             view.backgroundColor = .white

             let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .vertical
             layout.headerReferenceSize = CGSize(width: view.frame.width, height: 200)
             layout.sectionHeadersPinToVisibleBounds = true // 👈 Make header sticky

             collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
             collectionView.backgroundColor = .white
             collectionView.delegate = self
             collectionView.dataSource = self
             collectionView.contentInsetAdjustmentBehavior = .never
             collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
             collectionView.register(UINib(nibName: "LMcellShopCell", bundle: nil), forCellWithReuseIdentifier: "LMcellShopCell")
             collectionView.register(UINib(nibName: "LMcellShopCell2", bundle: nil), forCellWithReuseIdentifier: "LMcellShopCell2")
             collectionView.register(UINib(nibName: "LMProductCell1", bundle: nil), forCellWithReuseIdentifier: "LMProductCell1")
             collectionView.register(UINib(nibName: "LMPDashboardHeaderCell", bundle: nil), forCellWithReuseIdentifier: "LMPDashboardHeaderCell")
            
           

            //collectionView.register("LMcellShopCell", forCellWithReuseIdentifier: "LMcellShopCell")

             collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    //         //collectionView.register(CustomHeaderView.self,
    //                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
    //                                 withReuseIdentifier: "CustomHeaderView")
    //
            collectionView.register(
                UINib(nibName: "searchBarHeaderCv", bundle: nil),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "searchBarHeaderCv"
            )
            collectionView.register(
                UINib(nibName: "searchBarHeader", bundle: nil),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "searchBarHeader"
            )
            
            let height = UIScreen.main.bounds.height
           // collectionView.translatesAutoresizingMaskIntoConstraints = false
            mainview.addSubview(collectionView)
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: mainview.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: mainview.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: mainview.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: mainview.bottomAnchor, constant: -250) // 👈 Reduce 120 from bottom
            ])

            view.bringSubviewToFront(collectionView)
            collectionView.isUserInteractionEnabled = true
            mainview.isUserInteractionEnabled = true
            //view.addSubview(collectionView)
            
            viewmodel.validateBannerValue()
            viewmodel.validateValue()
            //collectionView.backgroundColor = .green
           // mainview.backgroundColor = .red
            // view.addSubview(collectionView)
         }
    
    @objc func reloadCollectionView() {
        print("Dashboard reload triggered")
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.reloadData()    }
    
    func scrollToTop() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        setupRefreshControl()
        scrollToTop()
    }
    
    func setupRefreshControl() {
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            collectionView.refreshControl = refreshControl
  

        }
    @objc func refreshData() {
            // Simulate fetching data
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
//    override var shouldAutorotate: Bool {
//        return false
//    }


        // MARK: - UICollectionViewDataSource
    // MARK: - UICollectionViewDataSource
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Cell tapped")
    super.touchesBegan(touches, with: event)
}
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return mobileBrand.count

        }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Full height
//    }
    @objc func likeaction(_ sender : UIButton) {
        
       // if THUserDefaultValue.isUserLoging == true {
            let tag = sender.tag
            var objModel = viewmodel.model?.products[tag]
            if objModel?.isWishlisted == false {
                viewmodel.model?.products[tag].isWishlisted = true
            } else {
                viewmodel.model?.products[tag].isWishlisted = false
            }
            
            let indexPath = IndexPath(item: tag, section: 0)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            viewmodel.callWishListAPI(productId: objModel?.id ?? "", strColor: objModel?.variantThumbnail?.color ?? "", strVaiantId:objModel?.variantThumbnail?.variantId ?? "")
//        } else {
//            let halfVC = LoginVC()
//            halfVC.modalPresentationStyle = .overFullScreen
//            self.present(halfVC, animated: true)
//        }
    }
    
  
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    
//            switch section {
//            case 0:
//               // return mobileBrand.count
//
//                if viewmodel.model?.subcategoriesFinal?.count != 0 {
//                    return viewmodel.model?.subcategoriesFinal?.count ?? 0
//                }
//            case 1:
//               // return self?.model?
//
//                if viewmodel.model?.products.count != 0 {
//                    return viewmodel.model?.products.count ?? 0
//                }
//
//            default:
//                return 0
//            }
//        
//        
//        return 0
//    }


//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            
//            if indexPath.section == 0 {
//                if indexPath.row == 0 {
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMProductCell1", for: indexPath) as! LMProductCell1
//                    if viewmodel.modelBanner?.count != nil {
//                        cell.modelBanner = viewmodel.modelBanner ?? []
//                    }
//                    cell.setInit()
//                    
//                    cell.onproductItemTapSearchBar = { [weak self] collectionIndexPath in
//                        self?.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)
//
//                    }
//                    return cell
//                    
//                }
//                if  indexPath.row == 1 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPDashboardHeaderCell", for: indexPath) as! LMPDashboardHeaderCell
//                    let obj = viewmodel.model!.subcategoriesFinal?[indexPath.row]
//                    cell.lblheader.text = obj?.name
//                    cell.lblheader.font = UIFont(name: "HeroNew-bold", size: 20)
//
//                return cell
//                
//                
//             } else  {
//                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell2", for: indexPath) as! LMcellShopCell2
//                 
//                 if viewmodel.model?.subcategoriesFinal?.count != nil {
//                     let obj = viewmodel.model!.subcategoriesFinal?[indexPath.row]
//                     cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
//                     cell.imgProduct.sd_setImage(with: URL(string: obj?.image ?? ""))
//                     cell.lblCategory.text = obj?.name
//                     cell.lblCategory.font = UIFont(name: "HeroNew-Semibold", size: 16)
//               
//                 }
//                 
//                 //                cell.imageView.image = UIImage(systemName: "image") // Replace with your image
//                 //                cell.imageView.backgroundColor = .gray
//                 //                cell.titleLabel.text = "Item \(indexPath.item)"
//                 
//                 return cell
//             }
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell", for: indexPath) as! LMcellShopCell
//                let objModel = viewmodel.model?.products[indexPath.row]
//                cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
//                cell.imgProduct.sd_setImage(with: URL(string: objModel?.variantThumbnail?.image ?? ""))
//                cell.btnLike.addTarget(self, action: #selector(LMDashboardHomeVC.likeaction(_:)), for: .touchUpInside)
//                
//                if objModel?.isWishlisted == false {
//                    cell.imgLike.image = UIImage(named: "heart")
//                } else {
//                    cell.imgLike.image = UIImage(named: "Selectheart")
//
//                }
//                
//                cell.btnLike.tag = indexPath.row
//                cell.lblTitle.text = objModel?.title
//                cell.lblTitle.font = UIFont(name: "HeroNew-Regular", size: 15)
//                if let price = objModel?.lowestSellingPrice{
//                cell.lblPrice.text = keyName.rupessymbol + " \(price)"
//            }
//                if let colorcode = objModel?.colorPreview?.count {
//                    if colorcode > 3 {
//                        cell.lblProductSize.isHidden = false
//                        if let countlavbel = objModel?.totalColorCount {
//                            let colorcount = Int(countlavbel -  3)
//                            cell.lblProductSize.text = "+ \(colorcount)"
//                        }
//                    }
//                    if colorcode == 1 {
//                        let uiColor = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
//                        cell.lbl1.backgroundColor = uiColor
//                        cell.lbl2.isHidden = true
//                        cell.lbl3.isHidden = true
//
//                    } else if colorcode == 2 {
//                        let uiColor  = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
//                        let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
//                        cell.lbl1.backgroundColor = uiColor
//                        cell.lbl2.backgroundColor = uiColor1
//                        cell.lbl3.isHidden = true
//                    } else {
//                        cell.lbl3.isHidden = false
//                        cell.lbl2.isHidden = false
//                        cell.lbl1.isHidden = false
//                       
//
//                        let uiColor  = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
//                        let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
//                        let uiColor2 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[2] ?? "")
//                        cell.lbl1.backgroundColor = uiColor
//                        cell.lbl2.backgroundColor = uiColor1
//                        cell.lbl3.backgroundColor = uiColor2
//                    }
//                }
//                return cell
//                
//            }
//        }
    
    
    //2ad^
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            // return mobileBrand.count
            let count = viewmodel.model?.subcategoriesFinal?.count ?? 0
            let limitedSubcategories = min(count, 9)
            return 2 + limitedSubcategories
            
        case 1:
            // return self?.model?
            return viewmodel.model?.products.count ?? 0
        default:
            return 0
        }
    }
    
    //2ad
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Banner Cell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMProductCell1", for: indexPath) as! LMProductCell1
                cell.modelBanner = viewmodel.modelBanner ?? []
                cell.setInit()
                cell.onproductItemTapSearchBar = { [weak self] _ in
                    self?.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)
                }
                return cell
            } else if indexPath.row == 1 {
                // Header Cell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPDashboardHeaderCell", for: indexPath) as! LMPDashboardHeaderCell
                cell.lblheader.text = "FEATURED CATEGORIES"
                cell.lblheader.font = UIFont(name: "HeroNew-Bold", size: 20)
                return cell
            } else {
                let subcategoryIndex = indexPath.row
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell2", for: indexPath) as! LMcellShopCell2

                if let subcategories = viewmodel.model?.subcategoriesFinal,
                   subcategoryIndex >= 0,
                   subcategoryIndex < subcategories.count {
                    
                    let obj = subcategories[subcategoryIndex]
                    cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imgProduct.sd_setImage(with: URL(string: obj.image ?? ""))
                    cell.lblCategory.text = obj.name
                    cell.lblCategory.font = UIFont(name: "HeroNew-Semibold", size: 16)
                }

                return cell
            }
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell", for: indexPath) as! LMcellShopCell
        let objModel = viewmodel.model?.products[indexPath.row]

        cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgProduct.sd_setImage(with: URL(string: objModel?.variantThumbnail?.image ?? ""))
        cell.btnLike.addTarget(self, action: #selector(LMDashboardHomeVC.likeaction(_:)), for: .touchUpInside)
        
//        let svgImage:SVGKImage = SVGKImage(named: "ic_heart_empty")
//        cell.imgLike.image = svgImage.uiImage
        if objModel?.isWishlisted == true {
            cell.imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage

        } else {
            cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
        }

        //cell.imgLike.image = UIImage(named: objModel?.isWishlisted == true ? "Selectheart" : "heart")
        cell.btnLike.tag = indexPath.row
        
        
        
        let mrp = (objModel?.lowestMRP)!
        let sellingPrice = (objModel?.lowestSellingPrice!)!
        
        if mrp == sellingPrice {
            let attributedPriceText = createPriceAttributedTextWithout(
                discountPercent: 0,
                originalPrice: 0,
                discountedPrice: sellingPrice
            )
            cell.lblPrice.attributedText = attributedPriceText
        } else {
            let attributedPriceText = createPriceAttributedText(
                discountPercent: 0,
                originalPrice: mrp,
                discountedPrice: sellingPrice
            )
            cell.lblPrice.attributedText = attributedPriceText
        }
       
        
        
        if objModel?.discountType == "flat" {
            
            let discount = Int(objModel?.lowestMRP ?? 0) - Int(objModel?.lowestSellingPrice ?? 0)
            if discount != 0 {
                cell.lblDiscountPrice.text = "  ₹\(discount) OFF!"
//                cell.lblDiscountPrice.textColor = .white
                cell.imgBackground.image = UIImage(named: "red")
            } else {
               cell.lblDiscountPrice.isHidden = true
               cell.imgBackground.isHidden = true
            }

        } else {
            cell.imgBackground.image = UIImage(named: "green")

            if let finalDiscountPercent1 = objModel?.finalDiscountPercent {
                if finalDiscountPercent1 != 0 {
                    let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                    cell.lblDiscountPrice.text = "  ₹\(formatted) % OFF!"
//                    cell.lblDiscountPrice.textColor = .white

                } else {
                   cell.lblDiscountPrice.isHidden = true
                   cell.imgBackground.isHidden = true
                }
            }
            
           
            
        }
        cell.lblTitle.text = objModel?.title
        cell.lblTitle.font = UIFont(name: "HeroNew-Regular", size: 15)

//        if let price = objModel?.lowestSellingPrice {
//            cell.lblPrice.text = keyName.rupessymbol + " \(price)"
//        }

        // Color preview
        if let colors = objModel?.colorPreview {
            cell.lbl1.isHidden = colors.count < 1
            cell.lbl2.isHidden = colors.count < 2
            cell.lbl3.isHidden = colors.count < 3

            if colors.count > 0 {
                 
                cell.lbl1.backgroundColor = LMGlobal.shared.colorFromString(colors[0])
                
            }
            if colors.count > 1 { cell.lbl2.backgroundColor = LMGlobal.shared.colorFromString(colors[1]) }
            if colors.count > 2 { cell.lbl3.backgroundColor = LMGlobal.shared.colorFromString(colors[2]) }

            if let total = objModel?.totalColorCount, total > 3 {
                cell.lblProductSize.isHidden = false
                cell.lblProductSize.text = "+ \(Int(total) - 3)"
            } else {
                cell.lblProductSize.text = ""
                cell.lblProductSize.isHidden = true
            }
        }

        return cell
    }//
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            
            if indexPath.section == 0 && (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10) {

                if viewmodel.model?.subcategoriesFinal?.count != 0 {
                    let obj = viewmodel.model?.subcategoriesFinal?[indexPath.row]
                    let objProduct = self.storyboard?.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetailVC) as! LMProductDetailVC
                    if indexPath.row == 2 || indexPath.row == 3 {
                        objProduct.apiCalling = true
                        if indexPath.row == 0 {
                            objProduct.productId   = obj?._id ?? ""
                            objProduct.productName =  obj?.name ?? ""
                            objProduct.tagProduct =  "new"

                            
                        } else {
                            objProduct.productId   = obj?._id ?? ""
                            objProduct.productName =  obj?.name ?? ""
                            objProduct.tagProduct =  "hot-selling"

                        }
                        
                    } else {
                        objProduct.apiCalling = false
                        objProduct.tagProduct =  ""

                        objProduct.productId   = obj?._id ?? ""
                        objProduct.productName = obj?.name ?? ""
                    }
                    self.navigationController?.pushViewController(objProduct, animated: true)
                }

                
            }
        } else if indexPath.section == 1 {
            if viewmodel.model?.products.count != 0 {
                let obj = viewmodel.model?.products[indexPath.row]
                //onproductItemTap?(objModel.id ?? "", objModel.variantThumbnail?.variantId ?? "")

                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
                secondVC.productId        = obj?.id ?? ""
                secondVC.defaultVaniantID = obj?.variantThumbnail?.variantId ?? ""
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }
        
       
       
    }
        // MARK: - Header View

        func collectionView(_ collectionView: UICollectionView,
                            viewForSupplementaryElementOfKind kind: String,
                            at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                if indexPath.section == 0 {
                    let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: "searchBarHeaderCv",
                        for: indexPath
                    ) as! searchBarHeaderCv
                    
                    header.initset()
                 
                    //header.backgroundColor = .green
                    //header.label.text = "Section Header"
                    return header
                } else {
                    let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: "searchBarHeader",
                        for: indexPath
                    ) as! searchBarHeader
                    if viewmodel.model?.subcategories.count != nil {
                        header.subcategoriesitem.removeAll()
                        header.subcategoriesitem = viewmodel.model!.subcategories1 ?? []
                       // headerView.subcategoriesitem.append(Subcategory.init(_id: "0", name: "All", image: "", sequence: 0))
                        header.initset()
                        header.onCollectionItemTag = { [weak self] productname in

                            self?.viewmodel.getProductListing(productID: productname, tagValue: productname, page: "1", limit: "70", subcategoryId: productname)
                                     }
                                 }
                    //header.backgroundColor = .green
                    //header.label.text = "Section Header"
                    return header
                }
            }
            return UICollectionReusableView()
        }

        // MARK: - Layout

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
           if indexPath.section == 0 {
               if indexPath.row == 0 {
                   return CGSize(width: (view.frame.width), height: 640)
               }
               if indexPath.row == 1 {
                   return CGSize(width: (view.frame.width), height: 80)
               }
               let totalWidth = collectionView.bounds.width
               let itemWidth = floor((totalWidth - 10) / 3)
               return CGSize(width: itemWidth, height: itemWidth + 60)

            } else {
                return CGSize(width: (view.frame.width)/2, height: 400)
            }
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            referenceSizeForHeaderInSection section: Int) -> CGSize {
            if section == 0 {
                return CGSize(width: collectionView.bounds.width, height: 0) // Adjust height as needed
            } else {
                return CGSize(width: collectionView.bounds.width, height: 150) // Adjust height as needed
            }
        }
        
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 0, left: -1, bottom: 0, right: -1)
//        }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    
    func createPriceAttributedTextWithout(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
//        let discountString = "↓ \(discountPercent)% "
//        let discountAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.systemGreen,
//            .font: UIFont(name: ConstantFontSize.regular, size: 13)
//        ]
//        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
//        let originalPriceString = "₹\(Int(originalPrice))"
//        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
//            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
//            .foregroundColor: UIColor.gray,
//            .font: UIFont(name: ConstantFontSize.regular, size: 14)
//        ]
//        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = " ₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.Semibold, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }
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
        let originalPriceString = "₹\(Int(originalPrice))"
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = " ₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.Semibold, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }

    }

   
