//
//  returnTableViewCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit

class returnTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNameProducts: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var lblNameSize: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        titleNameProducts.text = "Reason for return"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

    
}
class ReturnUserDetail: UITableViewCell {

    @IBOutlet weak var lblpricedetail: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductSize: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgUserr: UIImageView!
    @IBOutlet weak var titleNameProducts: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var lblNameSize: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        titleNameProducts.text = "Reason for return"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

    
}




