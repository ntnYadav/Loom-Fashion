//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMOrderListMV : NSObject{
    
    private var hostVC : LMOrderDetaillistVC
    init(hostController : LMOrderDetaillistVC) {
        self.hostVC = hostController
    }
    
    var model:OrderItemData?
    // MARK: validate value

    func validateDetailValue(itemIDDetail:String){
        guard hostVC.checkInternet else {
            return
        }
        getOrderListApi(itemId: itemIDDetail)
    }
    func deleteOrder(orderId:String,itemId:String,reason:String){
        guard hostVC.checkInternet else {
            return
        }
        getOrderCancelApi(orderId:orderId,itemId:itemId,reason:reason)
    }
    private  func getOrderCancelApi(orderId:String,itemId:String,reason:String) {
      GlobalLoader.shared.show()
        let bodyRequest = CancelOrderItemRequest(orderId: orderId, itemId: itemId, reason: reason)
      THApiHandler.post(requestBody: bodyRequest, responseType: OrderItemCancelResponse.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
          GlobalLoader.shared.hide()
          if let status = dataResponse?.success {
             
              AlertManager.showAlert(on: self!.hostVC,
                                     title: "Success",
                                     message: dataResponse?.message ?? "") {
              }
          } else {
              self?.hostVC.showToastView(message: msg)
          }
      }
  }
    
    private  func getOrderListApi(itemId:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: OrderItemDetailResponse.self,subcategoryId: itemId) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.model = (dataResponse?.data)!
                    
                    let arrOther = self?.model?.otherItems?.count
                    if self?.model?.otherItems?.count != 0 {
                        self?.hostVC.arrCotegory.append("OtherDetail")

                        for var i in 0..<(self?.model?.otherItems?.count ?? 0) {
                            self?.hostVC.arrCotegory.append("\(i)")
                        }

                        self?.hostVC.arrCotegory.append("Track")
                        self?.hostVC.arrCotegory.append("TrackDetail")
                        self?.hostVC.arrCotegory.append("Price")
                        self?.hostVC.arrCotegory.append("Copyright")

                    } else {
                        self?.hostVC.arrCotegory.append("Track")
                        self?.hostVC.arrCotegory.append("TrackDetail")
                        self?.hostVC.arrCotegory.append("Price")
                        self?.hostVC.arrCotegory.append("Copyright")
                    }
                   // arrCotegory
                    DispatchQueue.main.async {
                        self?.hostVC.tblOrderlist.reloadData()
                    }
                }
          }
    }
    private  func OrderDeleteApi() {
        GlobalLoader.shared.show()
        THApiHandler.deleteAPICall(responseType: CartRemovalResponse.self, id: "", completionHandler:{_dataResponse,_error in
            print(_dataResponse)
          if let status = _dataResponse?.success {
              AlertManager.showAlert(on: self.hostVC,
                                       title: "Success",
                                       message: _dataResponse?.message ?? "") {
                }
            } else {
//                self.hostVC.lblError.isHidden = false
//                self.hostVC.tblAddlist.isHidden = true
            }
        })
    }
}
