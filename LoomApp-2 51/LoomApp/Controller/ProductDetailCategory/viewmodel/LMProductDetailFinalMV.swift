//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift


class LMProductDetailFinalMV : NSObject{
    var modelCoupon : PromoData?
    var modelproduct : ProductDataDetail?
    var modelCategory : ResponseData?
    var modelReview: [Review] = []
    var customerImages: [String] = []
    var sizeArrayTemp: [String]?

    
    private var hostVC : LMProductDetVC
    init(hostController : LMProductDetVC) {
        self.hostVC = hostController
    }
    
    // MARK: validate value
    func validateValue(productId:String,defaultVaniantID:String){
        guard hostVC.checkInternet else {
            return
        }
        getCategoryApi(productId: productId, defaultVaniantID: defaultVaniantID)
    }
    
    private  func getCategoryApi(productId:String,defaultVaniantID:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ProductDetailResponse.self, subcategoryId: productId) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            if dataResponse != nil{
                self?.modelproduct = (dataResponse?.data)!
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    
                  //  if let prodVari == self?.modelproduct?.defaultVariantId  {
                        let defaultPair = self?.modelproduct?.colors?
                            .compactMap { color in
                                color.sizes?.first { $0.variantId == defaultVaniantID }
                                    .map { (color, $0) }
                            }
                            .first
                        
                        if var (color, variant) = defaultPair {
                            // hostVC.imagesCollection = variant[]
                            self?.modelproduct?.variantsColor = [color]
                            self?.modelproduct?.variants = [variant] // or append
                            self?.modelproduct?.sizestemp = variant.images
                            print("Color: \(color.value), Size: \(variant.images)")
                        }
                        
                   // self?.modelproduct?.sizeArrayTemp = self?.modelproduct?.variantsColor?[0].sizes?.compactMap { $0.size } ?? []
//                    //print(allSizes)
//                    self?.modelproduct?.sizeArrayTemp?.reversed()
                }
                DispatchQueue.main.async {
                    self?.hostVC.collectionShirts.reloadData()
                    self?.hostVC.tableView.reloadData()
                }
            }
        }
    }
    func validateAddToCart(productID:String,variantId:String,qty:Int){
        guard hostVC.checkInternet else{
            return
        }
        self.callCartAPI(productId: productID, variantId: variantId, qty: qty)
        
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
    
    private  func callCartAPI(productId:String,variantId:String,qty:Int) {
        GlobalLoader.shared.show()
        
        let bodyRequest = cartParameter(productId:productId, variantId:variantId,quantity: qty)
        THApiHandler.post(requestBody: bodyRequest, responseType: AddToCartResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
                THUserDefaultValue.isUsercolorsize = nil
                
                let deleteSheet = LMCartPop()
                deleteSheet.modalPresentationStyle = .overFullScreen
                deleteSheet.modalTransitionStyle = .coverVertical
                deleteSheet.onSelected = { selected in
                    print("User selected: \(selected)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(withIdentifier: VcIdentifier.LMCartTableVC) as! LMCartTableVC
                    secondVC.backBtn = "Product"
                    secondVC.navigationControl = true
                    self?.hostVC.navigationController?.pushViewController(secondVC, animated: true)
                }
                self?.hostVC.present(deleteSheet, animated: true)
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    func validateCoupon(){
        guard hostVC.checkInternet else{
            return
        }
        callCouponApi()
        
    }
    private  func callCouponApi() {
        GlobalLoader.shared.show()
        guard hostVC.checkInternet else{
            return
        }
        THApiHandler.getApi(responseType: PromoResponse.self) { [weak self] dataResponse, error in
            debugPrint(dataResponse as Any)
            GlobalLoader.shared.hide()
            
            if dataResponse != nil{
                self?.modelCoupon = (dataResponse?.data)!
                DispatchQueue.main.async {
                    self?.hostVC.tableView.reloadData()
                }
            }
        }
    }
    func validateProductDetail(){
        guard hostVC.checkInternet else {
            return
        }
        getCategoryApi()
    }
    private  func getCategoryApi() {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ApiResponse.self,page:"1",limit: "20",subcategoryId: "") { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    self?.modelCategory = (dataResponse?.data)
                    DispatchQueue.main.async {
                        self?.hostVC.tableView.reloadData()
                    }
                }
          }
    }
    func validateReviewDetail(productId:String){
        guard hostVC.checkInternet else {
            return
        }
        getReviewApi(productId:productId)
    }
    private  func getReviewApi(productId:String) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ReviewResponse123.self,page:"1",limit: "20",subcategoryId: productId) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    
                    if let reviews = dataResponse?.data?.reviews {
                        self?.modelReview = reviews
                        self?.customerImages = dataResponse?.data?.customerImages ?? []
                              DispatchQueue.main.async {
                                  self?.hostVC.tableView.reloadData()
                              }
                          } else {
                              print("❌ Failed to fetch reviews or no reviews available")
                          }
                }
          }
    }
   
    
    // MARK: validate value
    func validatePincodeValue(Pincode:String,weight:Double,height:Double,breadth:Double,length:Double){
        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()
        let bodyRequest = deliveryPincodeReq12(deliveryPincode: Int(Pincode) ?? 0, weight: 5.2, height: Double(height), breadth: Double(breadth), length: Double(length))
        
            THApiHandler.post(requestBody: bodyRequest, responseType: DeliveryEstimateResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
                GlobalLoader.shared.hide()
                if let status = dataResponse?.success {
                    let mod = dataResponse?.data
                    self?.hostVC.dismiss(animated: true) {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let currentDateString = formatter.string(from: Date())
                        
                        THUserDefaultValue.userdateCurrentDate = currentDateString
                        
                        THUserDefaultValue.userdateDays   = mod?.estimatedDeliveryDays ?? ""

                        THUserDefaultValue.userdatefrmate = mod?.expectedDeliveryDate ?? ""
                        //self?.hostVC.onApplyTapped?(Pincode,[""])
                        THUserDefaultValue.isUserPincodeLoging = true
                                      }
                   // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
                } else {
                    
                    //self?.hostVC.infoLabel.text = "Pincode is not serviceable"
                }
            }
        
        
    }
    
}
