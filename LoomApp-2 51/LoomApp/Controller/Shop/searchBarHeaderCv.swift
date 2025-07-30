//
//  CustomHeaderView.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
class searchBarHeaderCv: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    @IBOutlet weak var viewheader: UIView!
    var onproductItemTapSearchBar: ((String) -> Void)?

    var timer = Timer()
    var counter = 0
    let placeholderLabel = UILabel()
    let searchBar = UISearchBar()

    var imgArr = [
                       "Search shirt",
                       "Search jeans",
                       "Search chinos",
                       "Search shorts",
                       "Search formal shirt",
                       "Search co-ord set",
                       "Search t-shirt"
    ]
    
    @IBOutlet weak var cvSearch: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewheader.layer.borderColor = UIColor.lightGray.cgColor
        viewheader.layer.borderWidth = 0.5
        viewheader.layer.cornerRadius = 0
        initset()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        searchBarSetup()
    }
    @objc func changeImage() {
     
     if counter < imgArr.count {
         let index = IndexPath.init(item: counter, section: 0)
         let nameImage = imgArr[counter]
//         self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//         setupDotsWithProgressBar(currentIndex: counter, totalDots: imgArr.count)

        // pageview.currentPage = index.row
         //currentPage = index.row
        // currentPageTemp = index.row
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
         let index = IndexPath.init(item: counter, section: 0)
//         setupDotsWithProgressBar(currentIndex: counter, totalDots: imgArr.count)
//         self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         counter = 1
     }
  }
    // Called when user starts editing in the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("SearchBar began editing")
        onproductItemTapSearchBar?("")
    }
    func searchBarSetup() {
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Set background color to white
        searchBar.barTintColor = .white
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage() // Remove default background
        if let textField = searchBar.value(forKey: "searchField") as? UITextField,
           let leftView = textField.leftView as? UIImageView {

            // Shift icon to the left
            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            leftView.frame = CGRect(x: -5, y: 0, width: 20, height: 20) // Adjust x to move left
            iconContainerView.addSubview(leftView)

            textField.leftView = iconContainerView
        }
        // Optional: Remove border/shadow under the search bar
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.clear.cgColor
        
        // Customize search icon tint (optional)
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .lightGray
            }
            
            // Optional: Customize the search text field
            textField.textColor = .black
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 8
            textField.clipsToBounds = true
        }
        
        // Add to superview
        viewheader.addSubview(searchBar)
        
        // Layout
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: viewheader.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: viewheader.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: viewheader.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func initset() {
        cvSearch.delegate = self
        cvSearch.dataSource = self

        // Register the custom cell class
        cvSearch.register(headercutomersearchcell.self, forCellWithReuseIdentifier: "headercutomersearchcell")

        // Set horizontal scrolling
        if let layout = cvSearch.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 8
        }
    }

    // MARK: - Collection View DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headercutomersearchcell", for: indexPath) as! headercutomersearchcell

        cell.titleLabel.text = "  \(imgArr[indexPath.row])  " // Add padding via text or constraints
        cell.titleLabel.textColor = .lightGray
        cell.containerView.layer.borderColor = UIColor.lightGray.cgColor
        cell.containerView.layer.borderWidth = 0.5
        return cell
    }

    // MARK: - Dynamic Cell Sizing

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = imgArr[indexPath.item]
        let font = UIFont.systemFont(ofSize: 16)
        let textSize = (text as NSString).size(withAttributes: [.font: font])
        let width = textSize.width + 32 // Add more padding if needed
        return CGSize(width: width, height: 40)
    }
}
