//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class DetailHTMLcell: UITableViewCell {
    @IBOutlet weak var txtViewDesc: UITextView!
    
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      //  super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

