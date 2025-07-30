//
//  PhotoCollectionCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 11/07/25.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var deleteImgBtn: UIButton!
    
    var onDelete: (() -> Void)?  // Closure for deletion

      @IBAction func deleteBtnTapped(_ sender: UIButton) {
          onDelete?()
      }
    
    
}
