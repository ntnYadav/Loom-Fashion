//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//WalletDetailTableCell

import UIKit
import SVGKit

class WalletDetailTableCell1 : UITableViewCell {
  
    @IBOutlet weak var viewinner2: UIView!
    @IBOutlet weak var lblCoin: UILabel!
    @IBOutlet weak var lblLayalty: UILabel!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lblContent2: UILabel!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    var onSliderValueChanged: ((Float) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        //switch2.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)

        view2.layer.cornerRadius = view2.layer.frame.height / 2
//        slider1.minimumValue = 0
//        slider1.maximumValue = 100
//        slider1.value = 50
//        slider1.tintColor = .systemBlue
//        slider1.translatesAutoresizingMaskIntoConstraints = false
          // img2.image = SVGKImage(named: "ic_dollor")?.uiImage
           img2.image = UIImage(named: "rupee-svgrepo-com")

//        img2.image = SVGKImage(named: "ic_wa")?.uiImage

    }
//    @objc private func sliderChanged(_ sender: UISlider) {
//            onSliderValueChanged?(sender.value)
//        }
}


