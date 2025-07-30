//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//WalletDetailTableCell

import UIKit
import SVGKit

class WalletDetailTableCell : UITableViewCell {
   

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var lblPrice2: UILabel!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblWallet: UILabel!
    
    @IBOutlet weak var viewinner1: UIView!

    var onSliderValueChanged: ((Float) -> Void)?


    
    override func awakeFromNib() {
        super.awakeFromNib()
        slider1.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)

        view1.layer.cornerRadius = view1.layer.frame.height / 2
      
        slider1.tintColor = .lightGray
        slider1.translatesAutoresizingMaskIntoConstraints = false
//        img1.image = SVGKImage(named: "ic_dollor")?.uiImage
//        img2.image = SVGKImage(named: "ic_wa")?.uiImage

    }
    @objc private func sliderChanged(_ sender: UISlider) {
            onSliderValueChanged?(sender.value)
        }
}


