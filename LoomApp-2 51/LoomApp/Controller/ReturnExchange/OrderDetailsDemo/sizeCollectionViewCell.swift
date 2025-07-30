//
//  sizeCollectionViewCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 17/07/25.
//

import UIKit

class sizeCollectionViewCell: UICollectionViewCell {
    var selectedIndexPath: IndexPath?  // Track selected cell

    @IBOutlet weak var lblSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
//    func configureSelected(_ isSelected: Bool) {
//        if isSelected {
//            lblSize.layer.borderWidth = 2
//            lblSize.layer.borderColor = UIColor.systemBlue.cgColor
//            
//            //  Show check icon
////            selectIconImg.image = UIImage(systemName: "checkmark.circle.fill")
////            selectIconImg.isHidden = false
//        } else {
//            lblSize.layer.borderWidth = 0
//            lblSize.layer.borderColor = UIColor.clear.cgColor
//            
//           
//        }
//    }
}
