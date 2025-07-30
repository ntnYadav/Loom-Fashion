//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class LMReviewRateListVC: UIViewController {

    var customerImages : [String]?

 
    lazy fileprivate var viewmodel = LMReviewListMV(hostController: self)

    @IBOutlet weak var tblReview: UITableView!
    var productId:String = ""
     

    @IBOutlet weak var collectionCustomerImages: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tblReview.delegate = self
        tblReview.dataSource = self
        
         //tblReview.register(UINib(nibName: "LMReviewlistingcell", bundle: nil), forCellReuseIdentifier: "LMReviewlistingcell")
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero // prevents auto-sizing
        layout.scrollDirection = .horizontal // 👈 vertical scrolling

        collectionCustomerImages.collectionViewLayout = layout
        
        collectionCustomerImages.delegate = self
        collectionCustomerImages.dataSource = self
        collectionCustomerImages.register(UINib(nibName: "LMcellcPhoto1", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto1")
        viewmodel.getReviewApi(productId: productId, page: 1, limit: 50)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                break
            case .right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LMReviewRateListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  viewmodel.customerImages.count

}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCustomerImages.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto1", for: indexPath) as! LMcellcPhoto1
        let obj = viewmodel.customerImages[indexPath.row]
        cell.imgProduct.sd_setImage(with: URL(string: obj))
        return cell
    }




func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemsPerRow: CGFloat = 5
    let spacing: CGFloat = 1
    let totalSpacing = spacing * (itemsPerRow - 1)
    let availableWidth = collectionView.frame.width - totalSpacing
    let itemWidth = floor(availableWidth / itemsPerRow)

    return CGSize(width: itemWidth, height: 100)
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sizevalue = sizesArr[indexPath.item].size
//        dismiss(animated: true, completion: nil)
        let fullVC = LMReviewPhotos()
        fullVC.customerImages = viewmodel.customerImages
        fullVC.modalPresentationStyle = .fullScreen
        fullVC.modalTransitionStyle = .crossDissolve
        present(fullVC, animated: true, completion: nil)
      
    }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 2
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 2
}

}
extension LMReviewRateListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.modelReviewlist.count ?? 0
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReview.dequeueReusableCell(withIdentifier: "LMReviewlistingcell", for: indexPath) as! LMReviewlistingcell
        cell.selectionStyle = .none
        let obj = viewmodel.modelReviewlist[indexPath.row]
        cell.lblUserName.text = obj.userName
        cell.lblComment.text = obj.comment
        cell.lblRate.text = "\(Int(obj.rating ?? 0.0))"
        if obj.images?.count != 0 {
            cell.img1.isHidden = false
            cell.img2.isHidden = false
            if obj.images?.count == 1 {
                cell.img1.sd_setImage(with: URL(string: obj.images?[0] ?? ""))
            }
            if obj.images?.count == 2 {
                cell.img1.sd_setImage(with: URL(string: obj.images?[0] ?? ""))
                cell.img2.sd_setImage(with: URL(string: obj.images?[1] ?? ""))
            }
        } else {
            cell.img1.isHidden = true
            cell.img2.isHidden = true
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let obj = viewmodel.modelReviewlist[indexPath.row]
        let commentText = obj.comment ?? ""
        let hasText = !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let hasImages = (obj.images?.count ?? 0) > 0
        
        var totalHeight: CGFloat = 20 // base padding top + bottom
        
        if hasText {
            let font = UIFont(name: ConstantFontSize.regular, size: 16) ?? .systemFont(ofSize: 16)
            let maxWidth = tableView.bounds.width - 32 // 16 left + right padding
            
            let boundingRect = NSString(string: commentText).boundingRect(
                with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: font],
                context: nil
            )
            totalHeight += ceil(boundingRect.height)
        }
        
        if hasImages {
            totalHeight += 120 // Adjust for 1 or 2 image previews
            totalHeight += 10 // spacing between text and images
        }
        
        return max(totalHeight, 80) // Ensure minimum height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objImage = viewmodel.modelReviewlist[indexPath.row]
        let fullVC = LMReviewClickPhotos()
        fullVC.images = objImage.images
        fullVC.modalPresentationStyle = .fullScreen
        fullVC.modalTransitionStyle = .crossDissolve
        present(fullVC, animated: true, completion: nil)
    }
}


class LMReviewlistingcell : UITableViewCell {
 
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblUserVerified: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LMReviewListCell: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblcomment: UILabel!
    // Your code here
}


