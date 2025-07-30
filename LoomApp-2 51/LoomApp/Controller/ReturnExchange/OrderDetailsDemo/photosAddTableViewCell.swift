//
//  photosAddTableViewCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 10/07/25.
//

import UIKit

class photosAddTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {



    weak var delegate: PhotosAddCellDelegate?
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
   
    @IBOutlet weak var imgCollectionview: UICollectionView!
       


    var images: [UIImage] = [] {
        didSet {
          
            imgCollectionview.reloadData()
            imgCollectionview.isHidden = images.isEmpty

        }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
  
        // Button Styling
        cameraBtn.layer.borderWidth = 1.0
        cameraBtn.layer.borderColor = UIColor.systemGray.cgColor
        cameraBtn.clipsToBounds = true

        galleryBtn.layer.borderWidth = 1.0
        galleryBtn.layer.borderColor = UIColor.systemGray.cgColor
        galleryBtn.clipsToBounds = true

        // CollectionView Setup
        imgCollectionview.delegate = self
        imgCollectionview.dataSource = self
        // Configure the view for the selected state
        imgCollectionview.isHidden = true

    }

    @IBAction func cameraBtn(_ sender: Any) {
        print("Camera button tapped")
        delegate?.didTapCamera()

    }
    
    @IBAction func gallryBtn(_ sender: Any) {
        print("Gallery button tapped")
        delegate?.didTapGallery()


    }
//collectionimg
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
        
        cell.imgview.image = images[indexPath.item]

        //  Assign delete closure
           cell.onDelete = { [weak self] in
               self?.delegate?.didTapDeleteImage(at: indexPath.item)
           }
              return cell
    }
    

}

protocol PhotosAddCellDelegate: AnyObject {
    func didTapCamera()
    func didTapGallery()
    func didTapDeleteImage(at index: Int) //  NEW

}
