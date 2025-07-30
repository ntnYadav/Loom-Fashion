//
//  SizeChangeExampleViewController.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 14.03.2023.
//

import UIKit
struct SectionData {
    let title: String
    let items: [String]
    var isExpanded: Bool
}
class LMPRoductDetailFinalVC: UIViewController{
    var productId:String = keyName.emptyStr

}
/*
class LMPRoductDetailFinalVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var imagesCollection: [String] = []
    var sizeChartUrl: String?
    var flagReload:Bool = false
    lazy fileprivate var viewmodel = LMProductDetailFinalMV(hostController: self)
    var productId:String = keyName.emptyStr

    
    let bottomButton = UIButton(type: .system)
    var flagBool:Bool = false
    var data: [SectionData] = [
        SectionData(title: "", items: ["Apple"], isExpanded: true),
        SectionData(title: "", items: ["Carrot"], isExpanded: false),
        SectionData(title: "", items: ["Carrot"], isExpanded: false),
        SectionData(title: "", items: ["Carrot"], isExpanded: false),
        SectionData(title: "", items: ["Carrot"], isExpanded: false),
        SectionData(title: "", items: ["Carrot"], isExpanded: false),
        SectionData(title: "", items: ["Carrot"], isExpanded: true),
    ]
    
    private lazy var topHeaderView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .clear  // Or any desired color
        // Add other UI elements to your header, such as labels, buttons, etc.
        return headerView
    }()

    private lazy var leftButton: UIButton = {
          let button = UIButton()
          button.translatesAutoresizingMaskIntoConstraints = false
          button.setTitle("Left", for: .normal)
          button.setTitleColor(.blue, for: .normal)  // Or any desired color
          //button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
          return button
      }()
      
      private lazy var rightButton: UIButton = {
          let button = UIButton()
          button.translatesAutoresizingMaskIntoConstraints = false
          button.setTitle("Right", for: .normal)
          button.setTitleColor(.blue, for: .normal)  // Or any desired color
          //button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
          return button
      }()
    private var collectionView: UICollectionView!
    // MARK: - Private properties

    private let minConstraintConstant: CGFloat = 50
    private let maxConstraintConstant: CGFloat = 430

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.dashed"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        
        return imageView
    }()

     lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) // Keep only one declaration
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.contentInset = .zero // Remove top space if any

        return tableView
    }()

    private var animatedConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var previousContentOffsetY: CGFloat = 0

    // MARK: - Internal properties

    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.validateValue(productId: productId)
        flagReload = false
        tableView.register(UINib(nibName: "LMProductHeader", bundle: nil), forCellReuseIdentifier: "LMProductHeader")
        tableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        tableView.register(UINib(nibName: "DevliaryCell", bundle: nil), forCellReuseIdentifier: "DevliaryCell")
        tableView.register(UINib(nibName: "LMLastCell", bundle: nil), forCellReuseIdentifier: "LMLastCell")
        tableView.register(UINib(nibName: "LMPrductDetailHeader", bundle: nil), forCellReuseIdentifier: "LMPrductDetailHeader")
        tableView.register(UINib(nibName: CellIdentifier.DetailHTMLcell, bundle: nil), forCellReuseIdentifier: CellIdentifier.DetailHTMLcell)

        
        
        bottomButton.setTitle("ADD TO BAG", for: .normal)
        bottomButton.backgroundColor = .black
        bottomButton.setTitleColor(.white, for: .normal)
        bottomButton.layer.cornerRadius = 0
        bottomButton.addTarget(self, action: #selector(handleBottomButtonTap), for: .touchUpInside)
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        view.backgroundColor = .white
        
        topHeaderView.isHidden = true
        view.addSubview(topHeaderView)  // Add the top header to the view
        topHeaderView.addSubview(leftButton)
        topHeaderView.addSubview(rightButton)
        
        self.navigationController?.isNavigationBarHidden = false
        view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        setupStickyHeader()
        setupCollectionView()
        setupAvatarView()
        setupTableView()
        setupTopHeaderViewConstraints()

        
      //  Add constraints for left and right buttons
               NSLayoutConstraint.activate([
                   // Left button
                   leftButton.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: 16),
                   leftButton.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor),
                   
                   // Right button
                   rightButton.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: -16),
                   rightButton.centerYAnchor.constraint(equalTo: topHeaderView.centerYAnchor)
               ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       // let productdetailID = viewmodel.modelproduct?.productId
        
    }
    private func setupStickyHeader() {
//        view.addSubview(stickyHeaderView)
//
//        NSLayoutConstraint.activate([
//            stickyHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            stickyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            stickyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            stickyHeaderView.heightAnchor.constraint(equalToConstant: 44)
//        ])
    }
    private func setupTopHeaderViewConstraints() {
      
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if flagReload == false {
            collectionView.reloadData()
            // Scroll to the first item only once when the view appears
            if collectionView.numberOfItems(inSection: 0) > 0 {
                let indexPath = IndexPath(item: 0, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            }
        }
       
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(UINib(nibName: "LMPlaycell", bundle: nil), forCellWithReuseIdentifier: "LMPlaycell")

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
                      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                      collectionView.heightAnchor.constraint(equalToConstant: 400)
                  ])
    }
    private func setupBottomButton() {
        view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    // MARK: - UICollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.modelproduct?.variants?[0].images.count ?? 0 //viewmodel.modelproduct?.sizestemp?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPlaycell", for: indexPath) as! LMPlaycell

        let obj = viewmodel.modelproduct?.variants?[0].images[indexPath.row] ?? keyName.emptyStr
        DispatchQueue.main.async {
            cell.imgProduct.sd_setImage(with: URL(string: obj))
        }
        cell.imgProduct.tag = indexPath.item // or your identifier
        cell.imgProduct.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cell.imgProduct.addGestureRecognizer(tapGesture)
        //cell.progressbar()
        cell.btnback.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        cell.setup()
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // MARK: - Private methods Action
        @objc func backTapped() {
            self.navigationController?.popViewController(animated: true)
        }
        @objc func imageTapped(_ sender: UITapGestureRecognizer) {
            guard let imageView = sender.view as? UIImageView else { return }
            let index = imageView.tag
            let obj = viewmodel.modelproduct?.variants?[0].images[index] ?? keyName.emptyStr
        flagReload = true
        let fullVC = LMFullImageVC()
        fullVC.imgUrl = obj
        fullVC.modalPresentationStyle = .fullScreen
        present(fullVC, animated: true, completion: nil)
    }
    // MARK: - Private methods
    private func setupAvatarView() {
        view.addSubview(collectionView)
        avatarHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: maxConstraintConstant)
        NSLayoutConstraint.activate([
            avatarHeightConstraint!,
            collectionView.topAnchor.constraint(equalTo: topHeaderView.bottomAnchor), // Placed below the top header
            //collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1.0),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        animatedConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: maxConstraintConstant)
        NSLayoutConstraint.activate([
            animatedConstraint!,
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor), // Important!
            
            // Button constraints
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bottomButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    @objc func handleBottomButtonTap() {
        let deleteSheet = LMCartPopUpVC()
        deleteSheet.modalPresentationStyle = .overFullScreen
        deleteSheet.modalTransitionStyle = .coverVertical
        present(deleteSheet, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension LMPRoductDetailFinalVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
                print("Collection view is scrolling")
        } else {
            let currentContentOffsetY = scrollView.contentOffset.y
            let scrollDiff = currentContentOffsetY - previousContentOffsetY
            
            // Upper border of the bounce effect
            let bounceBorderContentOffsetY = -scrollView.contentInset.top
            
            let contentMovesUp = scrollDiff > 0 && currentContentOffsetY > bounceBorderContentOffsetY
            let contentMovesDown = scrollDiff < 0 && currentContentOffsetY < bounceBorderContentOffsetY
            
            let currentConstraintConstant = animatedConstraint!.constant
            var newConstraintConstant = currentConstraintConstant
            
            if contentMovesUp {
                // Reducing the constraint's constant
                newConstraintConstant = max(currentConstraintConstant - scrollDiff, minConstraintConstant)
            } else if contentMovesDown {
                // Increasing the constraint's constant
                newConstraintConstant = min(currentConstraintConstant - scrollDiff, maxConstraintConstant)
            }
            
            // If the constant is modified, changing the height and disable scrolling
            if newConstraintConstant != currentConstraintConstant {
                animatedConstraint?.constant = newConstraintConstant
                scrollView.contentOffset.y = previousContentOffsetY
            }
            
            // If the height constant is modified, changing the height of avatar
//            if newConstraintConstant != avatarHeightConstraint!.constant {
//                avatarHeightConstraint?.constant = currentConstraintConstant
//            }
            previousContentOffsetY = scrollView.contentOffset.y
            // Show sticky header when table view has scrolled above the collection view
             let shouldShowHeader = newConstraintConstant <= minConstraintConstant + 10
            print("previousContentOffsetY---\(previousContentOffsetY)")
        }
    }
}

// MARK: - UITableViewDataSource

extension LMPRoductDetailFinalVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].isExpanded ? data[section].items.count : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].title
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.section].items[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        if data[section].isExpanded == false {
            headerView.lblTitle.translatesAutoresizingMaskIntoConstraints = true
            headerView.lblTitle.textAlignment = .left // initial alignment

            if section == 0 {
                headerView.lblTitle.text = "   Details"
            }else if section == 1{
                headerView.lblTitle.text = "   Details"
            } else if section == 2 {
                headerView.lblTitle.text = "   OFFERS"
            } else if section == 3 {
                headerView.lblTitle.text = "   ReVIEWS"
            } else if section == 4 {
                headerView.lblTitle.text = "   DELIVERY"
            } else if section == 5{
                headerView.lblTitle.text = "   RETURN"
            } else {
                headerView.lblTitle.text = "   YOU MAY ALSO LIKE"
            }
            
            headerView.imgPlus.image = UIImage(named: "Minus")
        } else {
            headerView.lblTitle.translatesAutoresizingMaskIntoConstraints = false
           // UIView.animate(withDuration: 0.3) {
                UIView.animate(withDuration: 0.1,
                                       delay: 0,
                                       usingSpringWithDamping: 0.8,
                                       initialSpringVelocity: 0.6,
                                       options: [.curveEaseInOut],
                                       animations: {
                    headerView.contentView.layoutIfNeeded()
                    headerView.lblTitle.textAlignment = .center // initial alignment
                    headerView.imgPlus.image = UIImage(named: "Plus")

                    if section == 0 {
                        headerView.lblTitle.text = "   Details"
                    }else if section == 1{
                        headerView.lblTitle.text = "   Details"
                    } else if section == 2 {
                        headerView.lblTitle.text = "   OFFERS"
                    } else if section == 3 {
                        headerView.lblTitle.text = "   ReVIEWS"
                    } else if section == 4 {
                        headerView.lblTitle.text = "   DELIVERY"
                    } else if section == 5{
                        headerView.lblTitle.text = "   RETURN"
                    } else {
                        headerView.lblTitle.text = "   YOU MAY ALSO LIKE"
                    }
                    
                        }, completion: nil)
                    }
        headerView.btnheader.tag = section
        headerView.btnheader.addTarget(self, action: #selector(handleExpandCollapse), for: .touchUpInside)
//        button.backgroundColor = .lightGray
        //headerView
        return headerView
        
    }
    @objc func handleExpandCollapse(sender: UIButton) {
        let section = sender.tag
        data[section].isExpanded.toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.LMProductHeader, for: indexPath) as! LMProductHeader
            cell.selectionStyle = .none

            cell.lblTitle.text = viewmodel.modelproduct?.title ?? keyName.emptyStr
           // cell.lblprice.text = keyName.rupessymbol + "\(viewmodel.modelproduct?.variants?[0].price.mrp ?? 0)"
           // cell.lblRating.text = "\(viewmodel.modelproduct?.averageRating)"
            sizeChartUrl = viewmodel.modelproduct?.sizeChart ?? ""
            cell.btnChart.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

            if let price = viewmodel.modelproduct?.variants?[0].price {
                let mrp = price.mrp
                let sellingPrice = price.sellingPrice
                let discountPercent = price.discountPercents

                let attributedPriceText = createPriceAttributedText(
                    discountPercent: discountPercent,
                    originalPrice: mrp,
                    discountedPrice: sellingPrice
                )

                cell.lblprice.attributedText = attributedPriceText
            }
            if let rating = viewmodel.modelproduct?.averageRating {
                cell.btnrating.setTitle("\(rating)", for: .normal)
//                let attributed = NSMutableAttributedString(string: " \(rating)", attributes: [
//                    .font: UIFont(name: ConstantFontSize.Bold, size: 15),.foregroundColor: UIColor.black
//                ])
//                let boldText = NSAttributedString(string: " ratings ", attributes: [
//                    .font: UIFont(name: ConstantFontSize.regular, size: 14),
//                    .foregroundColor: UIColor.lightGray
//                ])
//                attributed.append(boldText)
//                cell.lblRating.attributedText = attributed
            }
            if let review = viewmodel.modelproduct?.reviewCount {
                
                let attributed1 = NSMutableAttributedString(string: " \(review)", attributes: [
                    .font: UIFont(name: ConstantFontSize.Bold, size: 15),.foregroundColor: UIColor.black
                ])
                let boldText1 = NSAttributedString(string: "  review ", attributes: [
                    .font: UIFont(name: ConstantFontSize.regular, size: 14),
                    .foregroundColor: UIColor.lightGray
                ])
                attributed1.append(boldText1)
                cell.lblReview.attributedText = attributed1
            }
            cell.arrColor = viewmodel.modelproduct?.colors ?? []
            cell.arrSize  = viewmodel.modelproduct?.variantsColor?[0].sizes ?? []
            
            cell.onCollectionItemTag = { [weak self] arr in
                    cell.selectedIndexPathPopular    = nil
                self?.viewmodel.modelproduct?.variantsColor?[0].sizes = arr.sizes
                    self?.viewmodel.modelproduct?.variants?[0].images = arr.sizes[0].images
                    self?.viewmodel.modelproduct?.variants?[0].price = arr.sizes[0].price
                    print("self?.viewmodel.modelproduct?.variants?[0].stock = \( self?.viewmodel.modelproduct?.variantsColor?[0].sizes) arr.sizes[0].stock --\(arr.sizes)")
                    self?.collectionView.reloadData()
                    self?.tableView.reloadData()
                           //  THconstant.Temp = "Filter"
                             //self?.viewmodel.getProductListing(productID: productname, tagValue: productname, page: "1", limit: "20", subcategoryId: productname)
                         }
                     
            cell.initalSetup()
            return cell
        } else if indexPath.row == 0 && indexPath.section == 1{ //Detail
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.DetailHTMLcell, for: indexPath) as! DetailHTMLcell
            cell.selectionStyle = .none
            let htmlString = viewmodel.modelproduct?.formatedDescription ?? keyName.emptyStr
            
            let fullHTML = wrapHTMLContent("""
                                           \(htmlString)
                                           """)

            // Convert to NSAttributedString
            if let attributedString = htmlToAttributedString(fullHTML) {
                cell.txtViewDesc.attributedText = attributedString
            }
            return cell
        } else if indexPath.row == 0 && indexPath.section == 2{//Retview
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferCell
            return cell
        }else if indexPath.row == 0 && indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LMPrductDetailHeader", for: indexPath) as! LMPrductDetailHeader
            
            return cell
        }else if indexPath.row == 0 && indexPath.section == 4{//returm
            let cell = tableView.dequeueReusableCell(withIdentifier: "DevliaryCell", for: indexPath) as! DevliaryCell
            return cell
        }else if indexPath.row == 0 && indexPath.section == 5{//returm
                let cell = tableView.dequeueReusableCell(withIdentifier: "DevliaryCell", for: indexPath) as! DevliaryCell
                return cell
        }else if indexPath.row == 0 && indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LMLastCell", for: indexPath) as! LMLastCell
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Stub cell"
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .clear
            
            return cell
        }
    }
    func htmlToAttributedString(_ html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print("❌ HTML Parsing failed:", error)
            return nil
        }
    }
    private func wrapHTMLContent(_ bodyHTML: String) -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <style>
            body { font-family: -apple-system; font-size: 15px; color: #000; }
            p { margin: 10px 0; }
            strong { font-weight: bold; display: block; margin-top: 12px; }
        </style>
        </head>
        <body>
        \(bodyHTML)
        </body>
        </html>
        """
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0 // Set your desired height
        }
        return 40 // Set your desired height

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr

        if indexPath.row == 0 && indexPath.section == 0{
            return 420
        }else if indexPath.row == 0 && indexPath.section == 1{
            let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr
                let textHeight = htmlString.height(withConstrainedWidth: tableView.frame.width - 40, font: UIFont.systemFont(ofSize: 16))
                return 450
        }else if indexPath.row == 0 && indexPath.section == 2{
            return 88
        }else if indexPath.row == 0 && indexPath.section == 3{
            return 999
        }else if indexPath.row == 0 && indexPath.section == 4{
            return 130
        }else if indexPath.row == 0 && indexPath.section == 5{
            return 130
        }else if indexPath.row == 0 && indexPath.section == 6{
            return 1230
        } else {
        
            return 44
        }
    }
    
    @objc func backButtonTapped() {
        let deleteSheet = LMChartSheetVC()
        deleteSheet.sizeChartUrl = sizeChartUrl ?? keyName.emptyStr
        deleteSheet.modalPresentationStyle = .overFullScreen
        deleteSheet.modalTransitionStyle = .coverVertical
        present(deleteSheet, animated: true)
    }
    func strikethroughText(_ text: String, color: UIColor = .black) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    func createPriceAttributedText1(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

//        // Discount arrow + percentage
//        let discountString = "↓ \(discountPercent)% "
//        let discountAttributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.systemGreen,
//            .font: UIFont(name: ConstantFontSize.regular, size: 13)
//        ]
//        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
        let originalPriceString = "₹\(Int(originalPrice)) "
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = "₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }
    func createPriceAttributedText(discountPercent: Int, originalPrice: Double, discountedPrice: Double) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        // Discount arrow + percentage
        let discountString = "↓ \(discountPercent)% "
        let discountAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGreen,
            .font: UIFont(name: ConstantFontSize.regular, size: 13)
        ]
        attributedText.append(NSAttributedString(string: discountString, attributes: discountAttributes))

        // Original price with strikethrough
        let originalPriceString = "₹\(Int(originalPrice)) "
        let originalPriceAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))

        // Discounted price
        let discountedPriceString = "₹\(Int(discountedPrice))"
        let discountedPriceAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: ConstantFontSize.regular, size: 14)
        ]
        attributedText.append(NSAttributedString(string: discountedPriceString, attributes: discountedPriceAttributes))

        return attributedText
    }

}
*/
