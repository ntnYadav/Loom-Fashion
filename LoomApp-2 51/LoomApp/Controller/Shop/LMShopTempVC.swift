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

class LMShopTempVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var viewMain: UIView!
    lazy fileprivate var viewmodel = LMShopTempMV(hostController: self)

        var collectionView: UICollectionView!

    override func viewDidLoad() {
             super.viewDidLoad()
          
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

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        viewMain.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: viewMain.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: (height - 80)) // 👈 Fixed height
        ])

        view.bringSubviewToFront(collectionView)
//        collectionView.backgroundColor = .green
//        viewMain.backgroundColor = .red

        collectionView.isUserInteractionEnabled = true
        viewMain.isUserInteractionEnabled = true
            
         //   viewMain.addSubview(collectionView)
            viewmodel.getCategoryApi()

         }
    @objc func likeaction(_ sender : UIButton) {
      let tag = sender.tag
        var objModel = viewmodel.model?.products[tag]
        
        if objModel?.isWishlisted == nil {
            viewmodel.model?.products[tag].isWishlisted = true
        } else {
        if objModel?.isWishlisted == false {
            viewmodel.model?.products[tag].isWishlisted = true
        } else {
            viewmodel.model?.products[tag].isWishlisted = false
        }
    }
        
        let indexPath = IndexPath(item: tag, section: 0)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

        viewmodel.callWishListAPI(productId: objModel?.id ?? "", strColor: objModel?.variantThumbnail?.color ?? "", strVaiantId:objModel?.variantThumbnail?.variantId ?? "")
    }
        // MARK: - UICollectionViewDataSource
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Cell tapped")
        super.touchesBegan(touches, with: event)
    }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
                switch section {
                case 0:
                    if viewmodel.model?.subcategories.count != 0 {
                        return viewmodel.model?.subcategories.count ?? 0
                    }
                case 1:
                    if viewmodel.model?.products.count != 0 {
                        return viewmodel.model?.products.count ?? 0
                    }

                default:
                    return 0
                }
            
            
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
//                cell.imageView.image = UIImage(systemName: "image") // Replace with your image
//                cell.imageView.backgroundColor = .gray
//                cell.titleLabel.text = "Item \(indexPath.item)"
                
                let obj = viewmodel.model!.subcategories[indexPath.row]
                cell.imageView.sd_setImage(with: URL(string: obj.image ?? ""))
                cell.titleLabel.text = obj.name
                cell.titleLabel.font = UIFont(name: "HeroNew-Semibold", size: 18)
                
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell", for: indexPath) as! LMcellShopCell
                
                
                let objModel = viewmodel.model?.products[indexPath.row]
                cell.imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.imgProduct.sd_setImage(with: URL(string: objModel?.variantThumbnail?.image ?? ""))
                cell.lblTitle.text = objModel?.title
                cell.lblTitle.font = UIFont(name: "HeroNew-Regular", size: 15)
                
//                let mrp = (objModel?.lowestMRP)!
//                let sellingPrice = (objModel?.lowestSellingPrice!)!
//                let attributedPriceText = LMGlobal.shared.createPriceAttributedText(
//                    discountPercent: 0,
//                    originalPrice: mrp,
//                    discountedPrice: sellingPrice
//                )
//                cell.lblPrice.attributedText = attributedPriceText
//                
//                
                
                
                let mrp = (objModel?.lowestMRP)!
                let sellingPrice = (objModel?.lowestSellingPrice!)!
                
                if mrp == sellingPrice {
                
                    let attributedPriceText = LMGlobal.shared.createPriceAttributedTextWithout(
                                       discountPercent: 0,
                                       originalPrice: 0,
                                       discountedPrice: sellingPrice
                                   )
                    cell.lblPrice.attributedText = attributedPriceText
                } else {
                    let attributedPriceText = LMGlobal.shared.createPriceAttributedText(
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
                        //cell.lblDiscountPrice.textColor = .white

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
                            //cell.lblDiscountPrice.textColor = .white

                        } else {
                           cell.lblDiscountPrice.isHidden = true
                           cell.imgBackground.isHidden = true
                        }
                    }
                }
                

                cell.btnLike.addTarget(self, action: #selector(LMShopTempVC.likeaction(_:)), for: .touchUpInside)
                cell.btnLike.tag = indexPath.row
                if objModel?.isWishlisted == nil {
                    
                    cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
             
                } else {
                if objModel?.isWishlisted == false {
//                    cell.imgLike.image = UIImage(named: "heart")
                    cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
                } else {
                    cell.imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
                }
               }
                if let colorcode = objModel?.colorPreview?.count {
                    if colorcode > 3 {
                        cell.lblProductSize.isHidden = false
                        if let countlavbel = objModel?.totalColorCount {
                            cell.lblProductSize.text = "+ \((countlavbel - 3))"
                        }
                    }
                    if colorcode == 1 {
                        let uiColor = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                        if let lowercaseString = objModel?.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl1.layer.borderColor = UIColor.black.cgColor
                                cell.lbl1.layer.borderWidth = 1
                            }
                        }
                        cell.lbl1.backgroundColor = uiColor
                        cell.lbl2.isHidden = true
                        cell.lbl3.isHidden = true

                    } else if colorcode == 2 {
                        let uiColor  = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                        let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
                        
                        if let lowercaseString = objModel?.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl1.layer.borderColor = UIColor.black.cgColor
                                cell.lbl1.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel?.colorPreview?[1].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl2.layer.borderColor = UIColor.black.cgColor
                                cell.lbl2.layer.borderWidth = 1
                            }
                        }
                        
                        cell.lbl1.backgroundColor = uiColor
                        cell.lbl2.backgroundColor = uiColor1
                        cell.lbl3.isHidden = true
                    } else {
                        let uiColor  =  LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                        let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
                        let uiColor2 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[2] ?? "")
                        
                        
                        if let lowercaseString = objModel?.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl1.layer.borderColor = UIColor.black.cgColor
                                cell.lbl1.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel?.colorPreview?[1].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl2.layer.borderColor = UIColor.black.cgColor
                                cell.lbl2.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel?.colorPreview?[2].lowercased() {
                            if lowercaseString == "white" {
                                cell.lbl3.layer.borderColor = UIColor.black.cgColor
                                cell.lbl3.layer.borderWidth = 1
                            }
                        }
                        
                        cell.lbl1.backgroundColor = uiColor
                        cell.lbl2.backgroundColor = uiColor1
                        cell.lbl3.backgroundColor = uiColor2
                    }
                }
                
//                cell.imageView.image = UIImage(systemName: "image") // Replace with your image
//                cell.imageView.backgroundColor = .gray
//                cell.titleLabel.text = "Item \(indexPath.item)"
                return cell
                
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
                    
                    
                    header.onproductItemTapSearchBar = { [weak self] collectionIndexPath in
                        self?.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)

                    }
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
                    
                    if viewmodel.model?.subcategories1?.count != nil {
                        header.subcategoriesitem.removeAll()
                        print("viewmodel.model!.subcategories1 ??==\(viewmodel.model!.subcategories1)")
                        header.subcategoriesitem = viewmodel.model!.subcategories1!
                        
                        print("header.subcategoriesitem ??==\(header.subcategoriesitem)")
                        
                       // headerView.subcategoriesitem.append(Subcategory.init(_id: "0", name: "All", image: "", sequence: 0))
                        header.initset()
                        header.onCollectionItemTag = { [weak self] productname in

                            self?.viewmodel.getProductListing(productID: productname, tagValue: productname, page: "1", limit: "50", subcategoryId: productname)
                                     }
                                 }

                    
                    //header.backgroundColor = .green
                    //header.label.text = "Section Header"
                    return header
                }
            }
            return UICollectionReusableView()
        }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView {
            
            if indexPath.section == 0 {
                print("indexPath.section=\(indexPath.row)")
                // self.NavigationController(navigateFrom: self, navigateTo: LMProductDetVC(), navigateToString: VcIdentifier.LMProductDetVC)
                let objProduct = self.storyboard?.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetailVC) as! LMProductDetailVC
                let objModel = viewmodel.model?.subcategories[indexPath.row]
                objProduct.productId   = objModel?._id ?? ""
                objProduct.productName = objModel?.name ?? ""
                self.navigationController?.pushViewController(objProduct, animated: true)
                
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
                let objModel = viewmodel.model?.products[indexPath.row]
                secondVC.productId = objModel?.id ?? keyName.emptyStr
                secondVC.defaultVaniantID = objModel?.variantThumbnail?.variantId ?? ""
                navigationController?.pushViewController(secondVC, animated: true)
            }
//            let secondVC = LMPRoductDetailFinalVC()
//
//            navigationController?.pushViewController(secondVC, animated: true)
//
//            let secondVC = LMProductDetVC()
//            let objModel = viewmodel.model?.products?[indexPath.row]
//
//            secondVC.productId = objModel?.id ?? keyName.emptyStr
//            navigationController?.pushViewController(secondVC, animated: true)
          
            
//            let swiftUIView = SecondSwiftUIView(goToFinalDestination: { [self] in
//
//                self.navigateToFinalDestination()
//                          })
//            let hostingController = UIHostingController(rootView: swiftUIView)
//                  //        self.present(hostingController, animated: true, completion: nil)
//            self.navigationController?.pushViewController(hostingController, animated: true)
                          print("Tapped")
                ///
//            let swiftUIView = SecondSwiftUIView(goToFinalDestination: { [self] in
//                self.navigateToFinalDestination()
//            })
//            let hostingController = UIHostingController(rootView: swiftUIView)
//            self.navigationController?.pushViewController(hostingController, animated: true)
//
        } else {
//            selectedIndexPathPopular = nil
//            selectedIndexPathPopular    = indexPath
//            print("selectedIndexPathPopular    = indexPath ===  -- \(indexPath)")
//            collectionview.reloadData()
//            let objtag = arrCotegory[indexPath.row]
//            viewmodel.getProductListing(productID: productId, tagValue: objtag)

        }
    }
    
        // MARK: - Layout

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            if indexPath.section == 0 {
                return CGSize(width: (view.frame.width - 30), height: 100)
            } else {
                return CGSize(width: (view.frame.width - 30)/2, height: 400)
            }
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            referenceSizeForHeaderInSection section: Int) -> CGSize {
            if section == 0 {
                return CGSize(width: collectionView.bounds.width, height: 120) // Adjust height as needed
            } else {
                return CGSize(width: collectionView.bounds.width, height: 150) // Adjust height as needed
            }
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    }

    class HeaderView: UICollectionReusableView {
        let label: UILabel = {
            let lbl = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.font = .boldSystemFont(ofSize: 18)
            lbl.textColor = .black
            return lbl
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .lightGray
            addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    import UIKit

    class CustomCell: UICollectionViewCell {

        static let identifier = "CustomCell"

        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()

        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)

            contentView.addSubview(imageView)
            contentView.addSubview(titleLabel)

            NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 100),
                    imageView.heightAnchor.constraint(equalToConstant: 100),
            

                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

            contentView.layer.cornerRadius = 0
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.layer.borderWidth = 0
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
