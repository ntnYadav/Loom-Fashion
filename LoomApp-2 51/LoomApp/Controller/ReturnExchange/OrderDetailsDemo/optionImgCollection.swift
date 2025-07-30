//
//  optionImgCollection.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 15/07/25.
//

import UIKit

class optionImgCollection: UICollectionViewCell {
    
    @IBOutlet weak var selectImg: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var selectIconImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Style image
        selectImg.layer.borderWidth = 0
        selectImg.layer.borderColor = UIColor.clear.cgColor
        selectImg.layer.cornerRadius = 8
        selectImg.clipsToBounds = true
        
        // Initially hide the selection icon
        selectIconImg.isHidden = true
        selectIconImg.tintColor = .systemBlue
    }
    
    func configureSelected(_ isSelected: Bool) {
        if isSelected {
            selectImg.layer.borderWidth = 2
            selectImg.layer.borderColor = UIColor.systemBlue.cgColor
            
            //  Show check icon
            selectIconImg.image = UIImage(systemName: "checkmark.circle.fill")
            selectIconImg.isHidden = false
        } else {
            selectImg.layer.borderWidth = 0
            selectImg.layer.borderColor = UIColor.clear.cgColor
            
            // Hide check icon
            selectIconImg.image = nil
            selectIconImg.isHidden = true
        }
    }
}


class optionImgCollection1: UICollectionViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var selectIconImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .lightText
        // Style image
//        selectImg.layer.borderWidth = 0
//        selectImg.layer.borderColor = UIColor.clear.cgColor
//        selectImg.layer.cornerRadius = 8
//        selectImg.clipsToBounds = true
//        
//        // Initially hide the selection icon
//        selectIconImg.isHidden = true
//        selectIconImg.tintColor = .systemBlue
    }
    
    func configureSelected(_ isSelected: Bool) {
        lblTitle.layer.borderWidth = 2

        if isSelected {
            lblTitle.layer.borderWidth = 2
            self.backgroundColor = .lightText

            //selectImg.layer.borderColor = UIColor.systemBlue.cgColor
            
            //  Show check icon
//            selectIconImg.image = UIImage(systemName: "checkmark.circle.fill")
//            selectIconImg.isHidden = false
        } else {
            self.backgroundColor = .clear
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1


           // selectImg.layer.borderWidth = 0
           // selectImg.layer.borderColor = UIColor.clear.cgColor
            
            // Hide check icon
//            selectIconImg.image = nil
//            selectIconImg.isHidden = true
        }
    }
}
