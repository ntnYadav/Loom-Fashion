//
//  pickupAdressTblCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 14/07/25.
//

import UIKit

class pickupAdressTblCell: UITableViewCell {

        
    @IBOutlet weak var changeBtn: UIButton!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAdress: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    weak var delegate: ChangeAddressCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.borderColor = UIColor.black.cgColor
        changeBtn.setTitleColor(.systemBlue, for: .normal)
        changeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        changeBtn.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeAddressTap(_ sender: Any) {
         delegate?.didTapChangeAddress()
     }
}


protocol ChangeAddressCellDelegate: AnyObject {
    func didTapChangeAddress()
}
