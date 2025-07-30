//
//  LMProductDetailVC.swift
//  LoomApp
//
//  Created by Flucent tech on 07/04/25.
//
import UIKit


class LMOrderDetaillistVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tblOrderlist: UITableView!
    lazy fileprivate var viewmodel = LMOrderListMV(hostController: self)
    private var isUISetupDone = false
    var dateFormate :String = ""
    var otherStatusTime :String = ""
    var date7day :String = ""

    var orderItemID: String = ""
    var arrCotegory = ["order", "shipping"]
    var selectedCell = [IndexPath]()
    var timer = Timer()
    var counter = 0
    let listOfUsedItemStatus: [String] = [
        "CONFIRMED", "CANCELLED", "SHIPPED", "IN_TRANSIT", "OUT_FOR_DELIVERY",
        "DELIVERED", "RETURN_REQUESTED", "RETURN_APPROVED", "RETURN_PICKUP_SCHEDULED", "RETURN_PICKED_UP"
    ]
    override func viewDidLoad() {
        tblOrderlist.delegate = self
        tblOrderlist.dataSource = self
        
        tblOrderlist.register(UINib(nibName: "priceSubCategoryDetailTableCell1", bundle: nil), forCellReuseIdentifier: "priceSubCategoryDetailTableCell1")
        tblOrderlist.register(LMOrderStatusCell.self, forCellReuseIdentifier: "LMOrderStatusCell")

        viewmodel.validateDetailValue(itemIDDetail: orderItemID)

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
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let objCount = arrCotegory[indexPath.row]
            if objCount == "order" {
                return 230
            } else if objCount == "shipping"{
                return 180
            } else if objCount == "OtherDetail" {
                return 40
            } else if objCount == "Track" {
                return 40
            } else if objCount == "TrackDetail" {
                let obj = viewmodel.model
                if  obj?.itemStatus  == "CANCELLED"{
                    return 150
                }
                return 200
            } else if objCount == "Price" {
                return 500
            } else if objCount == "Copyright" {
                return 100
            } else {
                return 120
            }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCotegory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = viewmodel.model
        let objCount = arrCotegory[indexPath.row]
        if objCount == "order" {
            let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMorderlistCell", for: indexPath) as! LMorderlistCell
            cell.selectionStyle = .none
            cell.lblOrderNumber.text = "ORDER NUMBER : \(obj?.orderNumber ?? "")"
           // cell.lblProductName.text = "\("ngjnergjnejrngjejrngj" ?? "")"
            
            if let productTitle = obj?.productTitle {
                cell.lblProductName.text = "\(productTitle)"
            }
            cell.lblPrice.text       = "\(keyName.rupessymbol) " + "\(obj?.priceSnapshot?.sellingPrice ?? 0)"

            let sizeText  = obj?.size ?? ""
            let colorText = obj?.color ?? ""
            let qty       = "\(obj?.quantity ?? 0)"
            //let quantityText = qty.map { "\($0)" }  // if quantity is Int?
            cell.lblSize.text = "\(sizeText) | \(colorText) | \(qty)"
            cell.imgProduxct.sd_setImage(with: URL(string:obj?.productImage ?? keyName.emptyStr))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            cell.imgProduxct.isUserInteractionEnabled = true
            cell.imgProduxct.addGestureRecognizer(tapGesture)
            
            
            if let colo = obj?.itemStatus {
                
                var valColor = ""
                if obj?.itemStatus == "CONFIRMED" {
                    valColor = "CONFIRMED"
                    
                    cell.lblDate.text = "Your order is confirmed. We ship our orders within 24 hours"

                } else if obj?.itemStatus == "SHIPPED" {
                    valColor = "SHIPPED"
                    let statusIt = obj?.itemStatus
                    if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                       let _ = confirmedDetail.timestamp {
                        var orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                        if let orderda = orderda {
                            let message = createAttributedStatusMessage(mainText: "Your order has shipped on ", highlightedText: orderda)
                            cell.lblDate.attributedText = message
                        }
                        //cell.lblDate.text        = "Your order has shipped on " + "\(orderda)"
                    }

                } else if obj?.itemStatus == "IN_TRANSIT" {
                    valColor = "IN TRANSIT"
                    let statusIt = obj?.itemStatus
                    if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                       let _ = confirmedDetail.timestamp {
                        let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                        
                        if let orderda = orderda {
                            let message = createAttributedStatusMessage(mainText: "Your order is in transit ", highlightedText: orderda)
                            cell.lblDate.attributedText = message
                        }
                        //cell.lblDate.text        = "Your order is in transit " + "\(orderda)"
                    }

                    
                } else if obj?.itemStatus == "OUT_FOR_DELIVERY" {
                    valColor = "IN OUT FOR DELIVERY"
                    cell.lblDate.text = "Your order will arrive soon!"

                } else if obj?.itemStatus == "CANCELLED" {
                    let statusIt = obj?.itemStatus
                    if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                       let _ = confirmedDetail.timestamp {
                        let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                        if let orderda = orderda {
                            let message = createAttributedStatusMessage(mainText: "Your order was cancelled on ", highlightedText: orderda)
                            cell.lblDate.attributedText = message
                        }
                       // cell.lblDate.text        = "Your order was cancelled on " + "\(orderda)"

                       
                    }
                    valColor = "CANCELLED"

                } else {
                    let statusIt = obj?.itemStatus
                    if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                       let _ = confirmedDetail.timestamp {
                        let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                        if let orderda = orderda {
                            let message = createAttributedStatusMessage(mainText: "Your order has been delivered on " , highlightedText: orderda)
                            cell.lblDate.attributedText = message
                        }
                      //  cell.lblDate.text        = "Your order has been delivered on " + "\(orderda)"

                       
                    }
                    

                    valColor = "DELIVERED"

                }
              
                
                let fullText = "STATUS : ORDER \(valColor.uppercased())"
                let attrStri = NSMutableAttributedString(string: fullText)
                let ORDER = " ORDER" + valColor
                if let range = fullText.range(of: ORDER, options: .caseInsensitive) {
                    let nsRange = NSRange(range, in: fullText)
                    attrStri.addAttributes([
                        .foregroundColor: UIColor.orange,
                        .font: UIFont(name: ConstantFontSize.Bold, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
                    ], range: nsRange)
                }

                cell.lblOrderStatus.attributedText = attrStri
            }
            return cell
        } else if objCount == "shipping"{
            let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMorderShippingCell", for: indexPath) as! LMorderShippingCell
            cell.selectionStyle = .none

            cell.lblTitle.font        = UIFont(name: ConstantFontSize.Bold, size: 16)
            cell.lblName.text         = obj?.shippingAddress?.name
            cell.lblHouseAddress.text = (obj?.shippingAddress?.houseNumber ?? "") + " " + (obj?.shippingAddress?.area ?? "")
            //cell.lblCity.text        = (obj?.shippingAddress.city ?? "") + " " + (obj?.shippingAddress.state ?? "") + " " + "\(obj?.shippingAddress.country ?? "")"
            cell.lblPhoneNo.text     = "Phone Number - " + (obj?.shippingAddress?.mobile ?? "")
            return cell
        } else if objCount == "OtherDetail" {
        let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMOtherOrderHeaderCell", for: indexPath) as! LMOtherOrderHeaderCell
            cell.selectionStyle = .none

        return cell
        
            
        } else if objCount == "Track" {
            let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMOtherOrderHeaderCell", for: indexPath) as! LMOtherOrderHeaderCell
            cell.selectionStyle = .none

            cell.lblHeadertile.text = "TRACK ORDER"
            cell.lblHeadertile.font = UIFont(name: ConstantFontSize.Bold, size: 16)
            cell.lblHeadertile.textAlignment = .center
            return cell
            
        } else if objCount == "TrackDetail" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LMOrderStatusCell", for: indexPath) as? LMOrderStatusCell else {
                       return UITableViewCell()
                   }
            cell.selectionStyle = .none
            
            
            
            if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == "CONFIRMED" }),
               let _ = confirmedDetail.timestamp {
                let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                let status = confirmedDetail.status ?? ""
                dateFormate = orderda ?? ""
            }
        
                let statusIt = obj?.itemStatus
                if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                   let _ = confirmedDetail.timestamp {
                    let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
                    let status = confirmedDetail.status ?? ""
                    otherStatusTime = orderda ?? ""
                }
            
//            if let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
//               let _ = confirmedDetail.timestamp {
//                let orderda = formatISODateToReadable(confirmedDetail.timestamp ?? "", timeZone: TimeZone(identifier: "Asia/Kolkata")!)
//                let status = confirmedDetail.status ?? ""
//                dateFormate = orderda ?? ""
//            }\
            
            if obj?.itemStatus == "CANCELLED" {
                cell.actionButton.isHidden = true
            } else {
                cell.actionButton.isHidden = false
                cell.actionButton.addTarget(self, action: #selector(toggleDefault), for: .touchUpInside)
            }
            
             cell.itemStatus = obj?.itemStatus
             cell.createSteps(count: 2, strItem: obj?.itemStatus ?? "", dateFormate: dateFormate, otherStatusTime: otherStatusTime)

            cell.animateToStep(2)
            cell.setupActionButton()
            cell.itemStatusTimestamps = obj?.itemStatusTimestamps

            // Re-run animation when the cell appears
            
            return cell

        } else if objCount == "Price" {
        let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "priceSubCategoryDetailTableCell1", for: indexPath) as! priceSubCategoryDetailTableCell1
            cell.selectionStyle = .none

            let mrp = String(format: "%.0f", obj?.priceSnapshot?.mrp ?? 0)
            cell.lblMRPPrice.text             =  keyName.rupessymbol + " \(mrp)"
            
            let dicountvaluetemp = String(format: "%.0f", obj?.priceSnapshot?.sellingPrice ?? 0)
            cell.lblSellingPrice.text         =  keyName.rupessymbol + " \(dicountvaluetemp)"
            
            let discountAmount = String(format: "%.0f", obj?.priceSnapshot?.discountAmount ?? 0)
            cell.lblProductDiscountPrice.text = "- " + keyName.rupessymbol + " \(discountAmount)"
            
            
            let couponDiscount = String(format: "%.0f", obj?.priceSnapshot?.couponDiscount ?? 0)
            cell.lblCouponDiscountprice.text  = "- " + keyName.rupessymbol + " \(couponDiscount)"
            
            let deliveryCharge = String(format: "%.0f", obj?.priceSnapshot?.deliveryCharge ?? 0)
            cell.lblCODPrice.text             = "+ " + keyName.rupessymbol + " \(deliveryCharge)"
            
            let totalAmount = String(format: "%.0f", obj?.priceSnapshot?.totalAmount ?? 0)
            cell.lblGrandTotalPrice.text      = keyName.rupessymbol + " \(totalAmount)"
            
            cell.lblYoumayLIke.isHidden       = true
            cell.btnDelete.layer.borderColor = UIColor.lightGray.cgColor
            cell.btnDelete.layer.borderWidth = 1
            
            cell.btnReturn.layer.borderColor = UIColor.lightGray.cgColor
            cell.btnReturn.layer.borderWidth = 1
            
            if obj?.itemStatus == keyName.CANCELLED  {
                cell.btnDelete.isHidden = true
                cell.btnReturn.isHidden = true
                cell.lblReturn.isHidden = true

            } else if obj?.itemStatus == keyName.DELIVERED {
                
                
                let statusIt = obj?.itemStatus
                if let statusIt = obj?.itemStatus,
                   let confirmedDetail = obj?.itemStatusTimestamps?.first(where: { $0.status == statusIt }),
                   let timestamp = confirmedDetail.timestamp {

                    // Parse the ISO date string
                    let isoFormatter = ISO8601DateFormatter()
                    isoFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")

                    if let date = isoFormatter.date(from: timestamp) {
                        // Add 7 days
                        let futureDate = Calendar.current.date(byAdding: .day, value: 7, to: date)

                        // Format the new date
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd MMM yyyy, h:mm a"
                        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")

                        if let futureDate = futureDate {
                            let readableDate = formatter.string(from: futureDate)
                            date7day = readableDate
                        }
                    }
                }

                
                
                cell.btnDelete.isHidden = false
                cell.btnDelete.setTitle("RATE & REVIEW", for: .normal)
                cell.btnDelete.titleLabel?.textColor = .black
                cell.btnReturn.isHidden = false
                cell.lblReturn.isHidden = false
                cell.lblReturn.text = "Return policy valid till \(date7day)"

            } else if obj?.itemStatus == "CONFIRMED" {
                cell.btnDelete.isHidden = false
                cell.btnReturn.isHidden = true
                cell.lblReturn.isHidden = true


            }

            //if obj?.itemStatus == keyName.CANCELLED {
            //}
            cell.btnReturn.addTarget(self, action: #selector(returnExchange), for: .touchUpInside)

            cell.btnDelete.addTarget(self, action: #selector(cancelOrder), for: .touchUpInside)

        return cell
            
            
        } else if objCount == "Copyright" {
            let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMorderFotterlistCell", for: indexPath) as! LMorderFotterlistCell
            cell.selectionStyle = .none

            return cell
        } else {
            let cell = tblOrderlist.dequeueReusableCell(withIdentifier: "LMOtherOrderCell", for: indexPath) as! LMOtherOrderCell
            cell.selectionStyle = .none

            let obj = viewmodel.model?.otherItems?[indexPath.row - 3]
            cell.lbldot.layer.cornerRadius = cell.lbldot.frame.size.width / 2
            cell.lbldot.clipsToBounds = true
            cell.lblProductTitle.text = obj?.productTitle
            cell.imgProduct.sd_setImage(with: URL(string:obj?.productImage ?? keyName.emptyStr))
            if let lastStatus = obj?.itemStatusTimestamps?.last {
                cell.lblDelivery.text = LMGlobal.shared.formatDateString(lastStatus.timestamp ?? "")
            }
            if let colo = obj?.itemStatus {
                
                var formattedOtherItemStatus = ""
                
                // Case 1: itemStatus is in the list
                if let itemStatus = obj?.itemStatus, listOfUsedItemStatus.contains(colo) {
                    formattedOtherItemStatus = "ORDER "+itemStatus.replacingOccurrences(of: "_", with: " ")
                } else {
                    // Case 2: Reverse search in timestamps
                    if let timestamps = obj?.itemStatusTimestamps {
                        for status in listOfUsedItemStatus.reversed() {
                            if timestamps.contains(where: { $0.status == status }) {
                                formattedOtherItemStatus = "ORDER "+status.replacingOccurrences(of: "_", with: " ")
                                break
                            }
                        }
                    }
                }
                
                
                
                
                
                let fullText = "STATUS : \(colo.uppercased())"
                let attrStri = NSMutableAttributedString(string: fullText)
                let ORDER  = "ORDER " + colo

                if let range = fullText.range(of: ORDER, options: .caseInsensitive) {
                    let nsRange = NSRange(range, in: fullText)
                    attrStri.addAttributes([
                        .foregroundColor: UIColor.orange,
                        .font: UIFont(name: ConstantFontSize.Bold, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
                    ], range: nsRange)
                }
                cell.lblDetail.attributedText = attrStri
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                cell.imgProduct.isUserInteractionEnabled = true
                cell.imgProduct.addGestureRecognizer(tapGesture)
                
            }
            return cell
        }
    }
    
    func createAttributedStatusMessage(mainText: String, highlightedText: String) -> NSAttributedString {
        let fullText = "\(mainText) \(highlightedText)"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Style for mainText
        let mainRange = (fullText as NSString).range(of: mainText)
        attributedString.addAttributes([
            .font: UIFont(name: ConstantFontSize.regular, size: 13)
        ], range: mainRange)

        // Style for highlightedText
        let highlightRange = (fullText as NSString).range(of: highlightedText)
        attributedString.addAttributes([
            .font: UIFont(name: ConstantFontSize.Bold, size: 13)
        ], range: highlightRange)

        return attributedString
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
    // MARK: - Action
    @objc func handleTapDetail() {
          print("View tapped!")
        let obj = viewmodel.model?.otherItems
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMOrderDetaillistVC) as! LMOrderDetaillistVC
        //secondVC.orderItemID = obj?.otherItems. ?? ""
        self.navigationController?.pushViewController(secondVC, animated: true)
      }
    
    @objc func handleTap() {
          print("View tapped!")
        let obj = viewmodel.model

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMProductDetVC) as! LMProductDetVC
        secondVC.productId        = obj?.productId ?? keyName.emptyStr
        secondVC.defaultVaniantID = obj?.variantId ?? keyName.emptyStr
        self.navigationController?.pushViewController(secondVC, animated: true)
      }
    
    
    @objc private func returnExchange() {
       // let obj = viewmodel.model
        //  let obj = viewmodel.model
//        self.NavigationController(navigateFrom: self, navigateTo: returnOrderVC(), navigateToString: VcIdentifier.returnOrderVC)
        let obj = viewmodel.model
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.returnOrderVC) as! returnOrderVC
        secondVC.modelObj         = viewmodel.model
        secondVC.productId        = obj?.productId ?? keyName.emptyStr
        secondVC.defaultVaniantID = obj?.variantId ?? keyName.emptyStr
        self.navigationController?.pushViewController(secondVC, animated: true)

    }
    @objc private func cancelOrder() {
        let obj = viewmodel.model
      //  let obj = viewmodel.model
       
        if obj?.itemStatus == keyName.CANCELLED  {
           
        } else if obj?.itemStatus == keyName.DELIVERED {
            let obj = viewmodel.model
            let vc = ReviewViewController()
            vc.imgURL      = obj?.productImage ?? ""
            vc.productName = obj?.productTitle ?? ""
            vc.productId   = obj?.productId ?? ""
            vc.variantId   = obj?.variantId ?? ""
            vc.orderId     = obj?.orderId ?? ""
            vc.orderItemId = obj?.itemId ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if obj?.itemStatus == "CONFIRMED" {
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let deleteSheet = storyboard.instantiateViewController(withIdentifier: "cancelOrderVc") as? cancelOrderVc else {
                return
            }

            deleteSheet.onApplyTapped = { [weak self] indevalue, sizeArr in
                print("Selected: \(indevalue), \(sizeArr)")
                self?.isUISetupDone = true
                let obj = self?.viewmodel.model
                self?.viewmodel.deleteOrder(orderId:(obj?.orderId)!,itemId:(obj?.itemId)!,reason:indevalue ?? "")
                self?.viewmodel.model?.itemStatus = keyName.CANCELLED
                self?.tblOrderlist.reloadData()
            }

            deleteSheet.modalPresentationStyle = .overFullScreen
            deleteSheet.modalTransitionStyle = .coverVertical

            if self.presentedViewController == nil && self.view.window != nil {
                self.present(deleteSheet, animated: true)
            }
            
            
            
//
//            RPicker.selectOption(dataArray: THconstant.arrListDelete) {[weak self] (selctedText, atIndex) in
//                // TODO: Your implementation for selection
//
//
//
//
            }
        }
       
    
    @objc private func toggleDefault() {
        //            'PENDING', 'CONFIRMED', 'SHIPPED', 'IN_TRANSIT', 'OUT_FOR_DELIVERY',
        //                'DELIVERED', 'CANCELLED', 'EXPIRED',
        //                'RETURN_REQUESTED', 'RETURN_APPROVED', 'RETURN_IN_TRANSIT', 'RETURN_RECEIVED',
        //                'REFUND_INITIATED', 'REFUND_COMPLETED',
        //                'REPLACEMENT_REQUESTED', 'REPLACEMENT_DISPATCHED', 'REPLACEMENT_DELIVERED'
        
        
        
        let secondVC = LMOrderStatusVC()
        let obj = viewmodel.model
        if obj?.itemStatus == "CONFIRMED" {
            secondVC.strInt = 1
        } else if obj?.itemStatus == "SHIPPED" {
            secondVC.strInt = 2
        } else if obj?.itemStatus == "IN_TRANSIT" {
            secondVC.strInt = 3
        } else if obj?.itemStatus == "OUT_FOR_DELIVERY" {
            secondVC.strInt = 4
        } else if obj?.itemStatus == "DELIVERED" {
            secondVC.strInt = 5
        } else if obj?.itemStatus == "RETURN_REQUESTED" {
           secondVC.strInt = 6
       } else if obj?.itemStatus == "RETURN_APPROVED" {
           secondVC.strInt = 7
      } else if obj?.itemStatus == "RETURN_PICKUP_SCHEDULED" {
          secondVC.strInt = 8
      } else if obj?.itemStatus == "RETURN_PICKED_UP" {
          secondVC.strInt = 9
       }
        
        
        
        
        
        
        
        
        secondVC.itemStatusTimestamps = obj?.itemStatusTimestamps
        navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actFilter(_ sender: Any) {
            self.NavigationController(navigateFrom: self, navigateTo: LMFilterVC(), navigateToString: VcIdentifier.LMFilterVC)
        }
    }

