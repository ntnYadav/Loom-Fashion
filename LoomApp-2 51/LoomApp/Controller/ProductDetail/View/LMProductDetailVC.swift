//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit
import SwiftUI
import SVGKit


class LMProductDetailVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    
    @IBOutlet weak var emptyView: UIView!
    var currentPage = 1
    let pageSize = 20
    var isLoading = false
    var hasMoreData = true
    
    
    @IBOutlet weak var lblHeader: UILabel!
    var productId:String = ""
    var productName:String = ""
    var tagProduct:String = ""

    var apiCalling:Bool = false

    lazy fileprivate var viewmodel = LMProductVM(hostController: self)

    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    @IBOutlet weak var imgbtn9: UIImageView!
    @IBOutlet weak var imgbtn3: UIImageView!
    @IBOutlet weak var imgbtn2: UIImageView!
    @IBOutlet weak var imgbtn4: UIImageView!

    @IBOutlet weak var btnFilter: UIButton!
    
    
    @IBOutlet weak var cvCollection: UICollectionView!
    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var viewFilter: UIView!
    let maxHeaderHeight: CGFloat = 90
    let minHeaderHeight: CGFloat = 0

    /// The last known scroll position
    var previousScrollOffset: CGFloat = 0

    /// The last known height of the scroll view content
    var previousScrollViewHeight: CGFloat = 0
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!

    var selectedIndexPathPopular: IndexPath? = nil

    
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewtableanimation: UIView!
    var selectedIndexPathProduct: IndexPath? = nil
    var strClickAct = 0

    
        var arrcount: Int = 0
        let arrCotegory = ["All", "New", "Popular", "Hot-selling", "Shirts"]
        var selectedCell = [IndexPath]()

       override func viewDidLoad() {
            super.awakeFromNib()
           

           imgbtn9.isHidden = true// = SVGKImage(named: "img9")?.uiImage
           imgbtn2.isHidden = true//= SVGKImage(named: "img2")?.uiImage
           imgbtn3.isHidden = true// = SVGKImage(named: "img3")?.uiImage
           imgbtn4.isHidden = true// = SVGKImage(named: "img4")?.uiImage

           

           emptyView.isHidden = true
           self.lblHeader.text = productName
           viewFilter.addBottomBorderWithShadow()
           
           btn9.backgroundColor = .white
//           btn9.showsTouchWhenHighlighted = false
//           btn9.adjustsImageWhenHighlighted = false
//           
//           btn4.adjustsImageWhenHighlighted = false
//           btn3.adjustsImageWhenHighlighted = false
//           btn4.adjustsImageWhenHighlighted = false


        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if apiCalling == true {
//            viewmodel.getProductdetail(productID: productId, strQuery: tagProduct, limit: "10", page: 1,minPrice: 0,maxPrice: 5000)
//        } else {
        viewmodel.getProductCategory(productID: productId, strQuery: "", limit: "10", page: 1,minPrice: 0,maxPrice: 5000, sorting:"" )
       // }
        
        strClickAct = 1
        btn4.setImage(UIImage(named: "filter1"), for: .normal)
        //filter1icon.svgx
        
//        if let svgImage = SVGKImage(named: "yourImageName.svg") {
//            let img = UIImageview(image:svgImage)
////            let imageView = UIImageView(svgkImage: svgImage)
//            img.frame = CGRect(x: 0, y: 0, width: 200, height: 200)  // Set your desired frame
//            self.view.addSubview(img)
//        } else {
//            print("Unable to load SVG image")
//        }
        
        self.navigationController?.isNavigationBarHidden = true

        collectionview.dataSource = self
        collectionview.delegate = self
        
        cvCollection.dataSource = self
        cvCollection.delegate = self
        
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 5
               self.cvCollection.collectionViewLayout = layout
        
        collectionview.register(UINib(nibName: "LMcellcolor", bundle: nil), forCellWithReuseIdentifier: "LMcellcolor")
        cvCollection.register(UINib(nibName: "LMbagcollectioncell", bundle: nil), forCellWithReuseIdentifier: "LMbagcollectioncell")

        
        self.headerHeightConstraint.constant = self.maxHeaderHeight
      //  self.topConstraint.constant = self.maxHeaderHeight

        self.updateHeader()
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
       // setupMultipleButtons()
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                print("Swiped Up")

            case .right:
                self.navigationController?.popViewController(animated: true)
            case .up:
                print("Swiped Up")
            case .down:
                print("Swiped Down")
            default:
                break
            }
        }
    // Convert color string to UIColor
    func colorFromString(_ value: String) -> UIColor {
        let lower = value.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch lower {
        case "Black": return .black
        case "black": return .black
        case "White": return .white
        case "white": return .white
        case "Blue": return .blue
        case "blue": return .blue
        case "red": return .red
        case "green": return .green
        case "yellow": return .yellow
        case "gray", "grey": return .gray
        case "purple": return .purple
        case "orange": return .orange
        case "brown": return .brown
        case "clear": return .clear
        default:
            return colorFromHexString(lower) ?? .lightGray
        }
    }

    // Convert hex string to UIColor
    func colorFromHexString(_ hex: String) -> UIColor? {
        var hex = hex.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "")
        guard hex.count == 6 || hex.count == 8 else { return nil }
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        if hex.count == 6 {
            return UIColor(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        } else {
            return UIColor(
                red: CGFloat((rgb & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(rgb & 0x000000FF) / 255.0
            )
        }
    }

    // Convert UIColor to Hex String
    func hexStringFromColor(_ color: UIColor) -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)

        return String(format: "#%02X%02X%02X", r, g, b)
    }

    // MARK: - UICollectionView
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == cvCollection {
                return  viewmodel.allProducts.count

            } else {
                return arrCotegory.count

            }
        }
    @objc func likeaction(_ sender : UIButton) {
   // if THUserDefaultValue.isUserLoging == true {
      let tag = sender.tag
        let objModel = viewmodel.allProducts[tag]
        if objModel.isWishlisted == nil {
               viewmodel.allProducts[tag].isWishlisted = true
        } else {
            if objModel.isWishlisted == false {
                viewmodel.allProducts[tag].isWishlisted = true
        } else {
                viewmodel.allProducts[tag].isWishlisted = false
        }
    }
        DispatchQueue.main.async {
            self.cvCollection.reloadData()
        }
        viewmodel.callWishListAPI(productId: objModel.id ?? "", strColor: objModel.variantThumbnail?.color ?? "", strVaiantId:objModel.variantThumbnail?.variantId ?? "")
//        } else {
//               let halfVC = LoginVC()
//               halfVC.modalPresentationStyle = .overFullScreen
//               self.present(halfVC, animated: true)
//           
//        }
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == cvCollection {
                
                let cell = cvCollection.dequeueReusableCell(withReuseIdentifier: "LMProductCellInner", for: indexPath) as! LMProductCellInner
                let objModel = viewmodel.allProducts[indexPath.row]
                //   print("objModel--\(objModel)")
                // print("(objModel?.images1?[0] as AnyObject).url --\((objModel?.images1?[0] as AnyObject).url)")
                cell.btnFavorite.addTarget(self, action: #selector(LMProductDetailVC.likeaction(_:)), for: .touchUpInside)
                cell.btnFavorite.tag = indexPath.row
                cell.imgLike.isHidden = false

                if objModel.isWishlisted == nil {
                    cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
                } else {
                    if objModel.isWishlisted == false {
                        cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
                } else {
                    cell.imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
                }
            }
                
  
            
                if let url = (objModel.variantThumbnail?.image){
                    cell.imgProduct.sd_setImage(with: URL(string: url))
                     }
                cell.lblProductName.text  = objModel.title
                if let price = objModel.lowestSellingPrice {
                   // cell.lblProductPrice.text = keyName.rupessymbol + " \(price)"
                    }
                
                
//                let mrp = (objModel.lowestMRP)!
//                let sellingPrice = (objModel.lowestSellingPrice!)
//                let attributedPriceText = LMGlobal.shared.createPriceAttributedText(
//                    discountPercent: 0,
//                    originalPrice: mrp,
//                    discountedPrice: sellingPrice
//                )
//                cell.lblProductPrice.attributedText = attributedPriceText
                
                
                let mrp = (objModel.lowestMRP)!
                let sellingPrice = (objModel.lowestSellingPrice!)
                
                if mrp == sellingPrice {
                
                    let attributedPriceText = LMGlobal.shared.createPriceAttributedTextWithout(
                                       discountPercent: 0,
                                       originalPrice: 0,
                                       discountedPrice: sellingPrice
                                   )
                    cell.lblProductPrice.attributedText = attributedPriceText
                } else {
                    let attributedPriceText = LMGlobal.shared.createPriceAttributedText(
                        discountPercent: 0,
                        originalPrice: mrp,
                        discountedPrice: sellingPrice
                    )
                    cell.lblProductPrice.attributedText = attributedPriceText
                    
                }
               
                
                
                
                
                
                if objModel.discountType == "flat" {
                    let discount = Int(objModel.lowestMRP ?? 0) - Int(objModel.lowestSellingPrice ?? 0)
//                        cell.lbldiscountPrice.text = "  ₹\(discount) OFF!"
//                    cell.imgBackground.image = UIImage(named: "red")
                    if discount != 0 {
                        cell.lbldiscountPrice.text = "  ₹\(discount) OFF!"
                        //cell.lbldiscountPrice.textColor = .white

                        cell.imgBackground.image = UIImage(named: "red")
                    } else {
                       cell.lbldiscountPrice.isHidden = true
                       cell.imgBackground.isHidden = true
                    }
                } else {
                    cell.imgBackground.image = UIImage(named: "green")
                    if let finalDiscountPercent1 = objModel.finalDiscountPercent {
                        
                        let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                        if finalDiscountPercent1 != 0 {
                            let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                          //  cell.lbldiscountPrice.textColor = .white

                            cell.lbldiscountPrice.text = "  ₹\(formatted) % OFF!"
                        } else {
                           cell.lbldiscountPrice.isHidden = true
                           cell.imgBackground.isHidden = true
                        }
                    }
                }
                
                
                
                
               
                
                
                
                
                if let colorcode = objModel.colorPreview?.count {
                    if 3 < colorcode {
                        cell.lblColorsize.isHidden = false
                        if let countlavbel = objModel.totalColorCount {
                            let finalvalue = "+ \((countlavbel - 3))"
                                let formatted = String(format: "%.0f", finalvalue)
                                    cell.lblColorsize.text = finalvalue
                        }
                    }

                    if colorcode == 1 {
                        let uiColor = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? keyName.emptyStr)
                        
                        if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblFirstColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblFirstColor.layer.borderWidth = 1
                            }
                        }

                        cell.lblFirstColor.backgroundColor = uiColor
                        cell.lblThirdColor.isHidden = true
                        cell.lblSecondColor.isHidden = true

                    } else if colorcode == 2 {
                        if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblFirstColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblFirstColor.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel.colorPreview?[1].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblSecondColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblSecondColor.layer.borderWidth = 1
                            }
                        }
                        let uiColor  = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? keyName.emptyStr)
                        let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? keyName.emptyStr)
                        cell.lblFirstColor.backgroundColor = uiColor
                        cell.lblSecondColor.backgroundColor = uiColor1
                        cell.lblThirdColor.isHidden = true
                    } else {
                        let uiColor  = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? keyName.emptyStr)
                        let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? keyName.emptyStr)
                        let uiColor2 = LMGlobal.shared.colorFromString(objModel.colorPreview?[2] ?? keyName.emptyStr)
                        
                        if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblFirstColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblFirstColor.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel.colorPreview?[1].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblSecondColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblSecondColor.layer.borderWidth = 1
                            }
                        }
                        if let lowercaseString = objModel.colorPreview?[2].lowercased() {
                            if lowercaseString == "white" {
                                cell.lblThirdColor.layer.borderColor = UIColor.black.cgColor
                                cell.lblThirdColor.layer.borderWidth = 1
                            }
                        }
                        cell.lblFirstColor.backgroundColor = uiColor
                        cell.lblSecondColor.backgroundColor = uiColor1
                        cell.lblThirdColor.backgroundColor = uiColor2

                    }
                    print(colorcode)
                }
                
                    cell.viewColor.isHidden    = false
                    cell.topconsview.constant  = 20
                    cell.btnFavorite.isHidden  = false

                    if strClickAct == 2 {
                        cell.imgLike.isHidden = true
                        cell.viewDiscount.isHidden = true
                        cell.btnFavorite.isHidden           = true
                        cell.topconsview.constant           = 0
                        cell.bottomConstraint.constant      = 0
                        cell.topconstraint.constant         = 0
                        cell.topImgconstraint.constant      = 0
                        //cell.bottomConstraintFinal.constant = 0
                        cell.viewcolourConstraint.constant  = 5
                        cell.lblColorsize.text    = ""
                        cell.lblProductName.text  = ""
                        cell.lblProductPrice.text = ""
                        cell.viewColor.isHidden = true
                    }
                    return cell
                
            
            } else {
                let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "LMcellcolor", for: indexPath) as! LMcellcolor
                cell.viewCell.layer.borderColor = UIColor.lightGray.cgColor
                cell.viewCell.layer.borderWidth = 0.5
                cell.lblSize.text = "  " + arrCotegory[indexPath.row] + "  "
                if selectedIndexPathPopular == indexPath {
                    selectedIndexPathPopular = nil
                    cell.viewCell?.backgroundColor = .black
                    cell.lblSize?.textColor = .white
                } else {
                    cell.viewCell?.backgroundColor = .white
                    cell.lblSize?.textColor = .black
                }
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cvCollection {
           // self.NavigationController(navigateFrom: self, navigateTo: LMProductDetVC(), navigateToString: VcIdentifier.LMProductDetVC)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
            let objModel = viewmodel.allProducts[indexPath.row]
            secondVC.productId = objModel.id ?? keyName.emptyStr
            secondVC.defaultVaniantID = objModel.variantThumbnail?.variantId ?? ""
            navigationController?.pushViewController(secondVC, animated: true)
            
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
            selectedIndexPathPopular = nil
            selectedIndexPathPopular    = indexPath
            print("selectedIndexPathPopular    = indexPath ===  -- \(indexPath)")
            collectionview.reloadData()
            let objtag = arrCotegory[indexPath.row]
            viewmodel.getProductListing(productID: productId, tagValue: objtag)

        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewmodel.loadNextPageIfNeeded(currentIndex: indexPath.item)
    }
    
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
//    @objc func reloaddata1(_ sender : UIButton) {
//        strClickAct = 1
//        self.productCollectionViewDetail.reloadData()
//    }
//    @objc func reloaddata2(_ sender : UIButton) {
//        strClickAct = 2
//        self.productCollectionViewDetail.reloadData()
//    }
//    @objc func reloaddata3(_ sender : UIButton) {
//        arrcount = 0
//        strClickAct = 3
//        self.productCollectionViewDetail.reloadData()
//    }
//    @objc func reloaddata4(_ sender : UIButton) {
//        strClickAct = 4
//        self.productCollectionViewDetail.reloadData()
//    }
    
  
    func navigateToFinalDestination() {
        var goToFinalDestination: () -> Void
      }
    
    func reinital() {
//        imgbtn9.image = SVGKImage(named: "selectimg9")?.uiImage
//        imgbtn2.image = SVGKImage(named: "selectimg2")?.uiImage
//        imgbtn3.image = SVGKImage(named: "selectimg3")?.uiImage
//        //imgbtn4.image = SVGKImage(named: "img4")?.uiImage
        
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
    }
    func reinitalsecond() {
//        imgbtn9.image = SVGKImage(named: "selectimg9")?.uiImage
//        //imgbtn2.image = SVGKImage(named: "selectimg2")?.uiImage
//        imgbtn3.image = SVGKImage(named: "selectimg3")?.uiImage
//        imgbtn4.image = SVGKImage(named: "selectimg4")?.uiImage
        
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
    func reinitalThird() {
//        imgbtn9.image = SVGKImage(named: "selectimg9")?.uiImage
//        imgbtn2.image = SVGKImage(named: "selectimg2")?.uiImage
//        imgbtn4.image = SVGKImage(named: "selectimg4")?.uiImage
//        
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
    func reinitalFour() {
//        imgbtn9.image = SVGKImage(named: "selectimg9")?.uiImage
//        imgbtn3.image = SVGKImage(named: "selectimg3")?.uiImage
//        imgbtn4.image = SVGKImage(named: "selectimg4")?.uiImage
//        
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
//    imgbtn9.image = SVGKImage(named: "img9")?.uiImage
//    imgbtn2.image = SVGKImage(named: "img2")?.uiImage
//    imgbtn3.image = SVGKImage(named: "img3")?.uiImage
//    imgbtn4.image = SVGKImage(named: "img4")?.uiImage
    
//    @IBAction func actCollectionReload(_ sender: Any) {
//        guard let button = sender as? UIButton else { return }
//
//        strClickAct = button.tag
//
//        switch button.tag {
//        case 1:
//            toggleSVGImage(for: imgbtn4, onImage: "img4", offImage: "selectimg4")
//            reinital()
//
//        case 2:
//            toggleSVGImage(for: imgbtn9, onImage: "img9", offImage: "selectimg9")
//            reinitalsecond()
//
//        case 3:
//            toggleSVGImage(for: imgbtn3, onImage: "img3", offImage: "selectimg3")
//            reinitalThird()
//
//        case 4:
//            toggleSVGImage(for: imgbtn2, onImage: "img2", offImage: "selectimg2")
//            reinitalFour()
//
//        default:
//            break
//        }
//
//        cvCollection.reloadData()
//    }
    func toggleSVGImage(for imageView: UIImageView, onImage: String, offImage: String) {
        let onImg = SVGKImage(named: onImage)?.uiImage
        let offImg = SVGKImage(named: offImage)?.uiImage

        if imageView.image?.pngData() == offImg?.pngData() {
            imageView.image = onImg
        } else {
            imageView.image = offImg
        }
    }

    @IBAction func actCollectionReload(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            strClickAct = 1
            if (sender as AnyObject).currentImage == UIImage(named: "filter2"){
                (sender as AnyObject).setImage(UIImage(named: "filter1"), for: .normal)
            } else {
                (sender as AnyObject).setImage(UIImage(named: "filter2"), for: .normal)
            }
            reinital()
        } else if (sender as AnyObject).tag == 2 {
            strClickAct = 2
            if (sender as AnyObject).currentImage == UIImage(named: "filter3"){
                (sender as AnyObject).setImage(UIImage(named: "filter4"), for: .normal)
            } else {
                (sender as AnyObject).setImage(UIImage(named: "filter3"), for: .normal)
            }
            reinitalsecond()
        } else if (sender as AnyObject).tag == 3 {
            strClickAct = 3

            if (sender as AnyObject).currentImage == UIImage(named: "filter5"){
                (sender as AnyObject).setImage(UIImage(named: "filter6"), for: .normal)
            } else {
                (sender as AnyObject).setImage(UIImage(named: "filter5"), for: .normal)
            }
            reinitalThird()
        } else if (sender as AnyObject).tag == 4 {
            strClickAct = 4
            if (sender as AnyObject).currentImage == UIImage(named: "filter7"){
                (sender as AnyObject).setImage(UIImage(named: "filter8"), for: .normal)
            } else {
                (sender as AnyObject).setImage(UIImage(named: "filter7"), for: .normal)
            }
            reinitalFour()
        }
        cvCollection.reloadData()
    }
//   
    
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //let cell = LMProductCellInner.cellForItem(at: indexPath)
//           // onCollectionItemTapProductCellInner?(indexPath)
//            if collectionView == productCollectionViewDetail {
//                self.NavigationController(navigateFrom: self, navigateTo: LMProductAllDetailVC(), navigateToString: VcIdentifier.LMProductAllDetailVC)
//
//            } else {
//                selectedIndexPathProduct    = nil
//                selectedIndexPathProduct    = indexPath
//               // productDetailCollectionView.reloadData()
//            }
//        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 3
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        if collectionView == cvCollection {
           
                let spacing: CGFloat = 3
                let numberOfItemsPerRow: CGFloat = 2
                let totalSpacing = (numberOfItemsPerRow - 1) * spacing
                if strClickAct == 1 {
                    let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
                    return CGSize(width: width, height: 400)
                    
                } else if strClickAct == 2 {
                    let width  = (collectionView.frame.width-16)/3
                    return CGSize(width: width, height: width)
                    
                } else if strClickAct == 3 {
                    arrcount += 1
                    if arrcount == 3 {
                        arrcount = 0
                        let width = (collectionView.frame.width - totalSpacing)
                        return CGSize(width: width, height: 400)
                    } else {
                        let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
                        return CGSize(width: width, height: 400)
                    }
                } else {
                    let width = (collectionView.frame.width + 5 - totalSpacing)
                    return CGSize(width: width, height: 600)
                }
                let width = (collectionView.frame.width - totalSpacing)
                return CGSize(width: width, height: 400)
        } else {
            let spacing: CGFloat = 6
            let numberOfItemsPerRow: CGFloat = 3
            
            let totalSpacing = (numberOfItemsPerRow - 1) * spacing
            let width = (collectionView.frame.width - 10) / numberOfItemsPerRow
            return CGSize(width: width, height: 190)
        }
        
        let width = (collectionView.frame.width - totalSpacing)
        return CGSize(width: width, height: 400)
    }

    
   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }

    // MARK: - Action

    @IBAction func actTOpCategory(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)

    }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func actFilter(_ sender: Any) {
//
//        self.NavigationController(navigateFrom: self, navigateTo: LMFilterVC(), navigateToString: VcIdentifier.LMFilterVC)
//    }
    

    @IBAction func actFilter(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let modalVC = storyboard.instantiateViewController(withIdentifier:VcIdentifier.LMFilterVC) as? LMFilterVC {
            modalVC.onStringSelected = { strQuery, minPrice , MaxPrice  in
                
                self.viewmodel.getProductCategory(productID: self.productId, strQuery: strQuery, limit: "10", page: 1,minPrice: minPrice,maxPrice: MaxPrice, sorting: "")
            }
                
                
             
                
              //  print("self.viewmodel.modelproduct?.pricingSummary.payableAmount : \(strQuery)")
          //  }
            navigationController?.pushViewController(modalVC, animated: true)
        }
    }
 
    
    @IBAction func actSearch(_ sender: Any) {
        
        self.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)

    }
}

extension LMProductDetailVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Always update the previous values
        defer {
            self.previousScrollViewHeight = scrollView.contentSize.height
            self.previousScrollOffset = scrollView.contentOffset.y
        }

        let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
        let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)

        // If the scroll was caused by the height of the scroll view changing, we want to do nothing.
        guard heightDiff == 0 else { return }

        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;

        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        if canAnimateHeader(scrollView) {

            // Calculate new header height
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }

            // Header needs to animate
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
        }
        
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }

    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)

        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }

    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight

        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }

    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }

    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight

            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func actSortingBtn(_ sender: Any) {
        print("sorting update!")
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMAddressAddVC1) as! LMAddressAddVC1
//     
//        objCancel.objectNavigation = "True"
//
//        secondVC.onApplyTappedSorting = { [weak self] indevalue, sizeArr in
//            let  keycategory = indevalue?.replacingOccurrences(of: " ", with: "")
//
//            if let keycategory = keycategory {
//                self?.viewmodel.getProductCategory(productID: (self?.productId ?? ""), strQuery: "", limit: "10", page: 1,minPrice: 0,maxPrice: 5000, sorting: keycategory)
//            }
//        }
//        self.navigationController?.pushViewController(secondVC, animated: true)
//        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let objCancel = storyboard.instantiateViewController(withIdentifier: "filterProductVC") as? filterProductVC else {
            return
        }
        objCancel.objectNavigation = "True"
        objCancel.onApplyTappedSorting = { [weak self] indevalue, sizeArr in
                   let  keycategory = indevalue?.replacingOccurrences(of: " ", with: "")
       
                   if let keycategory = keycategory {
                       self?.viewmodel.getProductCategory(productID: (self?.productId ?? ""), strQuery: "", limit: "10", page: 1,minPrice: 0,maxPrice: 5000, sorting: keycategory)
                   }
               }

        objCancel.modalPresentationStyle = .overFullScreen
        objCancel.modalTransitionStyle = .coverVertical

        if self.presentedViewController == nil && self.view.window != nil {
            self.present(objCancel, animated: true)
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let objCancel = storyboard.instantiateViewController(withIdentifier: "cancelOrderVc") as? cancelOrderVc else {
//            return
//        }
////        objCancel.objectNavigation = "True"
//        objCancel.onApplyTappedSorting = { [weak self] indevalue, sizeArr in
//            let  keycategory = indevalue?.replacingOccurrences(of: " ", with: "")
//
//            if let keycategory = keycategory {
//                self?.viewmodel.getProductCategory(productID: (self?.productId ?? ""), strQuery: "", limit: "10", page: 1,minPrice: 0,maxPrice: 5000, sorting: keycategory)
//            }
//        }

//
//          //  print("Selected: \(indevalue), \(sizeArr)")
//        
//        
//
//        objCancel.modalPresentationStyle = .overFullScreen
//        objCancel.modalTransitionStyle = .coverVertical
//
//        if self.presentedViewController == nil && self.view.window != nil {
//            self.present(objCancel, animated: true)
//        }
        
    }
    func setScrollPosition(_ position: CGFloat) {
        self.cvCollection.contentOffset = CGPoint(x: self.cvCollection.contentOffset.x, y: position)
    }

    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
       // self.topConstraint.constant = openAmount
     //   print("viewLayer--\(viewLayer.heightAnchor)---")
        self.titleTopConstraint.constant = -openAmount - 60
        //self.logoImageView.alpha = percentage
    }
}


