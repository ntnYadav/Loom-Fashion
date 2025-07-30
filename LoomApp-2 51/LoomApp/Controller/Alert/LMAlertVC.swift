//
//  ViewController.swift
//  DemoProject
//
//  Created by chetu on 02/04/25.
//

import UIKit
import AVKit

class LMAlertVC: UIViewController {
  
    @IBOutlet weak var lblLine: UILabel!
    
    @IBOutlet weak var btnYes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLine.layer.cornerRadius = lblLine.layer.frame.height / 2
        btnYes.layer.borderWidth = 0.5
        btnYes.layer.borderColor = UIColor.lightGray.cgColor
    }
   
    @IBAction func actNo(_ sender: Any) {
    }
    @IBAction func actYes(_ sender: Any) {
    }
    
}

