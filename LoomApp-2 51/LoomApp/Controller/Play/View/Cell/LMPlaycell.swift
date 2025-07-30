//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Itsuki on 2023/10/23.
//

import UIKit

class LMPlaycell : UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var btnBag: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var collectionviewPlayInnercell: UICollectionView!
    @IBOutlet weak var btnHeart: UIButton!
    
    var imgArr = [ "Search shirt",
                   "Search jeans",
                   "Search chinos",
                   "Search shorts",
                   "Search formal shirt",
                   "Search co-ord set",
                   "Search t-shirt"]
    override func awakeFromNib() {
        super.awakeFromNib()
        viewHeader.backgroundColor = .clear
        viewHeader.isHidden = false              // show the header view
        viewHeader.alpha = 1.0                   // ensure it's fully visible
        viewHeader.layer.cornerRadius = 0
    }
    
    @IBAction func actBag(_ sender: Any) {
    }
    @IBAction func actBack(_ sender: Any) {
    }
    @IBAction func actHeart(_ sender: Any) {
    }
    func backView(){
//        let image = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate)
//        btnback.setImage(image, for: .normal)
//        btnback.tintColor = .black
//        
//            guard viewHeader != nil else {
//                print("⚠️ viewHeader is nil — check XIB connection")
//                return
//            }
//            
//            viewHeader.isHidden = false
//            viewHeader.backgroundColor = .red
        
    }
    func backViewIshidden(){
        viewHeader.isHidden = true
        self.collectionviewPlayInnercell.delegate = self
        self.collectionviewPlayInnercell.dataSource = self
        self.collectionviewPlayInnercell.register(UINib(nibName: "LMPlayInnercell", bundle: nil), forCellWithReuseIdentifier: "LMPlayInnercell")
    }
    func setup(){
        DispatchQueue.main.async {
            self.collectionviewPlayInnercell.delegate = self
            self.collectionviewPlayInnercell.dataSource = self
            self.collectionviewPlayInnercell.register(UINib(nibName: "LMPlayInnercell", bundle: nil), forCellWithReuseIdentifier: "LMPlayInnercell")

            self.collectionviewPlayInnercell.reloadData()
        }
    }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
        }
    func collectionView(
          _ collectionView: UICollectionView,
          didSelectItemAt indexPath: IndexPath
      ) {
          guard collectionView.cellForItem(at: indexPath) is LMPlayInnercell else { return }
          // My action for selecting cell
          print("Cell Selected")
      }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionviewPlayInnercell.dequeueReusableCell(withReuseIdentifier: "LMPlayInnercell", for: indexPath) as! LMPlayInnercell
            collectionviewPlayInnercell.backgroundColor = .clear
            return cell
        }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let width  = (collectionView.frame.width-45)
//            return CGSize(width: width, height: 150)
//        }
//
    
   
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemWidth = max(0, collectionView.frame.size.width - 50)
//        return CGSize(width: itemWidth, height: collectionView.frame.size.height)
//    }
    // 👇 Spacing
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let collectionWidth = collectionView.bounds.width
           let cellWidth = collectionWidth * (2 / 3)// 2/3rd of screen
           let cellHeight = collectionView.bounds.height

           return CGSize(width: cellWidth, height: cellHeight)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }

}
