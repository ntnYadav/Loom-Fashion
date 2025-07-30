//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class LMNew : UICollectionViewCell {
 
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewcategory: UIView!
    @IBOutlet weak var lblproductName: UILabel!
   
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       // contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func actPlusProduct(_ sender: Any) {
    }
}
