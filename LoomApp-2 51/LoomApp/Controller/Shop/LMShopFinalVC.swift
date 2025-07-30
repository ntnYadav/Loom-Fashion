//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit


class LMShopFinalVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
        
        @IBOutlet weak var viewsearch: UIView!
        @IBOutlet weak var productDetailCollectionView: UICollectionView!
        @IBOutlet weak var productCollectionViewDetail: UICollectionView!
        var strClickAct: String = ""
        let searchBar = UISearchBar()
        let placeholderLabel = UILabel()
        var selectedIndexPath: IndexPath? = nil

        var arrcount: Int = 0
            let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts","All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts"]
    let  arrMensCotegory = ["NEW", "BESTSELLERS", "SHIRT", "TROUSER","JEANS", "OVERSHIRT","CARGOS","SUNGLASSES","JOGGERS","BOXES", "SHORTS","NEW", "BESTSELLERS", "SHIRT", "TROUSER","JEANS", "OVERSHIRT","CARGOS","SUNGLASSES","JOGGERS","BOXES", "SHORTS","NEW", "BESTSELLERS", "SHIRT", "TROUSER","JEANS", "OVERSHIRT","CARGOS","SUNGLASSES","JOGGERS","BOXES", "SHORTS"]
            var selectedCell = [IndexPath]()
            var timer = Timer()
            var counter = 0
        override func viewDidLoad() {
                super.awakeFromNib()
            AlertManager.showAlert(on: self,title: "Loom Fashion",
                                                 message: "Under Development") {
                          }
                productDetailCollectionView.delegate   = self
                productDetailCollectionView.dataSource = self
                productCollectionViewDetail.delegate   = self
                productCollectionViewDetail.dataSource = self
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            searchBarSetup()
            }
    // MARK: - UISearchBarDelegate
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
       }

       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
    @objc func changeImage() {
     
     if counter < arrCotegory.count {
        // let index = IndexPath.init(item: counter, section: 0)
         let nameImage = arrCotegory[counter]
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
           searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
       ])

   }
    // MARK: - UICollectionView

            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                if collectionView == productCollectionViewDetail {
                    return arrMensCotegory.count
                } else {
                    return arrCotegory.count
                }
            }
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                if collectionView == productCollectionViewDetail {
                    if indexPath.row <= 10 {
                        let cell = productCollectionViewDetail.dequeueReusableCell(withReuseIdentifier: "LMShopcell", for: indexPath) as! LMShopcell
                        cell.lblProductName.text = arrMensCotegory[indexPath.row]
                        return cell
                    } else if indexPath.row == 11 {
                        let cell = productCollectionViewDetail.dequeueReusableCell(withReuseIdentifier: "LMShopPopularcell", for: indexPath) as! LMShopPopularcell
                        return cell
                    } else if indexPath.row == 12 {
                        let cell = productCollectionViewDetail.dequeueReusableCell(withReuseIdentifier: "LMShopNewPopularcategory", for: indexPath) as! LMShopNewPopularcategory
                        cell.setupEverytime()
                        return cell
                    } else {
                        let cell = productCollectionViewDetail.dequeueReusableCell(withReuseIdentifier: "LMProductCellInner", for: indexPath) as! LMProductCellInner
                        cell.lblColorsize.text    = "+2"
                        cell.lblProductName.text  = "Berige Korea Touser"
                        cell.lblProductPrice.text = "1212"
                        cell.viewColor.isHidden = false
                        cell.topconsview.constant  = 20

                    
                        
                        if strClickAct == "2" {
                            cell.topconsview.constant           = 0
                            cell.bottomConstraint.constant      = 0
                            cell.topconstraint.constant         = 0
                            cell.topImgconstraint.constant      = 0
                            cell.bottomConstraintFinal.constant = 0
                            cell.viewcolourConstraint.constant  = 5
                            cell.lblColorsize.text    = ""
                            cell.lblProductName.text  = ""
                            cell.lblProductPrice.text = ""
                            cell.viewColor.isHidden = true
                        }
                        return cell
                    }
                } else {
                    let cell = productDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "LMProductCell", for: indexPath) as! LMProductCell
                    cell.lblClotheTypes.text = arrCotegory[indexPath.row]
                    cell.viewForShadow.layer.cornerRadius = 10
                    cell.lblClotheTypes.layer.borderColor = UIColor.lightGray.cgColor
                    cell.lblClotheTypes.layer.borderWidth = 0.5
                    let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
                    cell.updateSelectionState(isSelected: isSelected)
                    if selectedIndexPath == indexPath {
                                // it was already selected
                                cell.lblClotheTypes?.backgroundColor = .black
                                cell.lblClotheTypes?.textColor = .white

                                selectedIndexPath = nil
                    } else {
                        cell.lblClotheTypes?.backgroundColor = .white
                        cell.lblClotheTypes?.textColor = .black

                    }
                    
                    return cell
                }
            }
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if collectionView == productCollectionViewDetail {
                } else {
                    selectedIndexPath = nil
                    selectedIndexPath    = indexPath
                    productDetailCollectionView.reloadData()
                }
            }

            func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            }

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let spacing: CGFloat = 3
                let numberOfItemsPerRow: CGFloat = 2
                let totalSpacing = (numberOfItemsPerRow - 1) * spacing
                let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
                if collectionView == productCollectionViewDetail {
                    if indexPath.row <= 10 {
                        let width  = (collectionView.frame.width)
                        return CGSize(width: width, height: 70)
                    } else if indexPath.row == 11 {
                        let width  = (collectionView.frame.width)
                        return CGSize(width: width, height: 35)
                    } else if indexPath.row == 12  {
                        let width  = (collectionView.frame.width)
                        return CGSize(width: width, height: 80)
                    } else {
                        return CGSize(width: width, height: 400)
                    }
                } else {
                    let width  = (collectionView.frame.width-25)/4
                    return CGSize(width: width, height: width)
                }
            }
       
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
    
    // MARK: - Action

    @IBAction func actsearch(_ sender: Any) {
        self.NavigationController(navigateFrom: self, navigateTo: LMShopTempVC(), navigateToString: VcIdentifier.LMShopTempVC)

       // self.NavigationController(navigateFrom: self, navigateTo: LMSearchVC(), navigateToString: VcIdentifier.LMSearchVC)

    }
    @IBAction func actFilter(_ sender: Any) {
            self.NavigationController(navigateFrom: self, navigateTo: LMFilterVC(), navigateToString: VcIdentifier.LMFilterVC)
        }
    }
//extension UISearchBar {
//    func changeSearchBarColor(color: UIColor, size: CGSize) {
//            UIGraphicsBeginImageContext(self.frame.size)
//            color.setFill()
//            UIBezierPath(rect: self.frame).fill()
//            let bgImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//            self.setSearchFieldBackgroundImage(bgImage, for: .normal)
//        }
//}
