//
//  tableClectionCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 08/07/25.
//

import UIKit

protocol PhotosEditDelegate: AnyObject {
  
    func didTapSizeClassImage(ndex: Int, arrSize: [ColorVariant]) //  NEW

}

class tableClectionCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    weak var delegate: PhotosEditDelegate?    
    @IBOutlet weak var colletionOption: UICollectionView!
        
    var selectedIndexPath: IndexPath?  // Track selected cell
    var arrColor:[ColorVariant] = []
    var arrSize:[SizeVariant] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup collection views
        
        let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 120, height: 120) // Set your desired cell size
         layout.minimumLineSpacing = 10
         layout.minimumInteritemSpacing = 10

         colletionOption.collectionViewLayout = layout
         colletionOption.delegate = self
         colletionOption.dataSource = self
         colletionOption.reloadData()
         colletionOption.showsHorizontalScrollIndicator = false
         colletionOption.alwaysBounceHorizontal = true
         colletionOption.reloadData()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColor.count
        
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! optionImgCollection
            let isSelected = indexPath == selectedIndexPath
            let obj = arrColor[indexPath.row]
            cell.selectImg.sd_setImage(with: URL(string: obj.image ?? ""))
             cell.lblTitle.text = obj.value
            cell.configureSelected(isSelected)
    
    
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        delegate?.didTapSizeClassImage(ndex: indexPath.row, arrSize: arrColor)
        colletionOption.reloadData()
    }


}
