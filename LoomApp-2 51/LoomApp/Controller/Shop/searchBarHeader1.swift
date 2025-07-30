//
//  CustomHeaderView.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class searchBarHeader1: UICollectionReusableView ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var onproductItemTapSearchBar123: ((String) -> Void)?
    var selectedIndexPathcolorVarient1: IndexPath? = nil

    @IBOutlet weak var lblTitle: UILabel!
        
    var imgArr = [ "T-Shirts",
                    "Formal Shirts",
                    "Casual Shirts",
                    "Jeans",
                    "Chinos",
                    "Shorts",
                    "Cargo Pants",
                    "Co-Ord Set",
                   "Oversized T-Shirts",
                   "Printed Shirts",
                   "Polo T-Shirts"]
    
              
    
    @IBOutlet weak var cvHeader: UICollectionView!
        override func awakeFromNib() {
            super.awakeFromNib()
            initset()
        }
    func reloadCollection() {
         selectedIndexPathcolorVarient1 = nil
         cvHeader.reloadData()
    }
        func initset() {
            cvHeader.delegate = self
            cvHeader.dataSource = self

            // Register the custom cell class
            cvHeader.register(headercutomersearchcell.self, forCellWithReuseIdentifier: "headercutomersearchcell")

            // Set horizontal scrolling
            if let layout = cvHeader.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 8
            }
        }

        // MARK: - Collection View DataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headercutomersearchcell", for: indexPath) as! headercutomersearchcell

            cell.titleLabel.text = "  \(imgArr[indexPath.row])  " // Add padding via text or constraints
            cell.titleLabel.textColor = .lightGray
            cell.containerView.layer.borderColor = UIColor.black.cgColor
            cell.containerView.layer.borderWidth = 0.5
            

            if selectedIndexPathcolorVarient1 == indexPath {
                selectedIndexPathcolorVarient1 = nil
                cell.containerView.backgroundColor = UIColor.black
                cell.titleLabel.textColor          = UIColor.white
            } else {
                cell.containerView.backgroundColor = UIColor.white
                cell.titleLabel.textColor          = UIColor.black
            }
            
            
            return cell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objModel = "\(imgArr[indexPath.row])"
        selectedIndexPathcolorVarient1 = indexPath
        collectionView.reloadData()
        onproductItemTapSearchBar123?(objModel)
    }
    
        // MARK: - Dynamic Cell Sizing

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let text = imgArr[indexPath.item]
            let font = UIFont.systemFont(ofSize: 16)
            let textSize = (text as NSString).size(withAttributes: [.font: font])
            let width = textSize.width + 32 // Add more padding if needed
            return CGSize(width: width, height: 40)
        }
    }



