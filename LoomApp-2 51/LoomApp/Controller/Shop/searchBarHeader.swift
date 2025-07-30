//
//  CustomHeaderView.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class searchBarHeader: UICollectionReusableView ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var subcategoriesitem: [Subcategory] = []
    var onCollectionItemTag: ((String) -> Void)?
    var selectedIndexPathPopular12: IndexPath? = IndexPath(row: 0, section: 0)

        var imgArr = [
            "Search shirt",
                           "Search jeans",
                           "Search chinos",
                           "Search shorts",
                           "Search formal shirt",
                           "Search co-ord set",
                           "Search t-shirt"
        ]
        
    @IBOutlet weak var cvHeader: UICollectionView!
        override func awakeFromNib() {
            super.awakeFromNib()
            initset()
        }

        func initset() {
            print("subcategoriesitemsubcategoriesitem==\(subcategoriesitem)")
            cvHeader.delegate = self
            cvHeader.dataSource = self

            // Register the custom cell class
            cvHeader.register(headercutomersearchcell.self, forCellWithReuseIdentifier: "headercutomersearchcell")

            // Set horizontal scrolling
            if let layout = cvHeader.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 8
            }
            cvHeader.reloadData()
            
        }

        // MARK: - Collection View DataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return subcategoriesitem.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headercutomersearchcell", for: indexPath) as! headercutomersearchcell

            let obj = subcategoriesitem[indexPath.row]

//            cell.titleLabel.text =   obj.name  // "Add padding via text or constraints
//            cell.titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 15)
            cell.titleLabel.textAlignment = .center
            if indexPath.row == 0 {
                cell.titleLabel.text = "All"
                cell.titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 15)
                //cell.titleLabel.layer.backgroundColor = UIColor.black.cgColor
                cell.titleLabel.textColor = UIColor.white
            } else {
                cell.titleLabel.text = obj.name
                cell.titleLabel.font = UIFont(name: ConstantFontSize.regular, size: 15)
            }

            if selectedIndexPathPopular12 == indexPath {
                cell.containerView.layer.backgroundColor = UIColor.black.cgColor
                cell.titleLabel.textColor = UIColor.white
            } else {
                cell.containerView.layer.backgroundColor = UIColor.white.cgColor
                cell.titleLabel.textColor = UIColor.black
            }
           
            
//            cell.titleLabel.textColor = .lightGray
//            cell.containerView.layer.borderColor = UIColor.lightGray.cgColor
            cell.containerView.layer.borderWidth = 0.5
            return cell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPathPopular12    = nil
        if indexPath.row == 0 {
            selectedIndexPathPopular12 = IndexPath(row: 0, section: 0)
            THconstant.Temp = "Accept"
            let obj = subcategoriesitem[indexPath.row]
            onCollectionItemTag?("")
        } else {
            selectedIndexPathPopular12    = indexPath
            let obj = subcategoriesitem[indexPath.row]
            onCollectionItemTag?(obj._id ?? "")
        }
        cvHeader.reloadData()

    }
        // MARK: - Dynamic Cell Sizing

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let obj = subcategoriesitem[indexPath.row]
            
            let font = UIFont.systemFont(ofSize: 16)
            let textSize = (obj.name as! NSString).size(withAttributes: [.font: font])
            let width = textSize.width + 32 // Add more padding if needed
            return CGSize(width: width, height: 40)
        }
    }




class headercutomersearchcell: UICollectionViewCell {

    let containerView = UIView()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }
}
