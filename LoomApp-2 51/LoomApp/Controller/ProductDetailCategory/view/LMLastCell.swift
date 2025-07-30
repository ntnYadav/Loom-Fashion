//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.

import UIKit
import SVGKit

// kadir
class LMLastCell: UITableViewCell ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var productsdetail: [SimilarProductdata] = []
    var onproductItemTap1: ((String,String) -> Void)?
    var onproductItemTapLike: ((String,String,String) -> Void)?

    
    @IBOutlet weak var cvColor: UICollectionView!
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts" ]
    var selectedCell = [IndexPath]()
    
   // static let cellIdentifier = String(describing: MainCell.self)

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cvColor.delegate = self
        cvColor.dataSource = self
        cvColor.register(UINib(nibName: "ProductDetailCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCell")
    }
    func initSet() {
        cvColor.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("productsdetail.count==\(productsdetail.count)")
        return productsdetail.count
    }
    @objc func likeaction(_ sender : UIButton) {
        let tag = sender.tag
        var objModel = productsdetail[tag]
        if objModel.isWishlisted == nil {
            productsdetail[tag].isWishlisted = true

            objModel.isWishlisted = true
        } else {
            if objModel.isWishlisted == false {
                productsdetail[tag].isWishlisted = true

                objModel.isWishlisted = true
            } else {
                productsdetail[tag].isWishlisted = false

                objModel.isWishlisted = false
            }
        }
        cvColor.reloadData()
        onproductItemTapLike?(objModel._id ?? "", objModel.variantThumbnail?.variantId ?? "", objModel.variantThumbnail?.color ?? "")

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvColor.dequeueReusableCell(withReuseIdentifier: "ProductDetailCell", for: indexPath) as! ProductDetailCell
        let objModel = productsdetail[indexPath.row]
        cell.imgProduct.sd_setImage(with: URL(string: objModel.variantThumbnail?.image ?? ""))
        cell.lblProductName.text = objModel.title
        cell.lblProductName.font = UIFont(name: "HeroNew-Regular", size: 15)
        cell.lblProductPrice.text = keyName.rupessymbol + " \(objModel.lowestSellingPrice ?? 0.0)"
        
        
        cell.btnFavorite.addTarget(self, action: #selector(LMLastCell.likeaction(_:)), for: .touchUpInside)
        
//        let svgImage:SVGKImage = SVGKImage(named: "ic_heart_empty")
//        cell.imgLike.image = svgImage.uiImage
        if objModel.isWishlisted == true {
            cell.imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
        } else {
            cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
        }
        
        cell.btnFavorite.tag = indexPath.row
        if objModel.discountType == "flat" {
            let discount = Int(objModel.lowestMRP ?? 0) - Int(objModel.lowestSellingPrice ?? 0)
                cell.lblDiscountPrice.text = "  ₹ \(discount) OFF!"
            cell.imgBackground.image = UIImage(named: "red")
        } else {
            cell.imgBackground.image = UIImage(named: "green")
            if let finalDiscountPercent1 = objModel.finalDiscountPercent {
                let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                cell.lblDiscountPrice.text = "  ₹ \(formatted) % OFF!"
            }
        }
        
        
        
        if let colorcode = objModel.colorPreview?.count {
            if colorcode < 3 {
                cell.lblCount.isHidden = false
//                if let countlavbel = objModel.totalColorCount {
//                    cell.lblCount.text = "+ \((countlavbel - 3))"
//                }
            }
            if colorcode == 1 {
                let uiColor = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                    if lowercaseString == "white" {
                        cell.lbl1.layer.borderColor = UIColor.black.cgColor
                        cell.lbl1.layer.borderWidth = 1
                    }
                }
                cell.lbl1.backgroundColor = uiColor
                cell.lbl2.isHidden = true
                cell.lbl3.isHidden = true

            } else if colorcode == 2 {
                let uiColor  = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? "")
                if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                    if lowercaseString == "white" {
                        cell.lbl1.layer.borderColor = UIColor.black.cgColor
                        cell.lbl1.layer.borderWidth = 1
                    }
                }
                if let lowercaseString = objModel.colorPreview?[1].lowercased() {
                    if lowercaseString == "white" {
                        cell.lbl2.layer.borderColor = UIColor.black.cgColor
                        cell.lbl2.layer.borderWidth = 1
                    }
                }
                cell.lbl1.backgroundColor = uiColor
                cell.lbl2.backgroundColor = uiColor1
                cell.lbl3.isHidden = true
            } else {
                let uiColor  = LMGlobal.shared.colorFromString(objModel.colorPreview?[0] ?? "")
                let uiColor1 = LMGlobal.shared.colorFromString(objModel.colorPreview?[1] ?? "")
                let uiColor2 = LMGlobal.shared.colorFromString(objModel.colorPreview?[2] ?? "")
                
                if let lowercaseString = objModel.colorPreview?[0].lowercased() {
                    if lowercaseString == "white" {
                        cell.lbl1.layer.borderColor = UIColor.black.cgColor
                        cell.lbl1.layer.borderWidth = 1
                    }
                }
                if let lowercaseString = objModel.colorPreview?[1].lowercased() {
                    if lowercaseString == "white" {
                        cell.lbl2.layer.borderColor = UIColor.black.cgColor
                        cell.lbl2.layer.borderWidth = 1
                    }
                }
                if let lowercaseString = objModel.colorPreview?[2].lowercased() {
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
        
        return cell
    }
    //2ad
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objModel = productsdetail[indexPath.row]
        onproductItemTap1?(objModel._id ?? "", objModel.variantThumbnail?.variantId ?? "")
//        let objProduct = self.storyboard?.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetailVC) as! LMProductDetailVC
        
//        let objModel = productsdetail[indexPath.row]
//        Secondvc.lblProductName.text = objModel.title
        
        
        print("pppppp")
    }
 


   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (collectionView.frame.width-10)/2
        return CGSize(width: width, height: 350)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
