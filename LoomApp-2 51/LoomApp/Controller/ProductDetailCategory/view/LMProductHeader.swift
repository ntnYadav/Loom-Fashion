//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.

import UIKit


class LMProductHeader: UITableViewCell ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var btnShare: UIButton!
    var selectedIndexPathPopular: IndexPath? = nil
    var selectedIndexPathcolorVarient: IndexPath? = nil
    @IBOutlet weak var lbldiscountPrice: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!

    var onCollectionItemcolorSize: ((_ index: Int, _ sizes: [SizeVariant]) -> Void)?
    var onCollectionItemTag: ((ColorVariant) -> Void)?
    @IBOutlet weak var lblNotify: UITextView!
    @IBOutlet weak var btnChart: UIButton!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnrating: UIButton!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var btnratingandreview: UIButton!
    @IBOutlet var cvSize: UICollectionView!
    @IBOutlet weak var cvColor: UICollectionView!
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts" ]
    var selectedCell = [IndexPath]()
   var arrColor:[ColorVariant] = []
   var arrSize:[SizeVariant] = []
    var sortedSizes:[SizeVariant] = []

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     //let preferredOrder = arrSize
       
    }
    @IBAction func actShare(_ sender: Any) {
    }
    @IBAction func actSizesheet(_ sender: Any) {
    }
//    let price: PriceDetail
//    let stock: StockDetail
    
    func initalSetup(){
        cvSize.delegate = self
        cvSize.dataSource = self
        cvColor.delegate = self
        cvColor.dataSource = self
        applyCenteredLayout()
        applyCenteredLayoutColor()
        cvColor.register(UINib(nibName: "LMcellcPhoto", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto")
        cvSize.register(UINib(nibName: "LMcellcPhoto", bundle: nil), forCellWithReuseIdentifier: "LMcellcPhoto")
        cvSize.reloadData()
        cvColor.reloadData()
    }
    func applyCenteredLayout() {
        guard let layout = cvSize.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let itemSize: CGFloat = 49
        let spacing: CGFloat = 2
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        let itemCount = arrSize.count
        let totalCellWidth = CGFloat(itemCount) * itemSize
        let totalSpacingWidth = CGFloat(max(itemCount - 1, 0)) * spacing
        let totalContentWidth = totalCellWidth + totalSpacingWidth
        let collectionWidth = cvSize.bounds.width
        let horizontalInset = max((collectionWidth - totalContentWidth) / 2, 0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.invalidateLayout()
    }
    func applyCenteredLayoutColor() {
        guard let layout = cvColor.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemSize: CGFloat = 70
        let spacing: CGFloat = 3
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        let itemCount = arrColor.count
        let totalItemWidth = CGFloat(itemCount) * itemSize
        let totalSpacing = CGFloat(itemCount + 1) * spacing // spaces before, between, and after

        let totalContentWidth = totalItemWidth + totalSpacing
        let collectionWidth = cvColor.bounds.width

        if totalContentWidth < collectionWidth {
            let inset = (collectionWidth - totalItemWidth - (CGFloat(itemCount - 1) * spacing)) / 2
            layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        } else {
            layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        }

        layout.invalidateLayout()
        cvColor.reloadData()
    }

//    func applyCenteredLayoutColor() {
//        guard let layout = cvColor.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//        let itemSize: CGFloat = 50
//        let spacing: CGFloat = 2 // Adjust spacing to match design
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: itemSize, height: itemSize)
//        layout.minimumInteritemSpacing = spacing
//        layout.minimumLineSpacing = spacing // Important for horizontal layout
//
//        let itemCount = arrColor.count
//        let totalItemWidth = CGFloat(itemCount) * itemSize
//        let totalSpacing = CGFloat(max(0, itemCount - 1)) * spacing
//        let totalContentWidth = totalItemWidth + totalSpacing
//
//        let collectionWidth = cvColor.bounds.width
//
//        if totalContentWidth < collectionWidth {
//            let inset = (collectionWidth - totalContentWidth) / 2
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        } else {
//            layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
//        }
//
//        layout.invalidateLayout()
//        cvColor.reloadData()
//    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
 
//    func applyCenteredLayoutColor() {
//        guard let layout = cvColor.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//        let itemSize: CGFloat = 100
//        let spacing: CGFloat = 2
//        layout.itemSize = CGSize(width: itemSize, height: itemSize)
//        layout.minimumInteritemSpacing = spacing
//        layout.scrollDirection = .horizontal
//
//        let itemCount = arrColor.count
//        let totalCellWidth = CGFloat(itemCount) * itemSize
//        let totalSpacingWidth = CGFloat(max(itemCount - 1, 0)) * spacing
//        let totalContentWidth = totalCellWidth + totalSpacingWidth
//
//        let collectionWidth = cvColor.bounds.width
//        let horizontalInset = max((collectionWidth - (totalContentWidth - 3)) / 2, 0)
//       // if arrColor.count == 1 {
//            layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
////        } else {
////            layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
////        }
//
//        layout.invalidateLayout()
//    }

    func sizeType(of size: String) -> String {
        let digitsSet = CharacterSet.decimalDigits
        
        if size.isEmpty {
            return "empty"
        } else if size.rangeOfCharacter(from: digitsSet.inverted) == nil {
            return "numeric"
        } else {
            return "letter"
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvSize {
            var preferredOrder:[String] = []

            let preferredOrder1: [String] = arrSize.compactMap { $0.size }
            if preferredOrder1.count != 0 {
                let sizevalue = sizeType(of: preferredOrder1[0])
                if sizevalue == "letter" {
                    preferredOrder = ["XS", "S", "M", "L", "XL", "XXL"]
                } else {
                    preferredOrder = ["28", "30", "32", "34", "36", "38"]

                }
            }
           

            sortedSizes = arrSize.sorted { a, b in
                  let sizeA = a.size ?? ""
                    let sizeB = b.size ?? ""

                    let numA = Int(sizeA)
                    let numB = Int(sizeB)

                    let isNumA = (numA != nil)
                    let isNumB = (numB != nil)

                    if isNumA && isNumB {
                        return (numA ?? Int.max) < (numB ?? Int.max)
                    }

                    if !isNumA && !isNumB {
                        let idxA = preferredOrder.firstIndex(of: sizeA) ?? Int.max
                        let idxB = preferredOrder.firstIndex(of: sizeB) ?? Int.max
                        if idxA == Int.max && idxB == Int.max {
                            return sizeA.localizedCompare(sizeB) == .orderedAscending
                        }
                        if idxA == Int.max { return false }
                        if idxB == Int.max { return true }
                        return idxA < idxB
                    }

                    return isNumA ? true : false
            }

            for item in sortedSizes {
                print(item.size ?? "nil")
            }

            return sortedSizes.count
        } else {
            return arrColor.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == cvSize {
            let cell = cvSize.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto", for: indexPath) as! LMcellcPhoto
            if selectedIndexPathPopular == indexPath {
                selectedIndexPathPopular = nil
                cell.viewCell.layer.backgroundColor = UIColor.black.cgColor
                cell.lblSize.textColor              = UIColor.white
            } else {
                cell.viewCell.layer.backgroundColor = UIColor.white.cgColor
                cell.lblSize.textColor              = UIColor.black

            }
            let obj = sortedSizes[indexPath.row]
            if obj.stock?.status == "OUT_OF_STOCK" {
                cell.viewCell.layer.backgroundColor = UIColor.lightText.cgColor
                cell.lblSize.text                  = obj.size
                cell.lblline.isHidden              = false
                cell.lblSize.textColor             = UIColor.lightGray
                lblNotify.isHidden                 = false

                let fullText = ""
                let notifyMeRange = (fullText as NSString).range(of: "Notify Me")

                let attributedString = NSMutableAttributedString(string: fullText)
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: notifyMeRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: notifyMeRange)
                attributedString.addAttribute(.link, value: "notifyme://tap", range: notifyMeRange)
                lblNotify.attributedText = attributedString
                lblNotify.textAlignment = .center
            } else {
                cell.lblline.isHidden              = true
                cell.lblSize.text                  = obj.size
                lblNotify.isHidden                 = true
            }
            cell.viewCell.layer.borderColor = UIColor.black.cgColor
            cell.viewCell.layer.borderWidth = 0.5
            cell.imgProduct.isHidden        = true
            cell.lblSize.isHidden           = false
            //cell.lblline.isHidden           = true
            THUserDefaultValue.isUserScrolling = false

            return cell

        } else {
            let cell = cvColor.dequeueReusableCell(withReuseIdentifier: "LMcellcPhoto", for: indexPath) as! LMcellcPhoto
            let obj = arrColor[indexPath.row]
            cell.imgProduct.isHidden = false
            cell.lblSize.isHidden    = true
            cell.imgProduct.sd_setImage(with: URL(string: obj.image ?? ""))
            cell.lblline.isHidden = true
            THUserDefaultValue.isUserScrolling = true

            return cell
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvColor {
            THUserDefaultValue.isUserScrolling = false
            let obj = arrColor[indexPath.row]
            selectedIndexPathcolorVarient       = nil
            selectedIndexPathcolorVarient       = indexPath
            onCollectionItemTag?(obj)
            
        } else {
            let obj = arrSize[indexPath.row]
            THUserDefaultValue.isUserSize    = false
            THUserDefaultValue.isUsercolorsize    = obj.size
            
            onCollectionItemcolorSize?(indexPath.row, arrSize)
            if obj.stock?.status != "OUT_OF_STOCK" {
                selectedIndexPathPopular    = nil
                selectedIndexPathPopular    = indexPath
                THUserDefaultValue.isUserScrolling = false

                cvSize.reloadData()
            }
           
        }
    }
   
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
extension LMProductHeader: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "notifyme://tap" {
            print("Notify Me tapped!")
//            let vc = NotifyMeViewController()
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.modalTransitionStyle = .crossDissolve
//                .present(vc, animated: true)
            // present your notify logic here
            return false
        }
        return true
    }
}
