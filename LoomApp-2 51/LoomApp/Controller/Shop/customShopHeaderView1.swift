//
//  CustomHeaderView.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class customShopHeaderView1: UITableViewHeaderFooterView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    //@IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var viewsearch: UIView!
    let searchBar = UISearchBar()
    @IBOutlet weak var lbltile: UILabel!
    let placeholderLabel = UILabel()
    var timer = Timer()
    var counter = 0
    @IBOutlet weak var cvrecent: UICollectionView!
  //  @IBOutlet weak var cvInfinte: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
        @IBOutlet weak var lblProductPrice: UILabel!
        @IBOutlet weak var lblColorsize: UILabel!
        @IBOutlet weak var viewColor: UIView!
       
        var imgArr = [ "Search shirt",
                       "Search jeans",
                       "Search chinos",
                       "Search shorts",
                       "Search formal shirt",
                       "Search co-ord set",
                       "Search t-shirt"]
     
        override func awakeFromNib() {
            super.awakeFromNib()
            // Configure Search Bar
            cvrecent.delegate = self
            cvrecent.dataSource = self
            cvrecent.register(UINib(nibName: "LMcellcolor", bundle: nil), forCellWithReuseIdentifier: "LMcellcolor")
          //  searchBarSetup()
        }
    @objc func changeImage() {
     
     if counter < imgArr.count {
        // let index = IndexPath.init(item: counter, section: 0)
         let nameImage = imgArr[counter]
        // self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: true)

         searchBar.placeholder = ""
         guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }

         placeholderLabel.text = "       \(nameImage)"
         placeholderLabel.font = textField.font
         placeholderLabel.textColor = .lightGray
         placeholderLabel.alpha = 0
         placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
         textField.addSubview(placeholderLabel)

         // Animate from bottom to top
         UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
             self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
             self.placeholderLabel.alpha = 1
         }, completion: nil)
         UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
             self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
             self.placeholderLabel.alpha = 1
         }, completion: nil)
         
         counter += 1
     } else {
         counter = 0
//         let index = IndexPath.init(item: counter, section: 0)
         counter = 1
     }
         
     }
    func searchBarSetup(){
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        placeholderLabel.textColor = .lightGray
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage(named: "temp")
   
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setImage(UIImage(systemName: "searchbar.jpg"), for: .search, state: .normal)
        searchBar.tintColor = .gray
        viewsearch.addSubview(searchBar)
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let imageV = textFieldInsideSearchBar?.leftView as! UIImageView
        imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageV.tintColor = UIColor.lightGray
        
        
        guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
        textField.backgroundColor = .white
        //placeholderLabel.text = "       \(nameImage)"
        placeholderLabel.font = textField.font
        placeholderLabel.textColor = .lightGray
        placeholderLabel.alpha = 0
        placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
        textField.addSubview(placeholderLabel)
        
      // Change border color
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 1.5
            textField.layer.cornerRadius = 0
            textField.clipsToBounds = true
        }
        //view.addSubview(searchBar)
        
        // Optional: Layout with Auto Layout
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

    }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cvrecent.dequeueReusableCell(withReuseIdentifier: "LMcellcolor", for: indexPath) as! LMcellcolor
            cell.viewCell.layer.borderColor = UIColor.black.cgColor
            cell.viewCell.layer.borderWidth = 1.0
            
            
            cell.lblSize.text = "   \(imgArr[indexPath.row])   "
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            
            let width  = (collectionView.frame.width-20)/3
            return CGSize(width: 100, height: 50)
        }
    }


 
