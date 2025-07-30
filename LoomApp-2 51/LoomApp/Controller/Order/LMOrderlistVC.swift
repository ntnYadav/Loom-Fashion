//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit


class LMOrderlistVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var viewEmpty: UIView!
    
    @IBOutlet weak var tblOrderlist: UITableView!
    lazy fileprivate var viewmodel = LMOrderMV(hostController: self)

    
    var strClickAct: String = ""
    var arrcount: Int = 0
    let  arrCotegory = ["All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts","All", "Shirts", "T-shirts", "Jeans","Trouser", "Jacket","Sweaters","Swearshirt","Shorts"]
    var selectedCell = [IndexPath]()
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        tblOrderlist.delegate = self
        tblOrderlist.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        viewmodel.validateValue()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeRight.direction = .right

        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                break
            case .right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
   //        return self?.viewmodel.model.count

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewmodel.model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMorderCell", for: indexPath) as! LMorderCell
        cell.selectionStyle = .none
        let obj = self.viewmodel.model[indexPath.row]
        if let orderno = obj.orderNumber {
            cell.lblOrderNumber.text = "Order Number : \(orderno)"
        }
        let orderda = formatISODateToReadable(obj.orderDate!, timeZone: TimeZone(identifier: "Asia/Kolkata")!)
        //  - some : "2025-06-16T12:37:46.248Z"

        if let orderDate = orderda {
            cell.lblOrderDate.text = "Order Date : \(orderDate)"
        }
        if let itemStatus = obj.itemStatus {
            var valColor = ""
            if obj.itemStatus == "CONFIRMED" {
                valColor = "ORDER CONFIRMED"
            } else if obj.itemStatus == "SHIPPED" {
                valColor = "ORDER SHIPPED"
            } else if obj.itemStatus == "IN_TRANSIT" {
                valColor = "ORDER IN TRANSIT"
            } else if obj.itemStatus == "OUT_FOR_DELIVERY" {
                valColor = "ORDER IN OUT FOR DELIVERY"
            } else if obj.itemStatus == "CANCELLED" {
                valColor = "ORDER CANCELLED"
            } else if obj.itemStatus == "RETURN_REQUESTED" {
                valColor = "RETURN REQUESTED"
            } else if obj.itemStatus == "RETURN_REQUESTED" {
                valColor = "RETURN APPROVED"
            } else if obj.itemStatus == "RETURN_APPROVED" {
                valColor = "RETURN PICKUP SCHEDULED"
            } else if obj.itemStatus == "RETURN_PICKUP_SCHEDULED" {
                valColor = "RETURN PICKUP SCHEDULED"
            } else if obj.itemStatus == "RETURN_PICKED_UP" {
                valColor = "RETURN PICKED UP"
            } else {
                valColor = "ORDER DELIVERED"
            }
           
            cell.lblOrderStatus.text = valColor

            
        }
        if let productTitle = obj.productTitle {
            cell.lblProductName.text = "\(productTitle)"
        }
        let sizeText = obj.size ?? ""
        let colorText = obj.color ?? ""
        let quantityText = obj.quantity.map { "\($0)" } ?? "" // if quantity is Int?
        cell.lblSize.text = "\(sizeText) | \(colorText) | \(quantityText)"
        cell.imgProduxct.sd_setImage(with: URL(string:obj.productImage ?? keyName.emptyStr))
        return cell
    }
    func formatISODateToReadable(_ isoDateString: String, timeZone: TimeZone = .current) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoDateString) else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy, h:mm a"
        formatter.timeZone = timeZone

        return formatter.string(from: date)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewmodel.model[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMOrderDetaillistVC) as! LMOrderDetaillistVC
        secondVC.orderItemID = obj.itemId ?? ""
        self.navigationController?.pushViewController(secondVC, animated: true)

        }
    // MARK: - Action

    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actShopping(_ sender: Any) {
        
        let tabBarVC = LMTabBarVC()
        tabBarVC.selectedIndex = 2 // Change 2 to the tab index you want to open
        self.NavigationController(navigateFrom: self, navigateTo: tabBarVC, navigateToString: VcIdentifier.LMTabBarVC)
        
        //self.NavigationController(navigateFrom: self, navigateTo: LMTabBarVC(), navigateToString: VcIdentifier.LMTabBarVC)
    }
    
    @IBAction func actFilter(_ sender: Any) {
            self.NavigationController(navigateFrom: self, navigateTo: LMFilterVC(), navigateToString: VcIdentifier.LMFilterVC)
        }
    }

