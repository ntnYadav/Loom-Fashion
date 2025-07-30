//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMOrderMV : NSObject{
    
    private var hostVC : LMOrderlistVC
    init(hostController : LMOrderlistVC) {
        self.hostVC = hostController
    }
    var model : [Order1] = []

    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else {
            return
        }
        getOrderApi()
    }
    
    func validateDetailValue(){
        guard hostVC.checkInternet else {
            return
        }
        getOrderListApi()
    }
    
    private  func getOrderApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: OrderResponselisting.self,page:"1",limit: "20",subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                
                    if let data = dataResponse?.data {
                        self?.model = data
                        if self?.model.count != 0{
                            self?.hostVC.viewEmpty.isHidden = true
                        } else{
                            self?.hostVC.viewEmpty.isHidden = false
                        }
                            
                        DispatchQueue.main.async {
                            self?.hostVC.tblOrderlist.reloadData()
                        }
                    }
                } else {
                    self?.hostVC.viewEmpty.isHidden = false
                }
          }
    }
    
    private  func getOrderListApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: OrderResponselisting.self,page:"1",limit: "20",subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.model = (dataResponse?.data)!
                    DispatchQueue.main.async {
                        self?.hostVC.tblOrderlist.reloadData()
                    }
                }
          }
    }

}
