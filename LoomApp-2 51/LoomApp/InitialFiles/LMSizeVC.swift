
import UIKit

class LMSizeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var onKeepTapped: ((_ index1:Int,_ vaiantId:String) -> Void)?
    var indeId :Int = 0
    //var arrSize: [String] = []
    var arrSize: [VariantSize9]? = []
    var sortedSizes:[VariantSize9] = []

    
    private let sizes = ["28", "30", "32", "34", "36", "38"]
    private var selectedIndex: Int? = nil
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
           setupTapToDismissOutsideCollection()
           setupCollectionView()
        
    }
    private func setupTapToDismissOutsideCollection() {
        let tapView = UIView()
        tapView.backgroundColor = .clear
        tapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tapView)

        NSLayoutConstraint.activate([
            tapView.topAnchor.constraint(equalTo: view.topAnchor),
            tapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300) // height of bottom sheet
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        tapView.addGestureRecognizer(tap)
    }

    @objc private func dismissSheet() {
        dismiss(animated: true) {
            
        }
    }
    private func setupCollectionView() {
        let sheetView = UIView()
        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 0
        sheetView.clipsToBounds = true
        view.addSubview(sheetView)
        
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sheetView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let topLabel = UILabel()
        topLabel.text = "Select Size"
        topLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        topLabel.textAlignment = .center
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(topLabel)
        
        sheetView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 16),
            topLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 16),
            topLabel.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -16),
            topLabel.heightAnchor.constraint(equalToConstant: 28),
            
            collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor),
        ])
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var preferredOrder:[String] = []

        let preferredOrder1: [String] = (arrSize?.compactMap { $0.size })!
            if preferredOrder1.count != 0 {
                let sizevalue = sizeType(of: preferredOrder1[0])
                if sizevalue == "letter" {
                    preferredOrder = ["XS", "S", "M", "L", "XL", "XXL"]
                } else {
                    preferredOrder = ["28", "30", "32", "34", "36", "38"]

                }
            }
           

        sortedSizes = (arrSize?.sorted { a, b in
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
        })!

            for item in sortedSizes {
                print(item.size ?? "nil")
            }

            return sortedSizes.count
        
        
        
        
       // return arrSize?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Remove old subviews
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let label = UILabel()
        let objModel = sortedSizes[indexPath.row]
        
        
        if objModel.stock?.status != "OUT_OF_STOCK" {
            label.text = objModel.size
            
           // label.attributedText = objModel.size?.strikeThrough()

        } else {
            let title = objModel.size ?? ""
            let attributedPriceText = createPriceAttributedText(
                            originalPrice: title
            )
            label.attributedText = attributedPriceText
        }
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Style selected cell
        if indexPath.row == selectedIndex {
            cell.contentView.backgroundColor = UIColor.systemBlue
            label.textColor = .white
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
        } else {
            cell.contentView.backgroundColor = UIColor.clear
            label.textColor = .black
            cell.layer.cornerRadius = 0
        }
        
        cell.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
        ])
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        
//        // Remove old subviews
//        for subview in cell.contentView.subviews {
//            subview.removeFromSuperview()
//        }
//        
//        let label = UILabel()
//        label.text = "obj?.siz"
//
////        let obj = arrSize?[indexPath.row]
////        if obj?.stock?.status != "OUT_OF_STOCK" {
////            label.text = "obj?.siz"
////            //label.attributedText = nil  // clear attributed text just in case
//            label.textColor = .black
////            label.font = UIFont.systemFont(ofSize: 16)
////        } else {
////            let title = obj?.size ?? ""
//            
////            let attributedPriceText = createPriceAttributedText(
////                originalPrice: title
////            )
////            label.attributedText = attributedPriceText
////            label.text = "obj?.size"
//
////            label.textColor = .black
//
//            //
//            //                let attributeString = NSMutableAttributedString(string: title, attributes: [
//            //                    .foregroundColor: UIColor.black,
//            //                    .font: UIFont(name: ConstantFontSize.Bold, size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
//            //                ])
//            //                label.attributedText = attributeString
//            //            }
//            
//            // label.text = sizes[indexPath.item]
////            label.textAlignment = .center
////            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
////            label.translatesAutoresizingMaskIntoConstraints = false
//            
//            
//            // Style selected cell
////            if indexPath.item == selectedIndex {
////                cell.contentView.backgroundColor = UIColor.clear
////                label.textColor = .white
////                cell.layer.cornerRadius = 8
////                cell.layer.masksToBounds = true
////            } else {
////                cell.contentView.backgroundColor = UIColor.clear
////                label.textColor = .black
////                cell.layer.cornerRadius = 0
////            }
//            
//            cell.contentView.addSubview(label)
//            NSLayoutConstraint.activate([
//                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
//                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//            ])
//            
//    
//        return cell
//
//    }
        // MARK: - UICollectionView Delegate FlowLayout
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width / 2
            return CGSize(width: width, height: 60)
        }
        
        // MARK: - UICollectionView Delegate
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedIndex = indexPath.row
            collectionView.reloadData()
            let objModel = arrSize?[indexPath.row]
            print("objModel==\(objModel)=======\(arrSize?[indexPath.row])")
            if objModel?.stock?.status != "OUT_OF_STOCK" {
                self.onKeepTapped?(indeId, objModel?.variantId ?? "")
            } else {
            }
            
            dismiss(animated: true) {
                
            }
        }
        func createPriceAttributedText(originalPrice: String) -> NSAttributedString {
            let attributedText = NSMutableAttributedString()
           
            // Original price with strikethrough
            let originalPriceString = "\(originalPrice) "
            let originalPriceAttributes: [NSAttributedString.Key: Any] = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.gray,
                .font: UIFont(name: ConstantFontSize.regular, size: 14)
            ]
            attributedText.append(NSAttributedString(string: originalPriceString, attributes: originalPriceAttributes))
            
            // Discounted price
           
            
            return attributedText
        }
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
    }
    

