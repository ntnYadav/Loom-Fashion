//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//WalletDetailTableCell

import UIKit
import SVGKit

class WalletDetailTableCell12 : UITableViewCell {
   
    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var btnchange: UIButton!
    @IBOutlet weak var viewaddress: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblpincode: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    weak var delegate: ConfirmAddressCellDelegate1?

    var isChecked: Bool = false {
        didSet {
            // Toggle the checkmark icon
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            btnCheck.setImage(UIImage(systemName: imageName), for: .normal)
            btnCheck.tintColor = .black
            delegate?.didToggleCheckBox1(isChecked: isChecked)
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCheck.setImage(UIImage(systemName: "square"), for: .normal) // default to unchecked
        btnCheck.tintColor = .black
  // Initialization code
        btnchange.layer.borderWidth = 1
        btnchange.layer.borderColor = UIColor.black.cgColor
        btnchange.setTitleColor(.systemBlue, for: .normal)
        btnchange.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btnchange.clipsToBounds = true
        isChecked = false
    }
    @IBAction func checkComfrimBtn(_ sender: Any) {
        isChecked.toggle()  // Toggle state
    }
    
    @IBAction func confirmAddressTapped(_ sender: Any) {
        delegate?.didTapConfirmAddress1()
    }
}

protocol ConfirmAddressCellDelegate1: AnyObject {
        func didTapConfirmAddress1()
        func didToggleCheckBox1(isChecked: Bool)
}

