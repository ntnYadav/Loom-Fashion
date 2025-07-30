//
//  ExpandableCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit


class ExpandableCellFilter: UITableViewCell {
    static let cellIdentifier = String(describing: ExpandableCell.self)
 
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var imgUnselected: NSLayoutConstraint!
    @IBOutlet weak var lblNameRow: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblName: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
   
    
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
    
private enum Constants1 {
    static let spacing: CGFloat = 1
    static let borderWidth: CGFloat = 0.5
    static let reuseID = "CollectionCell"
}
