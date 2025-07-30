//
//  CustomHeaderView.swift
//  CustomHeaderView
//
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class customShopHeaderView: UITableViewHeaderFooterView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    //@IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var lbltile: UILabel!
    @IBOutlet weak var cvrecent: UICollectionView!
  //  @IBOutlet weak var cvInfinte: UICollectionView!
        @IBOutlet weak var lblProductName: UILabel!
        @IBOutlet weak var lblProductPrice: UILabel!
        @IBOutlet weak var lblColorsize: UILabel!
        @IBOutlet weak var viewColor: UIView!
       
    var subcategoriesitem: [Subcategory] = []
    var onCollectionItemTag: ((String) -> Void)?
    var selectedIndexPathPopular: IndexPath? = IndexPath(row: 0, section: 0)
    var selectedCell = [IndexPath]()
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            
            // Configure Search Bar
            print(subcategoriesitem)
            cvrecent.delegate = self
            cvrecent.dataSource = self
            cvrecent.register(UINib(nibName: "LMcellcolor", bundle: nil), forCellWithReuseIdentifier: "LMcellcolor")
        }
       func  initsetup(){
       // subcategoriesitem.reverse()
        cvrecent.reloadData()
       }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return subcategoriesitem.count
        }
 
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cvrecent.dequeueReusableCell(withReuseIdentifier: "LMcellcolor", for: indexPath) as! LMcellcolor
            cell.viewCell.layer.borderWidth     = 0.5
            cell.viewCell.layer.borderColor     = UIColor.lightGray.cgColor
            cell.viewCell.layer.backgroundColor = UIColor.white.cgColor

            let obj = subcategoriesitem[indexPath.row]

            
            if indexPath.row == 0 {
                cell.lblSize.text = "All"
                cell.lblSize.font = UIFont(name: ConstantFontSize.regular, size: 15)
                cell.viewCell.layer.backgroundColor = UIColor.black.cgColor
                cell.lblSize?.textColor = UIColor.white
            } else {
                cell.lblSize.text = obj.name
                cell.lblSize.font = UIFont(name: ConstantFontSize.regular, size: 15)
            }
            
            
            let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
            cell.updateSelectionState(isSelected: isSelected)
            if selectedIndexPathPopular == indexPath {
                cell.viewCell.layer.backgroundColor = UIColor.black.cgColor
                cell.lblSize?.textColor = UIColor.white
            } else {
                cell.viewCell.layer.backgroundColor = UIColor.white.cgColor
                cell.lblSize?.textColor = UIColor.black
            }
            
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         //selectedIndexPathPopular    = nil
         selectedIndexPathPopular    = indexPath
        cvrecent.reloadData()
        if indexPath.row == 0 {
            THconstant.Temp = "Accept"
            let obj = subcategoriesitem[indexPath.row]
            onCollectionItemTag?("")
        } else {
            let obj = subcategoriesitem[indexPath.row]
            onCollectionItemTag?(obj._id ?? "")
        }
     
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let obj = subcategoriesitem[indexPath.row]
        let font  = UIFont(name: ConstantFontSize.regular, size: 14)
        let padding: CGFloat = 30 // 8 left + 8 right
        let textSize = (obj.name as NSString).size(withAttributes: [.font: font])
        return CGSize(width: (textSize.width + padding), height: 50)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    }


 
