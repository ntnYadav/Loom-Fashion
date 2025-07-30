//
//  LMReturnsOrederMv.swift
//  LoomApp
//
//  Created by Abdul Quadir on 16/07/25.
//

import Foundation
import Toast_Swift
import UIKit
import Alamofire

class LMReturnsMV : NSObject{
    
    var modelproduct : ProductDataDetail?
    
    private var hostVC : returnOrderVC
    init(hostController : returnOrderVC) {
        self.hostVC = hostController
    }
   
    // MARK: validate value
    func createRefundRequestBody(
        orderId: String,
        orderItemId: String,
        reason: String,
        comments: String,
        pickupAddressId: String,
        refundMethod: String,
        upiId: String = "",
        bankAccountNumber: String = "",
        ifscCode: String = "",
        bankName: String = "",
        accountHolderName: String = "",
        images: [String] = []
    ) -> [String: Any]? {
        
        // Validate refundMethod
        var refundDetails: [String: String] = [:]
        
        if refundMethod == "UPI" {
            guard !upiId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                print("UPI ID is required for UPI refund method.")
                return nil
            }
            refundDetails["upiId"] = upiId
            
        } else if refundMethod == "BANK_TRANSFER" {
            guard !bankAccountNumber.isEmpty,
                  !ifscCode.isEmpty,
                  !bankName.isEmpty,
                  !accountHolderName.isEmpty else {
                print("All bank fields are required for BANK_TRANSFER.")
                return nil
            }
            refundDetails = [
                "bankAccountNumber": bankAccountNumber,
                "ifscCode": ifscCode,
                "bankName": bankName,
                "accountHolderName": accountHolderName
            ]
        } else {
            print("Invalid refund method: must be UPI or BANK_TRANSFER.")
            return nil
        }
        
        // Construct final dictionary
        let body: [String: Any] = [
            "orderId": orderId,
            "orderItemId": orderItemId,
            "type": "REFUND",
            "reason": reason,
            "comments": comments,
            "pickupAddress": pickupAddressId,
            "images": images,
            "refundMethod": refundMethod,
            "refundDetails": refundDetails
        ]
        
        return body
    }
 
    // MARK: - Build Request Body
     func buildRequest(
         orderId: String,
         orderItemId: String,
         pickupAddress: String,
         reason: String,
         comments: String = "",
         type: String,
         images: [String] = [],
         productId: String = "",
         replacementVariantId: String = "",
         deliveryAddress: String = "",
         refundMethod: String = "",
         upiId: String = "",
         bankAccountNumber: String = "",
         ifscCode: String = "",
         accountHolderName: String = ""
     ) -> ReturnExchangeRequest {

         let refundDetails = ReturnExchangeRequest.RefundDetails(
             upiId: upiId,
             bankAccountNumber: bankAccountNumber,
             ifscCode: ifscCode,
             accountHolderName: accountHolderName
         )

         return ReturnExchangeRequest(
             orderId: orderId,
             orderItemId: orderItemId,
             pickupAddress: pickupAddress,
             images: images,
             reason: reason,
             comments: comments,
             type: type,
             productId: productId,
             replacementVariantId: replacementVariantId,
             deliveryAddress: deliveryAddress,
             refundMethod: refundMethod,
             refundDetails: refundDetails
         )
     }
//    orderId: objModel?.orderId ?? "",
//    orderItemId: objModel?.itemId ?? "",
//    pickupAddress: objAddress?.id ?? "",
//    images: self.imagesArray ?? [],
//    reason: selectedReason ?? "",
//    comments: "",
//    type: ReturnTypesCheck,
//    productId: objModel?.productId ?? "",
//    replacementVariantId: replacementVaientId,
//    deliveryAddress: objAddress1?.id ?? "",
//    refundMethod: selectedBankOption,
//    upiId: String,
//    bankAccountNumber: String,
//    ifscCode: String,
//    accountHolderName: String,
//    refundDetails: []
    func validateValueSubmitAPI(orderId:String,orderItemId:String,pickupAddress:String,images: [String],reason:String,comments:String,type:String,productId:String,replacementVariantId:String,deliveryAddress:String,refundMethod:String, upiId: String,bankAccountNumber: String,ifscCode: String,
        accountHolderName: String,refundDetails:[ReturnExchangeRequest.RefundDetails]){

        guard hostVC.checkInternet else {
            return
        }
        GlobalLoader.shared.show()

       let bodyRequest =  buildRequest(orderId: orderId, orderItemId: orderItemId, pickupAddress: pickupAddress, reason: reason, type: type, productId:productId,replacementVariantId:replacementVariantId,deliveryAddress:deliveryAddress,refundMethod:refundMethod ,upiId:upiId,bankAccountNumber:bankAccountNumber,ifscCode:ifscCode,accountHolderName:accountHolderName)
        
       // let bodyRequest =  ReturnExchangeRequest(orderId: orderId, orderItemId: orderItemId, pickupAddress: pickupAddress, images: images, reason: reason, comments: comments, type: type, productId: productId, replacementVariantId: replacementVariantId, deliveryAddress: deliveryAddress, refundMethod: refundMethod, refundDetails: refundDetails)
        
        
        //let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.post(requestBody: bodyRequest, responseType: ReturnsDetailResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
                AlertManager.showAlert(on: self!.hostVC,
                                       title: "Success",
                                       message: dataResponse?.message ?? "") {
                    self?.hostVC.navigationController?.popViewController(animated: true)
                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
        
        //getCategoryApi(productId: productId, defaultVaniantID: defaultVaniantID)
        
    }
    private  func callSubmitApi(name:String,phoneNo:String,pincode:String,house:String,area:String,city:String,state:String,country:String,degaultaddress:Bool) {
        GlobalLoader.shared.show()
        let bodyRequest = Address(name: name, mobile: phoneNo, pinCode: pincode, houseNumber: house, area: area, city: city, state: state, country: country, isDefault: degaultaddress)
        THApiHandler.post(requestBody: bodyRequest, responseType: AddAddressResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
            GlobalLoader.shared.hide()
            if let status = dataResponse?.success {
              
                AlertManager.showAlert(on: self!.hostVC,
                                       title: "Success",
                                       message: dataResponse?.message ?? "") {
                    self?.hostVC.navigationController?.popViewController(animated: true)
                }
               // self?.hostVC.showToastView(message: dataResponse?.message ?? "")
            } else {
                self?.hostVC.showToastView(message: msg)
            }
        }
    }
    
    func validateValue(productId:String,defaultVaniantID:String){
        guard hostVC.checkInternet else {
            return
        }
        getCategoryApi(productId: productId, defaultVaniantID: defaultVaniantID)
    }
    
    func uploadImageToServer(image: UIImage, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        let url = "https://user-api.loomfashion.co.in/auth_user/user/upload/images"
        let headers: HTTPHeaders = [:]

        // Convert UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            let error = NSError(domain: "", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "Invalid image data"
            ])
            completion(Swift.Result.failure(error))
            return
        }

        // Upload image with multipart/form-data
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "images", fileName: "upload.jpg", mimeType: "image/jpeg")
        }, to: url, headers: headers)
        .validate()
        .responseDecodable(of: UploadResponse.self) { response in
            debugPrint("🧾 Full Response:")
            debugPrint(response)

            switch response.result {
            case .success(let uploadResponse):
                print("✅ Parsed Response:", uploadResponse)
                if uploadResponse.success, let firstImageURL = uploadResponse.images.first {
                    
                    completion(Swift.Result.success(firstImageURL))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: uploadResponse.message
                    ])
                    completion(Swift.Result.failure(error))
                }

            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }    //MARK: hit API for upload document
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
                        
                  //  }
                }
                DispatchQueue.main.async {
                   // self?.hostVC.collectionShirts.reloadData()
                    self?.hostVC.tableview.reloadData()
                }
            }
        }
    }
//    func validateValue(productId:String,defaultVaniantID:String){
//        guard hostVC.checkInternet else {
//            return
//        }
//        getCategoryApi(productId: productId, defaultVaniantID: defaultVaniantID)
//    }
//    
//    private func getCategoryApi(productId: String, defaultVaniantID: String) {
//        GlobalLoader.shared.show()
//        
//        THApiHandler.getApi(responseType: ReturnsDetailResponse.self, subcategoryId: productId) { [weak self] dataResponse, error in
//            debugPrint(dataResponse as Any)
//            GlobalLoader.shared.hide()
//            
//            guard let self = self, let data = dataResponse?.data else { return }
//            self.modelproduct = data
//            
//            // 1. Background process to extract default variant
//            DispatchQueue.global(qos: .userInitiated).async {
//                let defaultPair = self.modelproduct?.colors?
//                    .compactMap { color in
//                        color.sizes?.first { $0.variantId == defaultVaniantID }
//                            .map { (color, $0) }
//                    }
//                    .first
//                
//                if let (color, variant) = defaultPair {
//                    self.modelproduct?.variantsColor = [color]
//                    self.modelproduct?.variants = [variant]
//                    self.modelproduct?.sizestemp = variant.images
//                    print("Color: \(color.value), Size: \(variant.images)")
//                }
//            }
//            
//            DispatchQueue.main.async {
//                self.hostVC.tableview.reloadData()
//            }
//            
//            self.submitReturnRequest()
//        }
//    }
//
//
//
//    
    
}
