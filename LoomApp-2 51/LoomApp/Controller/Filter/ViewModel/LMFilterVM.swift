//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMFilterVM : NSObject {
    
    var model : SubcategoryData?
    private var hostVC : LMFilterVC
    init(hostController : LMFilterVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    func getFilterdetail(){
        guard hostVC.checkInternet else {
            return
        }
        
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: SubcategoryResponse.self) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil{
                self?.model = (dataResponse?.data)
                DispatchQueue.main.async {

                    self?.hostVC.selectedIndexPath = IndexPath(row: 0, section: 0)
                    self?.hostVC.tableView.reloadData()
                    self?.hostVC.tblRow.isHidden = false
                    self?.hostVC.tblRow.reloadData()

                }
            }
        }
    }
    
}
