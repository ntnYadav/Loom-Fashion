//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit
import WebKit


class LMSearchShopCell : UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
        
    @IBOutlet weak var cvShopcollection: UICollectionView!
  
       
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
           

        }
    
    func reloodset(){
        cvShopcollection.delegate = self
        cvShopcollection.dataSource = self
        cvShopcollection.layer.frame.size.width = self.frame.width
        cvShopcollection.layer.frame.size.height = self.frame.height
        cvShopcollection.register(UINib(nibName: "LMcellShopCell", bundle: nil), forCellWithReuseIdentifier: "LMcellShopCell")
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               layout.minimumInteritemSpacing = 10
               layout.minimumLineSpacing = 5
               self.cvShopcollection.collectionViewLayout = layout
        cvShopcollection.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cvShopcollection.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell", for: indexPath) as! LMcellShopCell

            return cell
        }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (collectionView.frame.width - 10)/2
        return CGSize(width: width, height: ((width + 10) * 2))
       }
    }

