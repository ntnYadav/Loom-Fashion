//
//  ViewController.swift
//  CustomHeaderView
//
//  Created by Santosh on 04/08/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit
import SVGKit
class LMSearchVC: UIViewController,UISearchBarDelegate,UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let items = ["Shirt", "White Shirt", "Cargo", "Linen", "Jeans", "Formal", "Polo"]
    var updatedText2:String = ""

    @IBOutlet weak var EmptyImage: UIImageView!
    @IBOutlet weak var emptylbl1: UILabel!
    @IBOutlet weak var emptyLbl: UILabel!
    var currentPage = 1
    var isLoading = false
    var hasMoreData = true
    @IBOutlet weak var viewEmptyCell: UIView!

    @IBOutlet weak var viewEmpty: UIView!
    var collectionView: UICollectionView!
    lazy private var viewmodel = LMSearchMV(hostController: self)
    @IBOutlet weak var lblLabel: UILabel!
    @IBOutlet weak var searchborder: UITextField!
    @IBOutlet weak var txtSearchBorder: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewMainCollecrtion: UIView!

    
    

    
    @IBOutlet weak var tableView: UITableView!
    let  arrRecent = ["RECENT SEARCHES", "TOP SEARCHES", "TRENDING"]
    
    let  arrList = ["RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES","RECENT SEARCHES"]
    let  arrLast = ["RECENT SEARCHES", "TOP SEARCHES", "TRENDING"]
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts","All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts"]

    var searchBar = UISearchBar()
    let placeholderLabel = UILabel()
    var timer = Timer()
    var counter = 0
    var productUnselected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true) // hides the keyboard

        
        
        emptylbl1.isHidden = true
        emptyLbl.isHidden = true
        EmptyImage.isHidden = true
        viewEmptyCell.isHidden = true

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        viewEmptyCell.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: viewEmptyCell.topAnchor),
            container.leadingAnchor.constraint(equalTo: viewEmptyCell.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: viewEmptyCell.trailingAnchor, constant: -16)
        ])

        layoutButtons(in: container)
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 0)
        layout.sectionHeadersPinToVisibleBounds = true // 👈 Make header sticky
//
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        viewMainCollecrtion.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.register(UINib(nibName: "LMcellShopCell", bundle: nil), forCellWithReuseIdentifier: "LMcellShopCell")

       //collectionView.register("LMcellShopCell", forCellWithReuseIdentifier: "LMcellShopCell")

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.register(
            UINib(nibName: "searchBarHeaderCv", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "searchBarHeaderCv"
        )
        collectionView.register(
            UINib(nibName: "searchBarHeader1", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "searchBarHeader1"
        )
        
        collectionView.endEditing(true)
        viewMainCollecrtion.addSubview(collectionView)
//        viewMainCollecrtion.backgroundColor = .yellow
//        collectionView.backgroundColor = .cyan
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: viewMainCollecrtion.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewMainCollecrtion.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: viewMainCollecrtion.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewMainCollecrtion.trailingAnchor)
        ])
        
        searchBarSetup()
        tableView.contentInsetAdjustmentBehavior = .never // If you're customizing layout manually

        txtSearchBorder.delegate = self //set delegate to textfile
      //  txtSearchBorder.becomeFirstResponder()
        tableView.endEditing(true)
        searchborder.layer.borderWidth = 0.5
        searchborder.layer.borderColor = UIColor.lightGray.cgColor
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        tableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomFooterView")
        tableView.register(UINib(nibName: "LMTrendingCell", bundle: nil), forCellReuseIdentifier: "LMTrendingCell")
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        viewmodel.validateValue(str: "new")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Cell tapped")
        super.touchesBegan(touches, with: event)
        view.endEditing(true) // hides the keyboard

    }
    override func viewWillAppear(_ animated: Bool) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        productUnselected = false
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                break
            case .right:
                navigationController?.popViewController(animated: true)

            default:
                break
            }
        }
    func layoutButtons(in container: UIView) {
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 12
        let buttonHeight: CGFloat = 32
        let padding: CGFloat = 10
        let maxWidth = view.bounds.width - (padding * 2)
        let font = UIFont(name: ConstantFontSize.regular, size: 15)

        var currentRowButtons: [UIButton] = []
        var currentRowWidth: CGFloat = 0
        var allRows: [[UIButton]] = []

        // Create all buttons first
        let buttons: [UIButton] = items.enumerated().map { (index, title) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.2
            button.titleLabel?.font = font
            button.layer.cornerRadius = 0
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            let size = (title as NSString).size(withAttributes: [.font: font])
            button.frame.size = CGSize(width: size.width + 32, height: buttonHeight)
            return button
        }

        // Arrange buttons into rows
        for button in buttons {
            let buttonWidth = button.frame.width
            if currentRowWidth + buttonWidth + CGFloat(currentRowButtons.count) * horizontalSpacing > maxWidth {
                allRows.append(currentRowButtons)
                currentRowButtons = [button]
                currentRowWidth = buttonWidth
            } else {
                currentRowButtons.append(button)
                currentRowWidth += buttonWidth
            }
        }
        if !currentRowButtons.isEmpty {
            allRows.append(currentRowButtons)
        }

        // Layout each row
        var currentY: CGFloat = 0
        for row in allRows {
            let totalButtonWidth = row.reduce(0) { $0 + $1.frame.width }
            let totalSpacing = CGFloat(row.count - 1) * horizontalSpacing
            let rowWidth = totalButtonWidth + totalSpacing
            var x = (view.bounds.width - rowWidth) / 2

            for button in row {
                button.frame.origin = CGPoint(x: x, y: currentY)
                container.addSubview(button)
                x += button.frame.width + horizontalSpacing
            }
            currentY += buttonHeight + verticalSpacing
        }

        container.heightAnchor.constraint(equalToConstant: currentY).isActive = true
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let title = items[sender.tag]
        productUnselected = true
        collectionView.reloadData()
        viewmodel.validateValue(str:title)

        print("Tapped: \(title)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = viewMainCollecrtion.bounds
    }
    // Hide keyboard when Return is tapped
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder() // Hides the keyboard
          return true
      }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        
        if string == "\n" {
            txtSearchBorder.resignFirstResponder() // Hides keyboard
            return false
        }
        // Limit total characters to 6
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if  3 <= updatedText.count{
            updatedText2 = updatedText
            viewmodel.validateValue(str: updatedText)
        }
        return updatedText.count <= 50
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height - 100 {
            viewmodel.fetchNextPage()
        }
    }
    func searchBarSetup(){}
    @objc func changeImage() {}

    @IBAction func actBack(_ sender: Any) {
        if AppDelegate.shared.tabbarSearch == true {
            AppDelegate.shared.tabbarSearch = false
            self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
        } else {
            self.navigationController?.popViewController(animated: true)

        }
        

    }
}

extension LMSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrRecent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
       
        case 3:
            return arrList.count
        default:
            return arrList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "LMTrendingCell", for: indexPath) as! LMTrendingCell
            cell.selectionStyle = .none

            tableView.separatorColor = .clear
            // cell.textLabel?.text = arrList[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView

        //headerView.sectionTitleLabel.text = arrRecent[section]
        self.tableView.separatorColor = .clear

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
  
    ////      // MARK: - UICollectionViewDataSource
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
    @objc func likeaction(_ sender : UIButton) {
        let tag = sender.tag
        var objModel = viewmodel.model?.products?[tag]
        if objModel?.isWishlisted == nil {
            viewmodel.model?.products?[tag].isWishlisted = true

            objModel?.isWishlisted = true
        } else {
            if objModel?.isWishlisted == false {
                viewmodel.model?.products?[tag].isWishlisted = true

                objModel?.isWishlisted = true
            } else {
                viewmodel.model?.products?[tag].isWishlisted = false

                objModel?.isWishlisted = false
            }
        }
        collectionView.reloadData()
        viewmodel.callWishListAPI(productId: objModel?._id ?? "", strColor: objModel?.variantThumbnail?.color ?? "", strVaiantId:objModel?.variantThumbnail?.variantId ?? "")

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // if section == 2 {
            return viewmodel.model?.products?.count ?? 0
//        }
//        return 0

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
//            cell.imageView.image = UIImage(systemName: "image") // Replace with your image
//            cell.imageView.backgroundColor = .gray
//            cell.titleLabel.text = "Item \(indexPath.item)"
//            return cell
//        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMcellShopCell", for: indexPath) as! LMcellShopCell
        let objModel = viewmodel.model?.products?[indexPath.row]
        if let obj = (objModel?.variantThumbnail?.image){
                cell.imgProduct.sd_setImage(with: URL(string: obj ?? ""))
             }
            cell.lblTitle.text  = objModel?.title
            if let price = objModel?.lowestSellingPrice {
            cell.lblPrice.text = keyName.rupessymbol + " \(price)"
            }
        
        
        if objModel?.discountType == "flat" {
            let discount = Int(objModel?.lowestMRP ?? 0) - Int(objModel?.lowestSellingPrice ?? 0)
            if discount != 0 {
                
                if discount != 0 {
                    cell.lblDiscountPrice.text = "  ₹\(discount) OFF!"
                    //cell.lblDiscountPrice.textColor = .white
                    cell.imgBackground.image = UIImage(named: "red")
                } else {
                   cell.lblDiscountPrice.isHidden = true
                   cell.imgBackground.isHidden = true
                }

            } else {
               cell.lblDiscountPrice.isHidden = true
               cell.imgBackground.isHidden = true
            }
            
            
              //  cell.lblDiscountPrice.text = "₹ \(discount) OFF!"
        } else {
            
            
            
                cell.imgBackground.image = UIImage(named: "green")

                if let finalDiscountPercent1 = objModel?.finalDiscountPercent {
                    if finalDiscountPercent1 != 0 {
                        let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
                       // cell.lblDiscountPrice.textColor = .white

                        cell.lblDiscountPrice.text = "  ₹\(formatted) % OFF!"
                    } else {
                       cell.lblDiscountPrice.isHidden = true
                       cell.imgBackground.isHidden = true
                    }
                    
                  
                }
                
               
                
            
            
            
            
            
//            if let finalDiscountPercent1 = objModel?.finalDiscountPercent {
//                let formatted = String(format: "%.0f", finalDiscountPercent1)  // "10"
//                cell.lblDiscountPrice.text = "₹ \(formatted) % OFF!"
//            }
        }
        cell.btnLike.addTarget(self, action: #selector(LMSearchVC.likeaction(_:)), for: .touchUpInside)
        cell.btnLike.tag = indexPath.row
        if objModel?.isWishlisted == true {
            cell.imgLike.image = SVGKImage(named: "ic_heart_fill")?.uiImage
        } else {
            cell.imgLike.image = SVGKImage(named: "ic_heart_empty")?.uiImage
        }
        
            if let colorcode = objModel?.colorPreview?.count {
                if colorcode > 3 {
                    cell.lblProductSize.isHidden = false
                    if let countlavbel = objModel?.totalColorCount {
                        cell.lblProductSize.text = "+ \((countlavbel - 3))"
                    }
                }
                if colorcode == 1 {
                    let uiColor = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.isHidden = true
                    cell.lbl3.isHidden = true
                    
                } else if colorcode == 2 {
                    let uiColor  = LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                    let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.backgroundColor = uiColor1
                    cell.lbl3.isHidden = true
                } else {
                    let uiColor  =  LMGlobal.shared.colorFromString(objModel?.colorPreview?[0] ?? "")
                    let uiColor1 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[1] ?? "")
                    let uiColor2 = LMGlobal.shared.colorFromString(objModel?.colorPreview?[2] ?? "")
                    
                   
                    cell.lbl1.backgroundColor = uiColor
                    cell.lbl2.backgroundColor = uiColor1
                    cell.lbl3.backgroundColor = uiColor2
                }
            }
        
        
        
        
        
          //  print(colorcode)
        
            
//                cell.imageView.image = UIImage(systemName: "image") // Replace with your image
//                cell.imageView.backgroundColor = .gray
//                cell.titleLabel.text = "Item \(indexPath.item)"
            return cell
            
      //  }
    }

    // MARK: - Header View

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "searchBarHeader1",
                    for: indexPath
                ) as! searchBarHeader1
                header.lblTitle.text = "TOP SEARCHES"
                header.lblTitle.font = UIFont(name: ConstantFontSize.Bold, size: 18)
                if self.productUnselected == true {
                    header.selectedIndexPathcolorVarient1 = nil
                    header.reloadCollection()
                }
                header.onproductItemTapSearchBar123 = { [weak self] collectionIndexPath in
                    self?.view.endEditing(true)
                    self?.productUnselected = false
                    self?.viewmodel.validateValue(str: collectionIndexPath)
                }

                return header
            } else if indexPath.section == 0 {

                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "searchBarHeader1",
                    for: indexPath
                ) as! searchBarHeader1
                //header.backgroundColor = .green
                header.lblTitle.text = "TOP SEARCHES1"
                header.lblTitle.font = UIFont(name: ConstantFontSize.Bold, size: 18)

                return header
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "searchBarHeader1",
                    for: indexPath
                ) as! searchBarHeader1
                //header.backgroundColor = .green
                header.lblTitle.text = "TRENDING"
                header.lblTitle.font = UIFont(name: ConstantFontSize.Bold, size: 18)

                return header
            }
        }
        return UICollectionReusableView()
    }

    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true) // hides the keyboard

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
        let objModel = viewmodel.model?.products?[indexPath.row]
        secondVC.productId = objModel?._id ?? keyName.emptyStr
        secondVC.defaultVaniantID = objModel?.variantThumbnail?.variantId ?? ""
        self.navigationController?.pushViewController(secondVC, animated: true)
        
//        let obj = subcategoriesitem[indexPath.row]
//        onCollectionItemTap?(obj._id, obj.name)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 0 {
//            return CGSize(width: (view.frame.width - 30), height: 105)
//        } else if indexPath.section == 1{
//            return CGSize(width: (view.frame.width - 30), height: 105)
//        } else if indexPath.section == 2{
//            return CGSize(width: (view.frame.width - 30)/2, height: (40 * 10))
//        } else {
            return CGSize(width: (view.frame.width - 20)/2, height: 400)

  //      }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2{
            return CGSize(width: collectionView.bounds.width, height: 105) // Adjust height as needed
        } else {
            return CGSize(width: (view.frame.width - 30)/2, height: 400) // Adjust height as needed
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
//extension ViewController: UITextViewDelegate {
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder() // Hides keyboard
//            return false
//        }
//        return true
//    }
//}
