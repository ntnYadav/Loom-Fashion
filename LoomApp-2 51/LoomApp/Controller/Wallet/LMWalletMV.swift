//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift
import Alamofire



class LMWalletMV : NSObject{
    var filenameArray = [String]()
    var image: UIImage = UIImage()
    var compressDataToUpload = [Data]()
    var modelReviewlist: [Review] = []
    var customerImages: [String] = []
    
    var modelBanner : [Banner?]?
    var modelproduct : ProductData?
    var model : WalletPointsData?
    
    var model12 : [WalletPointsData] = []
    
    private var hostVC : LMWalletVC
    init(hostController : LMWalletVC) {
        self.hostVC = hostController
    }
    
 
    var model9: WalletPointsData?

    func validateValueWallet() {
        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: WalletPointsResponse.self,page:"1",limit: "50",subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                if let data = dataResponse {
                    
                    let newItem = WalletPointsHistory(
                            type: "points",
                            points: 20,
                            orderId: "123456",
                            txnType: "earn",
                            description: "Bonus points",
                            createdAt: "2025-07-11T10:00:00.000Z"
                        )
                    let newItem1 = WalletPointsHistory(
                            type: "points",
                            points: 20,
                            orderId: "123456",
                            txnType: "earn",
                            description: "Bonus points",
                            createdAt: "2025-07-11T10:00:00.000Z"
                        )
                    let newItem2 = WalletPointsHistory(
                            type: "points",
                            points: 20,
                            orderId: "123456",
                            txnType: "earn",
                            description: "Bonus points",
                            createdAt: "2025-07-11T10:00:00.000Z"
                        )
                    self?.model = data.data // ✅ This matches WalletPointsData type
                    
                    if self?.model?.history?.count != 0 {
                        if var history = self?.model?.history {
                            history.insert(newItem, at: 0)
                            history.insert(newItem1, at: 1) // Inserted before newItem
                            self?.model?.history = history
                        }
                    } else {
                        if var history = self?.model?.history {
                            history.insert(newItem, at: 0)
                            history.insert(newItem1, at: 1) // Inserted before newItem
                            history.insert(newItem2, at: 2) // Inserted before newItem
                            self?.model?.history = history
                        }
                    }
                                            //self?.hostVC.viewEmpty.isHidden = true
//                                        } else{
//                                            //self?.hostVC.viewEmpty.isHidden = false
//                                        }
                
                                        DispatchQueue.main.async {
                                            self?.hostVC.tblWallet.reloadData()
                                        }
                                    }
                                } else {
                                    //self?.hostVC.viewEmpty.isHidden = false
                                }
            }
        }
    
  

    }

