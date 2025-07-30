//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class LMReviewRateVC: UIViewController {
    
//UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var btnCamera: UIButton!
    
    @IBOutlet weak var btnSUbmit: UIButton!
    @IBOutlet weak var txtVIewText: UITextView!
    @IBOutlet weak var btnGalary: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
      
    }
    
}
