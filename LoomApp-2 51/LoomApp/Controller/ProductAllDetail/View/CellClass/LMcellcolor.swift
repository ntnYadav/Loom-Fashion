//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMcellcolor : UICollectionViewCell {
    var onproductItemTapSearch: ((String) -> Void)?

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var viewCell: UIView!
 
    func updateSelectionState(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .blue
        } else {
            self.backgroundColor = .lightGray
        }
    }
    // Note: must be strong
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}
