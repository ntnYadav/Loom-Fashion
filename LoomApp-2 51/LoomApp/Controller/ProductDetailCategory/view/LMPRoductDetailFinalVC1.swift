//
//  ViewController.swift
//  BottomSlideDemo
//
//  Created by chetu on 13/05/25.
//

import UIKit
struct Section {
    let title: String
    let items: [String]
    var isExpanded: Bool
}
class LMPRoductDetailFinalVC1: UIViewController{
    var productId:String = keyName.emptyStr

}
/*
class LMPRoductDetailFinalVC1: UIViewController,UIGestureRecognizerDelegate {
    
    var sizeChartUrl: String?

    @IBOutlet weak var tblSheet: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    // MARK: - IBOutlets
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var collectionShirts: UICollectionView!
    @IBOutlet weak var sheetTopConst: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    private var panGesture: UIPanGestureRecognizer!
    private var fullViewYPosition: CGFloat = 0
    private var partialViewYPosition: CGFloat = (UIScreen.main.bounds.height - 100) * 0.75

    // MARK: - Properties
    private var animatedConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var previousContentOffsetY: CGFloat = 0
    
    private let minConstraintConstant: CGFloat = 100
    private let maxConstraintConstant: CGFloat = 630
    var imagesCollection: [String] = []
    lazy fileprivate var viewmodel = LMProductDetailFinalMV(hostController: self)
    var productId:String = keyName.emptyStr
    
  
    
    var sections: [Section] = [
        Section(title: "", items: ["Apple"], isExpanded: true),
        Section(title: "   DETAILS ", items: ["Carrot"], isExpanded: false),
        Section(title: "   OFFERS  ", items: ["Carrot"], isExpanded: false),
        Section(title: "   REVIEW  ", items: ["Carrot"], isExpanded: false),
        Section(title: "   DELIVERY ", items: ["Carrot"], isExpanded: false),
        Section(title: "   RETURN  ", items: ["Carrot"], isExpanded: false),
        Section(title: "   YOU MAY ALSO LIKE", items: ["Carrot"], isExpanded: true),
    ]
    // MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSheet.frame = view.bounds
        tblSheet.dataSource = self
        tblSheet.delegate = self
        tblSheet.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblSheet.sectionHeaderTopPadding = 0
        viewHeader.isHidden = true
        collectionShirts.dataSource = self
        collectionShirts.delegate = self
//        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
//        sheetView.addGestureRecognizer(panGesture)
//        tblSheet.addGestureRecognizer(panGesture)
        sheetTopConst.constant = -((UIScreen.main.bounds.height - 100) * 0.75)
        viewHeight.constant = UIScreen.main.bounds.height
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionShirts.collectionViewLayout = layout
        collectionShirts.isPagingEnabled = true
        initsetup()
        setupCollectionView()
       // panGesture.delegate = self
        animatedConstraint = tblSheet.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: maxConstraintConstant)
        avatarHeightConstraint = tblSheet.heightAnchor.constraint(equalToConstant: maxConstraintConstant)
    }
    override func viewWillDisappear(_ animated: Bool) {
//        sheetView.frame.origin.y = 496
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func initsetup() {
        tblSheet.register(UINib(nibName: "LMProductHeader", bundle: nil), forCellReuseIdentifier: "LMProductHeader")
        tblSheet.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        tblSheet.register(UINib(nibName: "DevliaryCell", bundle: nil), forCellReuseIdentifier: "DevliaryCell")
        tblSheet.register(UINib(nibName: "LMLastCell", bundle: nil), forCellReuseIdentifier: "LMLastCell")
        tblSheet.register(UINib(nibName: "LMPrductDetailHeader", bundle: nil), forCellReuseIdentifier: "LMPrductDetailHeader")
        tblSheet.register(UINib(nibName: CellIdentifier.DetailHTMLcell, bundle: nil), forCellReuseIdentifier: CellIdentifier.DetailHTMLcell)
        tblSheet.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")

    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

//        collectionShirts = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionShirts.backgroundColor = .white
//        collectionShirts.isPagingEnabled = true
//        collectionShirts.showsHorizontalScrollIndicator = false
        collectionShirts.delegate = self
        collectionShirts.dataSource = self
        collectionShirts.translatesAutoresizingMaskIntoConstraints = false

        collectionShirts.register(UINib(nibName: "LMPlaycell", bundle: nil), forCellWithReuseIdentifier: "LMPlaycell")

        //view.addSubview(collectionView)
//        NSLayoutConstraint.activate([
//            collectionShirts.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionShirts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionShirts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionShirts.heightAnchor.constraint(equalToConstant: 400)
//                  ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - SelectorMethods
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let velocity = panGesture.velocity(in: view)
//        
//        // Only allow dragging when user is pulling down (y > 0) and table is at top
//        if velocity.y > 0 {
//            if tblSheet.contentOffset.y <= 0 {
//                return true
//            }
//            return false
//        }
//
//        // Allow upward drag if you want to expand sheet
//        return true
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionShirts {
                print("Collection view is scrolling")
        } else {
        let currentY = sheetView.frame.minY

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
            
        print("newConstraintConstant---\(newConstraintConstant)")

            // If the constant is modified, changing the height and disable scrolling
            if newConstraintConstant != currentConstraintConstant {
                animatedConstraint?.constant = newConstraintConstant
                sheetView.frame.origin.y = max(animatedConstraint?.constant ?? 0, animatedConstraint?.constant ?? 0)

                scrollView.contentOffset.y = previousContentOffsetY
                print("  animatedConstraint?.constant---\(  animatedConstraint?.constant)")

            }
            
            // If the height constant is modified, changing the height of avatar
            if newConstraintConstant != avatarHeightConstraint!.constant {
                avatarHeightConstraint?.constant = currentConstraintConstant
                print("avatarHeightConstraint---\(avatarHeightConstraint)")
            }
            previousContentOffsetY = scrollView.contentOffset.y
            // Show sticky header when table view has scrolled above the collection view
             let shouldShowHeader = newConstraintConstant <= minConstraintConstant + 10
        print("shouldShowHeader---\(shouldShowHeader)")

       // print("minConstraintConstant---\(minConstraintConstant)")

        let offsetY = scrollView.contentOffset.y
        print("offsetY---\(offsetY)")

        // Detect pull-down at top
            if offsetY <= 0 {
                // User pulled down at top — hide header
                if !viewHeader.isHidden {
                    viewHeader.isHidden = true
                    print("Header hidden on pull down")
                }
            }

            // Show header again when scrolling down past a threshold
            if offsetY > 10 {
                if viewHeader.isHidden {
                    viewHeader.isHidden = false
                    print("Header shown on scroll down")
                }
            }
            print("previousContentOffsetY---\(previousContentOffsetY)")
        }
    }
    @objc private func panGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        let currentY = sheetView.frame.minY
        switch recognizer.state {
        case .changed:
            let newY = currentY + translation.y
            let minY: CGFloat = 100  // 👈 Set your max upward limit here (e.g., header bottom)
            if newY >= fullViewYPosition && newY <= partialViewYPosition {
                sheetView.frame.origin.y = max(newY, minY)
                recognizer.setTranslation(.zero, in: view)
            } else {
                print("end")
            }
        case .ended:
            let shouldExpand = velocity.y < 0
            let destination = shouldExpand ? fullViewYPosition : partialViewYPosition
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                if destination <= 0 {
                    self.tblSheet.isScrollEnabled = self.sheetView.frame.origin.y == self.fullViewYPosition
                    self.viewHeader.isHidden = false
                } else {
                    self.viewHeader.isHidden = true
                }
                self.sheetView.frame.origin.y = max(destination, 100) // 👈 Clamp to same limit
            })
        default:
            viewHeader.isHidden = true
            break
        }
    }
    // MARK: - ClassMethods
    private func setupContainerView() {
        let screenHeight = UIScreen.main.bounds.height
        let containerHeight = screenHeight
        sheetView.frame = CGRect(x: 0, y: screenHeight, width: view.bounds.width, height: containerHeight)
        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 16
        sheetView.clipsToBounds = true
        view.addSubview(sheetView)
        
        // Animate to partial position on launch
        UIView.animate(withDuration: 0.3) {
            self.sheetView.frame.origin.y = self.partialViewYPosition
        }
    }
}

extension LMPRoductDetailFinalVC1: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].title.isEmpty ? 0.01 : 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(sections[indexPath.section].items[indexPath.row])")
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
                let attributed = NSMutableAttributedString(string: " \(rating)", attributes: [
                    .font: UIFont(name: ConstantFontSize.Bold, size: 15),.foregroundColor: UIColor.black
                ])
                let boldText = NSAttributedString(string: " ratings ", attributes: [
                    .font: UIFont(name: ConstantFontSize.regular, size: 14),
                    .foregroundColor: UIColor.lightGray
                ])
                attributed.append(boldText)
                cell.lblRating.attributedText = attributed
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
                
                print(arr)
                //viewmodel.modelproduct?.colors = arr.
                    self?.viewmodel.modelproduct?.variantsColor?[0].sizes = arr.sizes
                    self?.viewmodel.modelproduct?.variants?[0].images = arr.sizes[0].images
                    self?.viewmodel.modelproduct?.variants?[0].price = arr.sizes[0].price
                    self?.collectionShirts.reloadData()
                    self?.tblSheet.reloadData()
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
            
            
            
//            let fullHTML = wrapHTMLContent(htmlString)
//            if let attributed = htmlToAttributedString(fullHTML) {
//                cell.lblDescription.attributedText = attributed
//
//            }
//
           // cell.lblDescription.attributedText = htmlString.htmlToAttributedString
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
//   
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .lightGray
//        headerView.tag = section
//
//        // Label on the left
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = sections[section].title
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        headerView.addSubview(label)
//
//        // Image on the right
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "chevron.down") // Change icon if needed
//        imageView.tintColor = .darkGray
//        imageView.contentMode = .scaleAspectFit
//        headerView.addSubview(imageView)
//
//        // Layout constraints
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//
//            imageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//            imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 16),
//            imageView.heightAnchor.constraint(equalToConstant: 16),
//
//            label.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: -8)
//        ])
//
//        // Tap gesture to expand/collapse
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExpandCollapse(_:)))
//        headerView.addGestureRecognizer(tapGesture)
//
//        return headerView
//    }
//    @objc func handleExpandCollapse(_ gesture: UITapGestureRecognizer) {
//      //  let section = sender.tag
//        guard let section = gesture.view?.tag else { return }
//
//        sections[section].isExpanded.toggle()
//        tblSheet.reloadSections(IndexSet(integer: section), with: .automatic)
////        guard let section = gesture.view?.tag else { return }
////
////        sections[section].isExpanded.toggle()
////
////        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//    }
    
    // Header Tap Gesture to Expand/Collapse
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(sections[section].title, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "plusicon.png"), for: .normal) // example system image
        button.titleLabel?.textColor = .black
        // Make the image appear on the right side of the text
        button.semanticContentAttribute = .forceRightToLeft
        // Optional: add some spacing between text and image
        let width = self.view.frame.size.width
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: width - 100, bottom: 0, right:50)
        button.contentHorizontalAlignment = .left // keep text left aligned inside the button frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandCollapse), for: .touchUpInside)
        return button
    }
        @objc func handleExpandCollapse(sender: UIButton) {
            let section = sender.tag
            sections[section].isExpanded.toggle()
            tblSheet.reloadSections(IndexSet(integer: section), with: .automatic)
        }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            // Container view for header
//            let headerView = UIView()
//            headerView.backgroundColor = .white
//            
//            // Left button
//            let leftButton = UIButton(type: .system)
//            leftButton.setTitle(sections[section].title, for: .normal)
//            leftButton.contentHorizontalAlignment = .left
//            leftButton.tag = section
//            leftButton.addTarget(self, action: #selector(leftButtonTapped(_:)), for: .touchUpInside)
//            leftButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            // Right button
//            let rightButton = UIButton(type: .system)
//            rightButton.setTitle("Action", for: .normal) // Customize as needed
//            rightButton.contentHorizontalAlignment = .right
//            rightButton.tag = section
//            rightButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
//            rightButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            // Add buttons to container
//            headerView.addSubview(leftButton)
//            headerView.addSubview(rightButton)
//            
//            // Constraints
//            NSLayoutConstraint.activate([
//                // Left button pinned to left with some padding
//                leftButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//                leftButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//                leftButton.trailingAnchor.constraint(lessThanOrEqualTo: rightButton.leadingAnchor, constant: -8),
//                
//                // Right button pinned to right with padding
//                rightButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//                rightButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//                rightButton.widthAnchor.constraint(equalToConstant: 80) // fixed width or adjust as needed
//            ])
//            
//            return headerView
//        }

      
        @objc func leftButtonTapped(_ sender: UIButton) {
            let section = sender.tag
            sections[section].isExpanded.toggle()
            tblSheet.reloadSections(IndexSet(integer: section), with: .automatic)
            print("Left button tapped in section \(section)")
            // Handle left button tap
        }

        @objc func rightButtonTapped(_ sender: UIButton) {
            let section = sender.tag
            print("Right button tapped in section \(section)")
            // Handle right button tap
        }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr

        if indexPath.row == 0 && indexPath.section == 0{
            return 420
        }else if indexPath.row == 0 && indexPath.section == 1{
//            let htmlString = viewmodel.modelproduct?.description ?? keyName.emptyStr
//                let textHeight = htmlString.height(withConstrainedWidth: tableView.frame.width - 40, font: UIFont.systemFont(ofSize: 16))
//                return textHeight + 32
            return 130
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
        
            return 0
        }
    }
@objc func backButtonTapped() {
    let deleteSheet = LMChartSheetVC()
    deleteSheet.sizeChartUrl = sizeChartUrl ?? keyName.emptyStr
    deleteSheet.modalPresentationStyle = .overFullScreen
    deleteSheet.modalTransitionStyle = .coverVertical
    present(deleteSheet, animated: true)
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

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0{
//            return 0 // Set your desired height
//        }
//        return 40 // Set your desired height
//
//    }
   
    func strikethroughText(_ text: String, color: UIColor = .black) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        return NSAttributedString(string: text, attributes: attributes)
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
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension LMPRoductDetailFinalVC1: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionShirts.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        return cell
//    }
    
    // MARK: - UICollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10//viewmodel.modelproduct?.variants?[0].images.count ?? 0 //viewmodel.modelproduct?.sizestemp?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMPlaycell", for: indexPath) as! LMPlaycell
//        let obj = viewmodel.modelproduct?.variants?[0].images[indexPath.row] ?? keyName.emptyStr
//        //viewmodel.modelproduct?.sizestemp?[indexPath.row] ?? ""
//        cell.imgProduct.sd_setImage(with: URL(string: obj))
//        cell.btnback.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
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
     //Action for right button
        @objc func backTapped() {
            self.navigationController?.popViewController(animated: true)
        }
}

extension String {
//    var htmlToAttributedString: NSAttributedString? {
//        guard let data = self.data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(
//                data: data,
//                options: [
//                    .documentType: NSAttributedString.DocumentType.html,
//                    .characterEncoding: String.Encoding.utf8.rawValue
//                ],
//                documentAttributes: nil
//            )
//        } catch {
//            print("Error parsing HTML: \(error)")
//            return nil
//        }
//    }
}
 */
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}

