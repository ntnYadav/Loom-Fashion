//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class DevliaryCell: UITableViewCell {

    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var lblPincode: UILabel!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var viewPincode: UIView!
    @IBOutlet weak var imgTraqck: UIImageView!
    @IBOutlet weak var view24: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

