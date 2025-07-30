//
//  CustomHeaderView.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class CartCustomHeaderView: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

            var imgArr = [
                               "Search shirt",
                               "Search jeans",
                               "Search chinos",
                               "Search shorts",
                               "Search formal shirt",
                               "Search co-ord set",
                               "Search t-shirt"
            ]
            
        @IBOutlet weak var cvHeader: UICollectionView!
            override func awakeFromNib() {
                super.awakeFromNib()
                initset()
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
                cell.titleLabel.textColor = .black
                cell.containerView.layer.borderColor = UIColor.black.cgColor
                cell.containerView.layer.borderWidth = 0.2
                
                return cell
            }

            // MARK: - Dynamic Cell Sizing

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                let text = imgArr[indexPath.item]
                let font = UIFont(name: ConstantFontSize.regular, size: 16)
                let textSize = (text as NSString).size(withAttributes: [.font: font])
                let width = textSize.width + 32 // Add more padding if needed
                return CGSize(width: width, height: 40)
            }
        }



