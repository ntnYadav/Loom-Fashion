//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift
import Alamofire



class LMWishlistMV : NSObject{
    var filenameArray = [String]()
    var image: UIImage = UIImage()
    var compressDataToUpload = [Data]()
    var modelReviewlist: [Review] = []
    var customerImages: [String] = []
    
    var modelBanner : [Banner?]?
    var modelproduct : ProductData?
    var model : ResponseData?
    var modelproductCart : CartDataitem?

    var model12 : [WishlistProduct9] = []
    
    private var hostVC : LMWishlistVC
    init(hostController : LMWishlistVC) {
        self.hostVC = hostController
    }
    
    func validateValueWishListMove(productId:String,vaiantId:String, color:String) {
          GlobalLoader.shared.show()
        let bodyRequest = WishlistItem1(productId: productId, variantId: vaiantId, color:color,quantity:1)
        THApiHandler.post(requestBody: bodyRequest, responseType: WishlistToCartResponse.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
              GlobalLoader.shared.hide()
              self?.getCartApi()
              self?.validateValueWishListList()

              if let status = dataResponse?.success {
                 // self?.model = (dataResponse?.data)
                  //let obj = LMPaymentVC()
                //  self?.validateValueWishListList()
              } else {
                  //self?.hostVC.showToastView(message: msg)
              }
          }
      
        }
    
//    func validateValueWishListMove(productId:String,vaiantId:String) {
//          GlobalLoader.shared.show()
//        let bodyRequest = WishlistItem(productId: productId, variantId: vaiantId, quantity: 1)
//        
//          THApiHandler.post(requestBody: bodyRequest, responseType: WishlistToCartResponse.self, progressView: hostVC.view,editId:""){ [weak self] dataResponse, error,msg  in
//              GlobalLoader.shared.hide()
//              self?.getCartApi()
//              self?.validateValueWishListList()
//
//              if let status = dataResponse?.success {
//                 // self?.model = (dataResponse?.data)
//                  //let obj = LMPaymentVC()
//                //  self?.validateValueWishListList()
//              } else {
//                  //self?.hostVC.showToastView(message: msg)
//              }
//          }
//      
//        }
    
    
    func callWishListAPIDelete(productId:String,strColor:String,strVaiantId:String) {
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
    func validateValueWishListList() {
        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: WishlistResponse9.self,page:"1",limit: "100",subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                if let data = dataResponse?.products {

                                        self?.model12 = data
                                        if self?.model12.count != 0{
                                            //self?.hostVC.lblWishListCount.isHidden = false

                                            if let valuecount = self?.model12.count {
                                               // self?.hostVC.lblWishListCount.text = "\(valuecount)"
                                            }
                                            
                                            self?.hostVC.viewEmpty.isHidden = true
                                        } else{
                                            //self?.hostVC.lblWishListCount.isHidden = true

                                            //self?.hostVC.lblWishListCount.text = ""
                                            self?.hostVC.viewEmpty.isHidden = false
                                        }
                
                                        DispatchQueue.main.async {
                                            self?.hostVC.tblWishlist.reloadData()
                                        }
                                    }
                                } else {
                                    //self?.hostVC.lblWishListCount.isHidden = true
                                    self?.hostVC.viewEmpty.isHidden = false
                                }
            }
        }
    
    
    func getCartApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: CartResponse.self,subcategoryId: "") { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil {
                self?.modelproductCart = (dataResponse?.data)
                if self?.modelproductCart?.items.count != 0 {
                    if let valuecount = self?.modelproductCart?.items.count {
                        self?.hostVC.lblWishListCount.isHidden = false
                        self?.hostVC.lblWishListCount.text = "\(valuecount)"
                    } else {
                        self?.hostVC.lblWishListCount.isHidden = true
                        self?.hostVC.lblWishListCount.text = ""
                    }
                } else {
                    self?.hostVC.lblWishListCount.isHidden = true
                }
            } else {
               self?.hostVC.lblWishListCount.isHidden = true
            }
        }
    }
    
    
    
    func deleteValue(productId: String,vaiantID: String){
        guard hostVC.checkInternet else{
            return
        }
        self.callDeleteAddressApi(productId:productId,vaiantID:vaiantID)
    }
    private  func callDeleteAddressApi(productId: String,vaiantID: String) {
        
       GlobalLoader.shared.show()
        THApiHandler.deleteAPICall(responseType: RemoveWishlistResponse.self, id: (productId + "/" + vaiantID), completionHandler:{_dataResponse,_error in
            print(_dataResponse)
            GlobalLoader.shared.hide()
          if let status = _dataResponse?.success {

            } else {
               // self.hostVC.lblError.isHidden = false
            }
        })
    }

    
    
    private  func callCartAPI(productId:String,variantId:String,qty:Int) {
        GlobalLoader.shared.show()
        
        let bodyRequest = cartParameter(productId:productId, variantId:variantId,quantity: 1)
        THApiHandler.post(requestBody: bodyRequest, responseType: AddToCartResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
                
//                let deleteSheet = LMCartPop()
//                deleteSheet.modalPresentationStyle = .overFullScreen
//                deleteSheet.modalTransitionStyle = .coverVertical
//                //self?.hostVC.present(deleteSheet, animated: true)
            } else {
                //self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    func callRemoveWishListAPI(productId:String,strColor:String,strVaiantId:String) {
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

