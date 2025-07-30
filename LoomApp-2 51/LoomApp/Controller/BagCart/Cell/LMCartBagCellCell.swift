//
//  MainCell.swift
//  expandableCellDemo
//
//  Created by Flucent tech on 07/04/25.
//

import UIKit

class LMCartBagCellCell :UITableViewCell {
    @IBOutlet weak var lblProductDetail: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var viewCell: UIView!
    var productQty: Int = 0
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnQtylisting: UIButton!
    @IBOutlet weak var btnMovetoList: UIButton!
    // Note: must be strong
    @IBOutlet weak var btndelete: UIButton!
    @IBOutlet weak var btnImagClick: UIButton!
    var onCollectionItemupdateQty: ((_ index: Int, _ qty: Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    @IBAction func actQty(_ sender: Any) {
        let tag = ((sender as AnyObject).tag)!
//          let objModel = viewmodel.modelproduct?.items[tag]
          
        if productQty <= 5 {
              let input = (productQty)
              let arr = (1...input).map { "\($0)" }
              RPicker.selectOption(dataArray: arr) {[weak self] (selctedText, atIndex) in
                  self?.lblSize.text = "QTY | \(atIndex + 1)"
                  self?.onCollectionItemupdateQty?(tag, atIndex + 1)

              }
          } else {
              RPicker.selectOption(dataArray: THconstant.arrqty) {[weak self] (selctedText, atIndex) in
                  self?.lblSize.text = "QTY | \(atIndex + 1)"
                      self?.onCollectionItemupdateQty?(tag, atIndex + 1)
                  // TODO: Your implementation for selection
              }
          }
        
    }
    @IBAction func actDelete(_ sender: Any) {
    }
}



/*
 {"success":true,"message":"Cart item updated successfully","data":{"cart":{"cart":{"userId":"682a3e1bba29b6c2c7e851c0","items":[{"productId":"684ab9012ab52489ce9754f0","variantId":"684ab9792ab52489ce97554e","quantity":2,"priceSnapshot":{"basePrice":1499,"sellingPrice":1274.15,"source":"subcategory"},"inventoryStatus":"IN_STOCK","avl_var_qnty":10,"remindersSent":0,"recoveryEmailsSent":0,"couponUsed":false,"lastCheckedAt":"2025-06-26T13:29:35.966Z","_id":"685d44eee82ec113ce1bde27","shippingOptions":[],"addedAt":"2025-06-26T13:02:38.189Z"}],"couponDiscount":0,"abandoned":false,"lastActiveAt":"2025-05-20T11:33:26.479Z","createdAt":"2025-05-20T11:33:26.487Z","updatedAt":"2025-06-26T13:29:35.967Z","id":"682c6886b353718810b1a6ea"},"fallbackUsed":false,"message":"Cart updated successfully."}}}

 */
