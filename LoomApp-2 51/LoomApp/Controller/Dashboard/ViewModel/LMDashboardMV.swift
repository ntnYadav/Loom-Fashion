//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift
class MobileBrand {
    var brandName: String?
    var modelName: [String]?
    
    init(brandName: String, modelName: [String]) {
        self.brandName = brandName
        self.modelName = modelName
    }
}

class LMDashboardMV : NSObject{
    
    
    var modelBanner : [Banner?]?
    var modelproduct : ProductData?
    var model : ResponseData?
    private var hostVC : LMDashboardVC
    init(hostController : LMDashboardVC) {
        self.hostVC = hostController
    }

    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else {
            return
        }
        getBannerApi()
    }
    
      func getCategoryApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ApiResponse.self,page:"1",limit: "20",subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.model = (dataResponse?.data)
                    if let data = dataResponse?.data {
                        self?.model = data
                        self?.model?.subcategories = data.subcategories.sorted {
                            ($0.sequence) < ($1.sequence)
                        }
                        
                        let ara = self?.model?.subcategories
                        
                        if self?.model?.subcategories1 == nil {
                            self?.model?.subcategories1 = []
                        }
                        
                        self?.model?.subcategories1?.removeAll()

                        // Add "All" item at the beginning
                        self?.model?.subcategories1?.append(
                            Subcategory(_id: "0", name: "All", image: "", sequence: 0)
                        )

                        if let subcategories = ara {
                            for subcategory in subcategories {
                                print("Subcategory name: \(subcategory.name), sequence: \(subcategory.sequence)")
                                self?.model?.subcategories1?.append(subcategory)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self?.hostVC.mainTableView.reloadData()
                    }
                }
          }
    }
    private  func getBannerApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: BannerResponse.self,subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.modelBanner = (dataResponse?.banners)!
                    DispatchQueue.main.async {
                        self?.hostVC.mainTableView.reloadData()
                    }
                }
          }
    }
    
    // MARK: validate value
    func getProductListing(productID:String,tagValue:String,page:String,limit:String,subcategoryId:String){
        
        guard hostVC.checkInternet else {
            return
        }
       // let lowercased = tagValue.lowercased()
        THApiHandler.getApi(responseType: ApiResponse.self,page:"1",limit: "20",subcategoryId: subcategoryId) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.model = (dataResponse?.data)
                    if let data = dataResponse?.data {
                        self?.model = data
                        self?.model?.subcategories = data.subcategories.sorted {
                            ($0.sequence) < ($1.sequence)
                        }
                        
                        let ara = self?.model?.subcategories
                        
                        if self?.model?.subcategories1 == nil {
                            self?.model?.subcategories1 = []
                        }
                        
                        self?.model?.subcategories1?.removeAll()

                        // Add "All" item at the beginning
                        self?.model?.subcategories1?.append(
                            Subcategory(_id: "0", name: "All", image: "", sequence: 0)
                        )

                        if let subcategories = ara {
                            for subcategory in subcategories {
                                print("Subcategory name: \(subcategory.name), sequence: \(subcategory.sequence)")
                                self?.model?.subcategories1?.append(subcategory)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self?.hostVC.mainTableView.reloadData()
                    }
                }
          }

  }

}
