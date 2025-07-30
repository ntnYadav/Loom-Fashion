//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit
import WebKit


class LMSearchCell : UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
        
    @IBOutlet weak var cvrecent: UICollectionView!
  //  @IBOutlet weak var cvInfinte: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
        @IBOutlet weak var lblProductPrice: UILabel!
        @IBOutlet weak var lblColorsize: UILabel!
        @IBOutlet weak var viewColor: UIView!
       
        var imgArr = [ "Search shirt",
                       "Search jeans",
                       "Search chinos",
                       "Search shorts",
                       "Search formal shirt",
                       "Search co-ord set",
                       "Search t-shirt"]
     
        override func awakeFromNib() {
            super.awakeFromNib()
            // Configure Search Bar
            cvrecent.delegate = self
            cvrecent.dataSource = self
            cvrecent.register(UINib(nibName: "LMcellcolor", bundle: nil), forCellWithReuseIdentifier: "LMcellcolor")
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cvrecent.dequeueReusableCell(withReuseIdentifier: "LMcellcolor", for: indexPath) as! LMcellcolor
            cell.viewCell.layer.borderColor = UIColor.black.cgColor
            cell.viewCell.layer.borderWidth = 1.0
            
            
            cell.lblSize.text = "   \(imgArr[indexPath.row])   "
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            
            let width  = (collectionView.frame.width-20)/5
            return CGSize(width: width, height: width)
        }
    }

