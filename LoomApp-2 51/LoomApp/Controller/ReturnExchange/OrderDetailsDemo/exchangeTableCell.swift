//
//  exchangeTableCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit

class exchangeTableCell: UITableViewCell {

    @IBOutlet weak var exchangeBtn: UIButton!
    
    @IBOutlet weak var refundBtn: UIButton!
    
    weak var delegate: ExchangeCellDelegate?
    var indexPath: IndexPath?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func exchangeTapped(_ sender: UIButton) {
          guard let indexPath = indexPath else { return }
          delegate?.didTapExchange(at: indexPath)
      }

      @IBAction func refundTapped(_ sender: UIButton) {
          guard let indexPath = indexPath else { return }
          delegate?.didTapRefund(at: indexPath)
      }

}


protocol ExchangeCellDelegate: AnyObject {
    func didTapExchange(at indexPath: IndexPath)
    func didTapRefund(at indexPath: IndexPath)
    
}
