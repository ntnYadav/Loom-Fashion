//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMProductCell : UICollectionViewCell{
    
    @IBOutlet weak var lblClotheTypes: UILabel!

    @IBOutlet weak var viewForShadow: UIView!
    func updateSelectionState(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .blue
        } else {
            self.backgroundColor = .lightGray
        }
    }
    
}
class LMProductCellInner : UICollectionViewCell{

    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lbldiscountPrice: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!

    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var topconsview: NSLayoutConstraint!
    @IBOutlet weak var viewcolourConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintFinal: NSLayoutConstraint!
    @IBOutlet weak var topImgconstraint: NSLayoutConstraint!
    @IBOutlet weak var topconstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblColorsize: UILabel!
    @IBOutlet weak var viewColor: UIView!
    
    @IBOutlet weak var lblThirdColor: UILabel!
    @IBOutlet weak var lblSecondColor: UILabel!
    @IBOutlet weak var lblFirstColor: UILabel!
    
    @IBAction func actPavrite(_ sender: Any) {
        
    }
}
class LMProductImageCell : UICollectionViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
}

class LMShopcell : UICollectionViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
}
class LMShopPopularcell : UICollectionViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
}
class LMShopNewPopularcategory : UICollectionViewCell, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var lblProductName: UILabel!
    var categoryFlag = false
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    var selectedIndexPathPopular: IndexPath? = nil
    func setupEverytime(){
        collectionViewFilter.delegate = self
        collectionViewFilter.dataSource = self
        collectionViewFilter.register(UINib(nibName: CellIdentifier.LMNew, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.LMNew)
    }
   
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return THconstant.itemsColor.count
    }
                     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewFilter.dequeueReusableCell(withReuseIdentifier: CellIdentifier.LMNew, for: indexPath) as! LMNew
        
        if selectedIndexPathPopular == indexPath {
            cell.mainView?.backgroundColor = .black
            cell.lblproductName?.backgroundColor = .black
            cell.lblproductName?.textColor = .white
            selectedIndexPathPopular = nil
        } else {
            cell.lblproductName?.backgroundColor = .white
            cell.mainView?.backgroundColor = .white
            cell.lblproductName?.textColor = .black
        }
        if categoryFlag == true {
            cell.viewcategory.isHidden = false
            cell.lblproductName.isHidden = true
        } else {
            cell.mainView.layer.borderColor = UIColor.lightGray.cgColor
            cell.mainView.layer.borderWidth = 0.5
            cell.viewcategory.isHidden = true
            cell.lblproductName.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if categoryFlag == true {
            let width  = (collectionView.frame.width-25)/3
            return CGSize(width: width, height: 165)

        } else {
            let width  = (collectionView.frame.width-25)/4
            return CGSize(width: width, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if categoryFlag == true {
            return 5
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if categoryFlag == true {
            return 5
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPathPopular = nil
        selectedIndexPathPopular    = indexPath
        collectionViewFilter.reloadData()
    }
}
