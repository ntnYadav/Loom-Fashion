//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMProductDifferenceCatCell : UICollectionViewCell {

    var onCollectionItemTap: ((Int) -> Void)?

    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn4: UIButton!
        
    
    func reinital() {
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
    }
    func reinitalsecond() {
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
    func reinitalThird() {
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn2.setImage(UIImage(named: "filter7"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
    func reinitalFour() {
        btn9.setImage(UIImage(named: "filter3"), for: .normal)
        btn3.setImage(UIImage(named: "filter5"), for: .normal)
        btn4.setImage(UIImage(named: "filter2"), for: .normal)
    }
@IBAction func actCollectionReload(_ sender: Any) {
    var strClickAct = 0
    if (sender as AnyObject).tag == 1 {
        if (sender as AnyObject).currentImage == UIImage(named: "filter2"){
            (sender as AnyObject).setImage(UIImage(named: "filter1"), for: .normal)
        } else {
            (sender as AnyObject).setImage(UIImage(named: "filter2"), for: .normal)
        }
        reinital()
    } else if (sender as AnyObject).tag == 2 {
        if (sender as AnyObject).currentImage == UIImage(named: "filter3"){
            (sender as AnyObject).setImage(UIImage(named: "filter4"), for: .normal)
        } else {
            (sender as AnyObject).setImage(UIImage(named: "filter3"), for: .normal)
        }
        reinitalsecond()
    } else if (sender as AnyObject).tag == 3 {
        if (sender as AnyObject).currentImage == UIImage(named: "filter5"){
            (sender as AnyObject).setImage(UIImage(named: "filter6"), for: .normal)
        } else {
            (sender as AnyObject).setImage(UIImage(named: "filter5"), for: .normal)
        }
        reinitalThird()
    } else if (sender as AnyObject).tag == 4 {
        if (sender as AnyObject).currentImage == UIImage(named: "filter7"){
            (sender as AnyObject).setImage(UIImage(named: "filter8"), for: .normal)
        } else {
            (sender as AnyObject).setImage(UIImage(named: "filter7"), for: .normal)
        }
        reinitalFour()
    }
   // onCollectionItemTap?((strClickAct))
}
//    @IBOutlet weak var lblClotheTypes: UILabel!
//
//    @IBOutlet weak var viewForShadow: UIView!
//    func updateSelectionState(isSelected: Bool) {
//        if isSelected {
//            self.backgroundColor = .blue
//        } else {
//            self.backgroundColor = .lightGray
//        }
    }
    




class LMProductSubCelltemp : UICollectionViewCell, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    @IBOutlet weak var lblProductName: UILabel!
//    var categoryFlag = false
    @IBOutlet weak var cvProductCategory: UICollectionView!
    var selectedIndexPathPopular: IndexPath? = nil
    var categoryFlag = false

    func setupEverytime(){
       cvProductCategory.delegate = self
       cvProductCategory.dataSource = self
       cvProductCategory.register(UINib(nibName: CellIdentifier.LMNew, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.LMNew)
    }
   
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return THconstant.itemsColor.count
    }
                     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvProductCategory.dequeueReusableCell(withReuseIdentifier: CellIdentifier.LMNew, for: indexPath) as! LMNew

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
//        if categoryFlag == true {
//            let width  = (collectionView.frame.width-25)/3
//            return CGSize(width: width, height: 165)
//
//        } else {
            let width  = (collectionView.frame.width-25)/4
            return CGSize(width: width, height: 40)
      //  }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        if categoryFlag == true {
//            return 5
//        } else {
            return 4
      //  }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if categoryFlag == true {
//            return 5
//        } else {
            return 4
      //  }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPathPopular = nil
        selectedIndexPathPopular    = indexPath
        cvProductCategory.reloadData()
    }
}
