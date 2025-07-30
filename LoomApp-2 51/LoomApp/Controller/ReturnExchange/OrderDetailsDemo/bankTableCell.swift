//
//  bankTableCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit

class bankTableCell: UITableViewCell {

    
    @IBOutlet weak var lblRefundAmount: UILabel!
    @IBOutlet weak var walletBtn: UIButton!
          
    @IBOutlet weak var bankAccountBtn: UIButton!

            
    @IBOutlet weak var adNewBankBtn: UIButton!
    
    
    weak var delegate: BankCellDelegate?
       var indexPath: IndexPath?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(isBankSelected: Bool) {
        adNewBankBtn.isHidden = !isBankSelected
       }

    @IBAction func walletActionBtn(_ sender: Any) {
        delegate?.didTapWallet()
    }
    
    @IBAction func adBankActionBtn(_ sender: Any) {
        delegate?.didTapBankAccount()

    }
    //bank add

    @IBAction func adBankBtnAction(_ sender: Any) {
        delegate?.didTapAddBank()
    }
    
}


protocol BankCellDelegate: AnyObject {
    func didTapWallet()
    func didTapBankAccount()
    func didTapAddBank()

}

