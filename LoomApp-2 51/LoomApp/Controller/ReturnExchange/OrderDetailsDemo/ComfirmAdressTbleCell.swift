//
//  ComfirmAdressTbleCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 11/07/25.
//

import UIKit

class ComfirmAdressTbleCell: UITableViewCell {
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblpincode: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var comfmAdrsBtn: UIButton!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    weak var delegate: ConfirmAddressCellDelegate?



     var isChecked: Bool = false {
        didSet {
            // Toggle the checkmark icon
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            checkBtn.setImage(UIImage(systemName: imageName), for: .normal)
            checkBtn.tintColor = .black
            delegate?.didToggleCheckBox(isChecked: isChecked)

//            // Show/hide confirm button based on checkbox
//            comfmAdrsBtn.isHidden = isChecked
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup check button always visible
              checkBtn.setImage(UIImage(systemName: "square"), for: .normal) // default to unchecked
              checkBtn.tintColor = .black
        // Initialization code
        comfmAdrsBtn.layer.borderWidth = 1
        comfmAdrsBtn.layer.borderColor = UIColor.black.cgColor
        comfmAdrsBtn.setTitleColor(.systemBlue, for: .normal)
        comfmAdrsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        comfmAdrsBtn.clipsToBounds = true
        isChecked = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func checkComfrimBtn(_ sender: Any) {
        isChecked.toggle()  // Toggle state
        
    }
    
    @IBAction func confirmAddressTapped(_ sender: Any) {
        delegate?.didTapConfirmAddress()
        
    }
    
    
}


protocol ConfirmAddressCellDelegate: AnyObject {
    func didTapConfirmAddress()
    func didToggleCheckBox(isChecked: Bool)

}

