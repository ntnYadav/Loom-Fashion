//
//  sizeTableViewCell.swift
//  OrderDetailsDemo
//
//  Created by Abdul Quadir on 17/07/25.
//

import UIKit
protocol PhotosSizeDelegate: AnyObject {
  
    func didTapSizeClassImage1(ndex: Int, arrSize: [SizeVariant]) //  NEW

}
extension sizeTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // Set cell size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Example: fixed width and height
        return CGSize(width: 50, height: 50)
        
        // OR: dynamic width based on text (optional)
        // let text = arrSize[indexPath.row].size
        // let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 20
        // return CGSize(width: width, height: 40)
    }
}

class sizeTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {
    weak var delegate: PhotosSizeDelegate?
    var selectedIndexPath: IndexPath?  // Track selected cell

    @IBOutlet weak var sizeCollectionView1: UICollectionView!
    var arrSize:[SizeVariant] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 

        sizeCollectionView1.delegate = self
        sizeCollectionView1.dataSource = self
        sizeCollectionView1.reloadData()
      
        sizeCollectionView1.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSize.count
        
        
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell2", for: indexPath) as! sizeCollectionViewCell
            let obj = arrSize[indexPath.row]
            cell.lblSize.text = obj.size
            cell.lblSize.layer.borderColor = UIColor.clear.cgColor
            if selectedIndexPath == indexPath {
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.black.cgColor
                cell.backgroundColor = UIColor.black

                cell.lblSize.textColor = .white
               // selectedIndexPath = nil
            } else {
                cell.layer.borderWidth = 1
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.backgroundColor = UIColor.white

                cell.lblSize.textColor = .black
            }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = nil
        selectedIndexPath = indexPath
        delegate?.didTapSizeClassImage1(ndex: indexPath.row, arrSize: arrSize)
        sizeCollectionView1.reloadData()
    }


}
