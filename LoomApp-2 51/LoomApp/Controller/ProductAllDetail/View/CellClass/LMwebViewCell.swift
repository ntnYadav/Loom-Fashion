//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit
import WebKit


class LMwebViewCell : UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
        
    @IBOutlet weak var coll: UICollectionView!
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
            coll.delegate = self
            coll.dataSource = self
            coll.register(UINib(nibName: "LMcellInfinate", bundle: nil), forCellWithReuseIdentifier: "LMcellInfinate")
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = coll.dequeueReusableCell(withReuseIdentifier: "LMcellInfinate", for: indexPath) as! LMcellInfinate
            
//            cell.lblShopNow.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            cell.imgCollectionViewCell1.image = UIImage(named:"temp1")!
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            
            let width  = (collectionView.frame.width-20)/8
            return CGSize(width: width, height: width)
        }
    }

