//
//  LMProductCell.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMProductCell1 : UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var onproductItemTap: ((String) -> Void)?
    var onproductItemTapSearchBar: ((String) -> Void)?

    var searchSuggestions = [
                "Search shirt",
                "Search jeans",
                "Search chinos",
                "Search shorts",
                "Search formal shirt",
                "Search co-ord set",
                "Search t-shirt",
            ]
    
    var marquee = MarqueeView()
    @IBOutlet weak var viewMarqueContainer: UIView!

    var modelBanner : [Banner?] = []
    @IBOutlet weak var viewMarque: MarqueeLabel!
    @IBOutlet weak var viewPager: UIView!
    @IBOutlet weak var lblMarque: UILabel!
    @IBOutlet weak var pageview: UIPageControl!

    @IBOutlet weak var collectionView1: UICollectionView!
    let searchBar = UISearchBar()
    
    var timer = Timer()
    var timer1 = Timer()

    var counter = 0
    var counter1 = 0

    let placeholderLabel = UILabel()
    let dotsContainer = UIStackView()
    var progressView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.register(UINib(nibName: "LMProductCell12", bundle: nil), forCellWithReuseIdentifier: "LMProductCell12")

        
        marquee.frame = viewMarqueContainer.bounds
        marquee.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        viewMarqueContainer.addSubview(marquee)

        marquee.startMarquee(text: "SHIPS WITHIN 24 HOURS 📦   •   COD AVAILABLE 💸   •   MADE IN INDIA 🇮🇳   •   WHERE INDIA’S 🇮🇳 CRAFT MEET YOUR STYLE.   •   EXTRA 10% OFF ON ALL PREPAID ORDERS.")
        
        searchBarSetup()
        progressbar()

        DispatchQueue.main.async {
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        DispatchQueue.main.async {
        self.timer1 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage1), userInfo: nil, repeats: true)
        }
    }
    func setInit() {
        progressbar()
        collectionView1.reloadData()
    }

    func progressbar(){
          dotsContainer.axis = .horizontal
          dotsContainer.alignment = .center
          dotsContainer.distribution = .equalSpacing
          dotsContainer.spacing = 12
          dotsContainer.translatesAutoresizingMaskIntoConstraints = false

          viewPager.addSubview(dotsContainer)

          NSLayoutConstraint.activate([
              dotsContainer.centerXAnchor.constraint(equalTo: viewPager.centerXAnchor),
              dotsContainer.bottomAnchor.constraint(equalTo: viewPager.bottomAnchor, constant: -8),
              dotsContainer.heightAnchor.constraint(equalToConstant: 10)
          ])
           setupDotsWithProgressBar(currentIndex: 0, totalDots: modelBanner.count)

    }
    func setupDotsWithProgressBar(currentIndex: Int, totalDots: Int, selectedSize: CGFloat = 40, unselectedSize: CGFloat = 5) {
           dotsContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
   
           for i in 0..<totalDots {
               if i == currentIndex {
                   // Create outer frame
                   let frame = UIView()
                   frame.backgroundColor = UIColor.white
                   frame.layer.cornerRadius = unselectedSize / 2
                   frame.clipsToBounds = true
                   frame.translatesAutoresizingMaskIntoConstraints = false
                   frame.widthAnchor.constraint(equalToConstant: selectedSize).isActive = true
                   frame.heightAnchor.constraint(equalToConstant: unselectedSize).isActive = true
   
                   // Create inner progress view
                   let progress = UIView()
                   progress.backgroundColor = UIColor.lightGray
                   progress.layer.cornerRadius = unselectedSize / 2
                   progress.translatesAutoresizingMaskIntoConstraints = false
   
                   frame.addSubview(progress)
                   dotsContainer.addArrangedSubview(frame)
   
                   // Set initial width constraint for animation
                   let widthConstraint = progress.widthAnchor.constraint(equalToConstant: 0)
                   NSLayoutConstraint.activate([
                       progress.leadingAnchor.constraint(equalTo: frame.leadingAnchor),
                       progress.topAnchor.constraint(equalTo: frame.topAnchor),
                       progress.bottomAnchor.constraint(equalTo: frame.bottomAnchor),
                       widthConstraint
                   ])
   
                   // Animate progress bar
                   animateProgressBar(widthConstraint: widthConstraint, targetWidth: selectedSize)
               } else {
                   let dot = UIView()
                   dot.backgroundColor = UIColor.white
                   dot.layer.cornerRadius = unselectedSize / 2
                   dot.translatesAutoresizingMaskIntoConstraints = false
                   dot.widthAnchor.constraint(equalToConstant: unselectedSize).isActive = true
                   dot.heightAnchor.constraint(equalToConstant: unselectedSize).isActive = true
                   dotsContainer.addArrangedSubview(dot)
               }
           }
       }
   
       func animateProgressBar(widthConstraint: NSLayoutConstraint, targetWidth: CGFloat) {
            self.layoutIfNeeded()
           widthConstraint.constant = targetWidth
           UIView.animate(withDuration: 3.0) { // 3 seconds, similar to AUTO_SLIDE_TIME
               self.layoutIfNeeded()
           }
       }
   
    
    
    @objc func changeImage() {
     
     if counter < modelBanner.count {
         let index = IndexPath.init(item: counter, section: 0)
         let obj = modelBanner[counter]

         self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)

         counter += 1

     } else {
         if modelBanner.count != 0 {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)
             self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             counter = 1
         }
     }
  }
    
    
    
    
    @objc func changeImage1() {
     
     if counter1 < searchSuggestions.count {
         let index = IndexPath.init(item: counter1, section: 0)
         let obj = searchSuggestions[counter1]

//         self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//         setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)

         searchBar.placeholder = ""
         guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
      
         placeholderLabel.text = "       \(obj)"
         
         placeholderLabel.font = textField.font
         placeholderLabel.textColor = .white
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
         counter1 += 1

     } else {
         if searchSuggestions.count != 0 {
             counter1 = 0
             let index = IndexPath.init(item: counter, section: 0)
            // setupDotsWithProgressBar(currentIndex: counter, totalDots: modelBanner.count)
           //  self.collectionView1.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         }
     }
  }
    // self.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)
    func searchBarSetup() {
                
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        placeholderLabel.textColor = .white

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setImage(UIImage(systemName: "searchbar.jpg"), for: .search, state: .normal)
        searchBar.tintColor = .white
        contentView.addSubview(searchBar)
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let imageV = textFieldInsideSearchBar?.leftView as! UIImageView
        imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageV.tintColor = UIColor.white
        
        
        guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }

        placeholderLabel.font = textField.font
        placeholderLabel.textColor = .white
        placeholderLabel.alpha = 0
        placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
        textField.addSubview(placeholderLabel)
        
      // Change border color
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor  = UIColor.white
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.borderWidth = 1.5
            textField.layer.cornerRadius = 0
            textField.clipsToBounds = true
            
        }
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView1.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
//            collectionView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
    // Called when editing begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing began")
        onproductItemTapSearchBar!("")
        textField.resignFirstResponder()

    }

    // Called when editing ends
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Editing ended")
        textField.resignFirstResponder()

    }

    // Called when Return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Hides the keyboard
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "LMProductCell12", for: indexPath) as! LMProductCell12
       // cell.lblShopNow.layer.cornerRadius = 10
        cell.clipsToBounds = true
        let obj = modelBanner[indexPath.row]
        
        if obj?.mobileImage == nil {
            
            //cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.webVideo ?? keyName.emptyStr))
        } else {
            
           // cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.mobileImage ?? keyName.emptyStr))
        }
        
//        cell.imgCollectionViewCell1.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        cell.imgCollectionViewCell1.sd_setImage(with: URL(string:obj?.mobileImage ?? keyName.emptyStr))

        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Full height
//    }
    
    // Called when user starts editing in the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("SearchBar began editing")
        onproductItemTapSearchBar?("")
    }

   
}

