//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit


class LMCartCellInner : UICollectionViewCell{

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
}
class LMShopcell1 : UICollectionViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblproductSize: UILabel!
    @IBOutlet weak var btnmovetoWishlist: UIButton!

    var onQtyItemTap: ((IndexPath) -> Void)?

    @IBAction func actDelete(_ sender: Any) {
        
    }
    @IBAction func actQty(_ sender: Any) {
        RPicker.selectOption(dataArray: THconstant.arrqty) {[weak self] (selctedText, atIndex) in
            // TODO: Your implementation for selection
            self?.lblQty.text = "QTY | \(atIndex + 1)"
        }
    }

    @IBAction func actMoveTowishlist(_ sender: Any) {
      //  onQtyItemTap?(((sender as AnyObject) as! IndexPath))

    }
}
class LMCartPopularcell : UICollectionViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
}
class LMCartNewPopularcategory : UICollectionViewCell, UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    let itemsColor: [Item] = [Item(title: "GRAY"),Item(title: "BLACK"),Item(title: "NAVY"),Item(title: "BEIGE"),Item(title: "BROWN"),Item(title: "CREAM"),Item(title: "GREEN"),Item(title: "OLIVE"),Item(title: "BLUE"),Item(title: "WHITE")
    ]
    func setupEverytime(){
        collectionViewFilter.delegate = self
        collectionViewFilter.dataSource = self
        collectionViewFilter.register(UINib(nibName: "LMNew", bundle: nil), forCellWithReuseIdentifier: "LMNew")
        collectionViewFilter.reloadData()
    }
   
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsColor.count
    }
            
            
         
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let cell = collectionViewFilter.dequeueReusableCell(withReuseIdentifier: "LMFilterCell", for: indexPath) as! LMFilterCell
        let cell = collectionViewFilter.dequeueReusableCell(withReuseIdentifier: "LMNew", for: indexPath) as! LMNew
//        cell.lblSize.text = itemsColor[indexPath.row].title
//        cell.lblSize.layer.cornerRadius = 2
//        cell.lblSize.layer.borderColor = UIColor.lightGray.cgColor
//        cell.lblSize.layer.borderWidth = 0.5
       // cell.strIndexChek = indexPath.row
        
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width  = (collectionView.frame.width-25)/4
            return CGSize(width: width, height: 40)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

class LMCartFirstCell : UITableViewCell{
 
}
