//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit


class LMAddresslistCell : UITableViewCell {
 
    @IBOutlet weak var viewWidthCOnstraint: NSLayoutConstraint!
    @IBOutlet weak var btnLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topnameConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerheightconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btndelete: UIButton!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhonenumber: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    @IBAction func actDelete(_ sender: Any) {
        
    }
    
    @IBAction func actEdit(_ sender: Any) {
        
    }
}

class LMDefaultCell : UITableViewCell {
    @IBOutlet weak var lblDeault: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
