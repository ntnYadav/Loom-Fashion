//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.

import UIKit
import LiteStarView


class LMPrductDetailHeader: UITableViewCell ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak var collection2hieght: NSLayoutConstraint!
    
    @IBOutlet weak var collectionviewHieghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var seconViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var FirstheightConstraintView: NSLayoutConstraint!

    
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var starView1: StarView!
    var modelReviewdata : [String]?
    var modelReviewdata1 : [String]?

    var customerImages : [String]?

    @IBOutlet weak var collectionCustomerImages: UICollectionView!
    @IBOutlet weak var collectionFirstImages: UICollectionView!
    @IBOutlet weak var collectionSecondImages: UICollectionView!

    @IBOutlet weak var lblSecondLike: UILabel!
    @IBOutlet weak var lblSecondDesc: UILabel!
    @IBOutlet weak var lblSecondUserRating: UILabel!
    @IBOutlet weak var lblSecondUser: UILabel!
    
    @IBOutlet weak var lblfirstComment: UILabel!
    @IBOutlet weak var lblfirstUserName: UILabel!
    @IBOutlet weak var lblUserRating: UILabel!
    @IBOutlet weak var lblRatingshortdetail: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var cvColor: UICollectionView!
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts" ]
    var selectedCell = [IndexPath]()
    
    // static let cellIdentifier = String(describing: MainCell.self)

    @IBOutlet weak var label: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // set rating and ratingCount programmable
             starView1.rating = 3.5
            // starView1.ratingCount = 50
             // get current rating
             let currentRating = starView1.rating

//        collectionUserImage.delegate = self
//        collectionUserImage.dataSource = self
       // collectionImages.reloadData()
//        cvColor.delegate = self
//        cvColor.dataSource = self
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical  // Change to `.horizontal` if needed
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        cvColor.register(UINib(nibName: "LMcellcolor", bundle: nil), forCellWithReuseIdentifier: "LMcellcolor")
    }
    
    func initalCollectionCall() {
        collectionCustomerImages.delegate = self
        collectionCustomerImages.dataSource = self
        
        collectionFirstImages.delegate = self
        collectionFirstImages.dataSource = self
        
        collectionSecondImages.delegate = self
        collectionSecondImages.dataSource = self
        
        if customerImages?.count != 0 {
            collectionviewHieghtConstraint.constant = 0
            
        }
        collectionCustomerImages.register(UINib(nibName: "LMcellcPhoto", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto")
        collectionFirstImages.register(UINib(nibName: "LMcellcPhoto", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto")
        collectionSecondImages.register(UINib(nibName: "LMcellcPhoto", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto")
        collectionCustomerImages.reloadData()
        collectionFirstImages.reloadData()
        collectionSecondImages.reloadData()

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCustomerImages {
            return customerImages?.count ?? 0
        } else if collectionView == collectionFirstImages {
            return modelReviewdata?.count ?? 0
        } else if collectionView == collectionSecondImages {

            return modelReviewdata1?.count ?? 0
        }
        return 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionCustomerImages {
            let cell = collectionCustomerImages.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto", for: indexPath) as! LMcellcPhoto
            let obj = customerImages?[indexPath.row]
            cell.imgProduct.sd_setImage(with: URL(string: obj ?? ""))
            return cell
        } else if collectionView == collectionFirstImages {

            let cell = collectionFirstImages.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto", for: indexPath) as! LMcellcPhoto
            let obj = modelReviewdata?[indexPath.row]
            cell.imgProduct.sd_setImage(with: URL(string: obj ?? ""))
            return cell
        } else {
            let cell = collectionSecondImages.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto", for: indexPath) as! LMcellcPhoto
            let obj = modelReviewdata1?[indexPath.row]
            cell.imgProduct.sd_setImage(with: URL(string: obj ?? ""))
            
            return cell
        }
    }
    
    //7011462743
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == collectionCustomerImages {
            let width  = (collectionView.frame.width-10)/5
            return CGSize(width: width, height: (width + 10))
        } else if collectionView == collectionFirstImages {
            if modelReviewdata?.count != 0 {
                let width  = (collectionView.frame.width-10)/5
                return CGSize(width: width, height: (width + 10))
            } else {
                let width  = (collectionView.frame.width-10)/5
                return CGSize(width: width, height: 0)
            }
                
        } else {
            if modelReviewdata1?.count != 0 {
                let width  = (collectionView.frame.width-10)/5
                return CGSize(width: width, height: (width + 10))
            } else {
                let width  = (collectionView.frame.width-10)/5
                return CGSize(width: width, height: 0)
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
