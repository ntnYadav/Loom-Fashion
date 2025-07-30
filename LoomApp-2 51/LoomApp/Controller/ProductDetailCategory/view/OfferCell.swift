//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class OfferCell: UITableViewCell {

    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!

    @IBOutlet weak var lblcoupon2: UILabel!
    @IBOutlet weak var lblCouponCode: UILabel!
    @IBOutlet weak var lblCouponCode2: UILabel!
    @IBOutlet weak var lblcouponTtile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      //  super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

