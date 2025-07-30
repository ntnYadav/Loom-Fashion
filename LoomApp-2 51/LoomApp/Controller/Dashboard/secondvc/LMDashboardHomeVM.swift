//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMDashboardHomeVM : NSObject{
    
    
    var modelBanner : [Banner?]?
    var modelproduct : ProductData?
    var model : ResponseData?
    private var hostVC : LMDashboardHomeVC
    init(hostController : LMDashboardHomeVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else {
            return
        }
        getCategoryApi()
    }
    
    func getCategoryApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ApiResponse.self,page:"1",limit: "1000",subcategoryId: "") { [weak self] dataResponse, error in
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
                    
                    if self?.model?.subcategoriesFinal == nil {
                        self?.model?.subcategoriesFinal = []
                    }
                    self?.model?.subcategories1?.removeAll()
                    
                    // Add "All" item at the beginning
                    self?.model?.subcategories1?.append(
                        Subcategory(_id: "0", name: "All", image: "", sequence: 0)
                    )
                    self?.model?.subcategoriesFinal?.append(contentsOf: [
                        Subcategory(_id: "0", name: "All", image: "", sequence: 0),
                        Subcategory(_id: "0", name: "FEATURED CATEGORIES", image: "", sequence: 0)
                    ])
                    if let subcategories = ara {
                        for subcategory in subcategories {
                            print("Subcategory name: \(subcategory.name), sequence: \(subcategory.sequence)")
                            self?.model?.subcategories1?.append(subcategory)
                            self?.model?.subcategoriesFinal?.append(subcategory)

                        }
                    }
                }
                DispatchQueue.main.async {
                    self?.hostVC.collectionView.reloadData()
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
        THApiHandler.getApi(responseType: ApiResponse.self,page:"1",limit: "1000",subcategoryId: subcategoryId) { [weak self] dataResponse, error in
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
                        
                        if self?.model?.subcategoriesFinal == nil {
                            self?.model?.subcategoriesFinal = []
                        }
                        self?.model?.subcategories1?.removeAll()
                        
                        // Add "All" item at the beginning
                        self?.model?.subcategories1?.append(
                            Subcategory(_id: "0", name: "All", image: "", sequence: 0)
                        )
                        self?.model?.subcategoriesFinal?.append(contentsOf: [
                            Subcategory(_id: "0", name: "All", image: "", sequence: 0),
                            Subcategory(_id: "0", name: "FEATURED CATEGORIES", image: "", sequence: 0)
                        ])
                        if let subcategories = ara {
                            for subcategory in subcategories {
                                print("Subcategory name: \(subcategory.name), sequence: \(subcategory.sequence)")
                                self?.model?.subcategories1?.append(subcategory)
                                self?.model?.subcategoriesFinal?.append(subcategory)

                            }
                        }
                      
                    }
                    DispatchQueue.main.async {
                        self?.hostVC.collectionView.reloadData()
                    }
                }
          }
//        GlobalLoader.shared.show()
//        THApiHandler.getApi(responseType: ProductResponsetag.self,idStr:productID,page:page, limit:limit, tagValue:lowercased) { [weak self] dataResponse, error in
//                        debugPrint(dataResponse as Any)
//                        GlobalLoader.shared.hide()
//                        if dataResponse != nil{
//                            self?.modelproduct = (dataResponse?.data)
//                            self?.model?.products.removeAll()
//                            self?.modelproduct?.products as? [Product] ?? []
//                            DispatchQueue.main.async {
//                                self?.hostVC.mainTableView.reloadData()
//                            }
//                        }
//                  }
  }
    func validateBannerValue(){
        guard hostVC.checkInternet else {
            return
        }
        getBannerApi()
    }
    private  func getBannerApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: BannerResponse.self,subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    
                    if let banners = dataResponse?.banners {
                        self?.modelBanner = banners.filter { $0.mobileImage != nil }
                    }
                    
                    //self?.modelBanner = (dataResponse?.banners)!
                    DispatchQueue.main.async {
                        self?.hostVC.collectionView.reloadData()
                    }
                }
          }
    }
    
    func callWishListAPI(productId:String,strColor:String,strVaiantId:String) {
        GlobalLoader.shared.show()
        
        let bodyRequest = wishlist(productId:productId, color:strColor.capitalizedFirstLetter, variantId: strVaiantId)
        //cartParameter(productId:productId, variantId:variantId,quantity: qty)
        THApiHandler.post(requestBody: bodyRequest, responseType: WishlistResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
//                let deleteSheet = LMCartPop()
//                deleteSheet.modalPresentationStyle = .overFullScreen
//                deleteSheet.modalTransitionStyle = .coverVertical
//                self?.hostVC.present(deleteSheet, animated: true)
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
}
