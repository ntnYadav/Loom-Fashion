//
//  ExpandableCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class ExpandableCell0: UITableViewCell {
    static let cellIdentifier = String(describing: ExpandableCell0.self)
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var lblpaymentTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
        
}

    

