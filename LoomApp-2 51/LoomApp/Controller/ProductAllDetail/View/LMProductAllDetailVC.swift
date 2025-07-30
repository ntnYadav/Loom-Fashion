//
//  ViewController.swift
//  DemoProject
//
//  Created by chetu on 02/04/25.
//

import UIKit
import AVKit

class LMProductAllDetailVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var viewTbl: UIView!
    @IBOutlet weak var tblProductdetail: UITableView!
        @IBOutlet weak var pageView: UIPageControl!
        @IBOutlet weak var collectionViewInnerPrductDetail: UICollectionView!
    
     var animatedConstraint: NSLayoutConstraint?
     var avatarHeightConstraint: NSLayoutConstraint?

     var previousContentOffsetY: CGFloat = 0
     let minConstraintConstant: CGFloat = 50
     let maxConstraintConstant: CGFloat = 600
    struct Section {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        init(name: String, items: [String], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
    var sections = [Section]()
    
    

        let searchBar = UISearchBar()
        var imgArr = [ "Search shirt",
                       "Search jeans",
                       "Search chinos",
                       "Search shorts",
                       "Search formal shirt",
                       "Search co-ord set",
                       "Search t-shirt"]
   
     
        @IBOutlet weak var page: UIPageControl!
       // @IBOutlet weak var pageview: UIPageControl!
        var timer = Timer()
        var counter = 0
       // let placeholderLabel = UILabel()
        override func viewDidLoad() {
        super.viewDidLoad()
            avatarHeightConstraint = tblProductdetail.heightAnchor.constraint(equalToConstant: maxConstraintConstant)
//            avatarHeightConstraint  = 100
            animatedConstraint = tblProductdetail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: maxConstraintConstant)

            sections = [
                Section(name: "DETAILS", items: ["MacBook"]),
                Section(name: "OFFERS", items: ["iPad Pro"]),
                Section(name: "REVIEWS", items: ["iPhone 6s"]),
                Section(name: "DEVLIVERYS", items: ["iPhone 6s"]),
                Section(name: "RETURNS", items: ["iPhone 6s"]),
                Section(name: "YOU MAY ALSO LIKE", items: ["iPhone 6s",])

            ]
            
            
            
            collectionViewInnerPrductDetail.delegate = self
            collectionViewInnerPrductDetail.dataSource = self
            tblProductdetail.register(UINib(nibName: "LMProductHeader", bundle: nil), forCellReuseIdentifier: "LMProductHeader")
            tblProductdetail.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
        }
    
    @objc func changeImage() {
    }
//         if counter < imgArr.count {
//             let index = IndexPath.init(item: counter, section: 0)
//             let nameImage = imgArr[counter]
//             self.collectionViewInnerPrductDetail.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//
////             searchBar.placeholder = ""
////             guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
////
////             placeholderLabel.text = "       \(nameImage)"
////             placeholderLabel.font = textField.font
////             placeholderLabel.textColor = .white
////             placeholderLabel.alpha = 0
////             placeholderLabel.frame = CGRect(x: 8, y: textField.bounds.height, width: textField.bounds.width, height: 20)
////             textField.addSubview(placeholderLabel)
//
//             // Animate from bottom to top
////             UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
////                 self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
////                 self.placeholderLabel.alpha = 1
////             }, completion: nil)
////             UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut], animations: {
////                 self.placeholderLabel.frame.origin.y = (textField.bounds.height - 20) / 2
////                 self.placeholderLabel.alpha = 1
////             }, completion: nil)
//             
//           //  counter += 1
//         } else {
//             counter = 0
//             let index = IndexPath.init(item: counter, section: 0)
//             self.collectionViewInnerPrductDetail.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
//             counter = 1
//         }
//     }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }

        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionViewInnerPrductDetail.dequeueReusableCell(withReuseIdentifier: "LMProductDetailCell", for: indexPath) as! LMProductDetailCell
         
           // cell.img.image = UIImage(named:"IMG7")!

            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Full height
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
    
extension LMProductAllDetailVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:  return ""
            default: return ""
        }
    }

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        // For section 1, the total count is items count plus the number of headers
        var count = sections.count
        
        for section in sections {
            count += section.items.count
        }
        
        return count
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        }
         
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        // Header has fixed height
        if row == 0 {
            return 50.0
        }
         var height = 200
         if indexPath.section == 1 {
             height = 500
         }
         print("indexPath.section--\(indexPath.section)")
         return CGFloat(sections[section].collapsed! ? 0 : height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
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
            if newConstraintConstant != avatarHeightConstraint!.constant {
                avatarHeightConstraint?.constant = currentConstraintConstant
            }
            
            previousContentOffsetY = scrollView.contentOffset.y
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tblProductdetail.dequeueReusableCell(withIdentifier: "LMProductHeader", for: indexPath) as! LMProductHeader
            cell.selectionStyle = .none

            return cell
        }
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell1
            cell.titleLabel.text = sections[section].name//  sections[section].name
            cell.selectionStyle = .none

            cell.toggleButton.tag = section
            
            cell.toggleButton.setTitle(sections[section].collapsed! ? "+" : "-", for: UIControl.State())
            cell.toggleButton.addTarget(self, action: #selector(LMProductAllDetailVC.toggleCollapse), for: .touchUpInside)
            return cell
        } else {
            
            if indexPath.section == 1 {
                let cell = tblProductdetail.dequeueReusableCell(withIdentifier: "LMwebViewCell", for: indexPath) as! LMwebViewCell
                cell.selectionStyle = .none

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?
                cell?.textLabel?.text = sections[section].items[row - 1]

                return cell!
            }
        }
    }
    
    //
    // MARK: - Event Handlers
    //
    @objc func toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed!
        
        let indices = getHeaderIndices()
        
        let start = indices[section]
        let end = start + sections[section].items.count
        
        tblProductdetail.beginUpdates()
        for i in start ..< end + 1 {
            tblProductdetail.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
        }
        
        tblProductdetail.endUpdates()
    }
    
    //
    // MARK: - Helper Functions
    //
    func getSectionIndex(_ row: NSInteger) -> Int {
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    func getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        
        return index
    }
    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        for section in sections {
            indices.append(index)
            index += section.items.count + 1
        }
        
        return indices
    }
  
    
}


