//
//  MessageCell.swift
//  Table view with cell
//
//  Created by Shalika Lahiru on 5/13/19.
//  Copyright © 2019 Shalika Lahiru. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var senderLB: UILabel!
    @IBOutlet weak var messageLB: UILabel!
    @IBOutlet weak var onlineLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundImage(){
        profileIMG.layer.cornerRadius = profileIMG.frame.height/2
        profileIMG.layer.masksToBounds = true
        onlineLB.layer.cornerRadius = 8.0
        onlineLB.layer.masksToBounds = true
    }
}
