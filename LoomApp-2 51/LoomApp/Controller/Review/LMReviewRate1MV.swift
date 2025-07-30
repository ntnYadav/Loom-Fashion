//
//  LMAddressMV.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.


import Foundation
import UIKit
import Toast_Swift
import Alamofire



class LMReviewRate1MV : NSObject{
    var filenameArray = [String]()
    var image: UIImage = UIImage()
    var compressDataToUpload = [Data]()
    var selctedFile : fileSelection?
    var modelReviewlist: [Review] = []
    var customerImages: [String] = []

    var modelBanner : [Banner?]?
    var modelproduct : ProductData?
    var model : ResponseData?
    
    var model12 : [DeliveredOrderReviewItem] = []

    private var hostVC : LMReviewRateVC1
    init(hostController : LMReviewRateVC1) {
        self.hostVC = hostController
    }

    
    func uploadImageToServer(image: UIImage, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        let url = "https://review-api.loomfashion.co.in/api/upload/image"
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
    private  func uploadDocumentAPI11() {
        
     
        THApiHandler.uploadDocumentOrImage(responseType: ReviewResponse.self, params: nil, mimeType: self.selctedFile?.rawValue, filesData: compressDataToUpload, filesName: filenameArray) { [weak self]  dataResponse, error , stauscode in
            if dataResponse != nil{
//                self?.data = dataResponse?.data
//                self?.data1 = dataResponse?.message
//                self?.redirectToSubmit(message:  self?.data1)
//
            }
            
            switch stauscode {
            case 413:
                self?.hostVC.showToastView(message: keyName.backenError)
            case 500:
                self?.hostVC.showToastView(message: keyName.backenError)
            case 502:
                self?.hostVC.showToastView(message: keyName.backenError)
            case 200: break
//                self?.dataToUpload.removeAll()
//                self?.filename.removeAll()
//                self?.hostVC.imageArray.removeAll()
//                self?.fileWithExtArray.removeAll()
//                self?.selctedFile = .cancel
//                if error == nil && dataResponse !=  nil && dataResponse!.status == true{
//                    THUserDefaultValue.phoneNumber = dataResponse?.data?.phone
//                    let profile: [String: Any?] = [
//                        keyName.phone: dataResponse?.data?.phone,
//                    ]
//                    
//                } else {
//                    self?.hostVC.showToastView(message: keyName.backenError)
//                    DispatchQueue.main.async {
//                    }
//                }
            default: break
            }
            
        }
        
    }
    
    
    class func uploadDocumentOrImage< T: Decodable>(responseType: T.Type, params: [String: Any]? = nil, mimeType: String? = nil, filesData: [Data]? = nil,filesName: [String]? = nil, completionHandler: @escaping (T?, Error?,Int?) -> Void) {


        let urlString = getURL(type: responseType)
        debugPrint("urlString == \(urlString)")
        let apiURL = URL(string: urlString)!

        var token = String()
        if let auth = THUserDefaultValue.authToken {
            token = auth
        }

        let token1 = THUserDefaultValue.authToken
        print("Token===\(token)")
        var  headers1 = HTTPHeaders()
        if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
            print("Token from UserDefaults: \(savedToken)")
            headers1 = [
                "accesstoken": "\(savedToken)", // or just use "accesstoken": accessToken if that's what your API expects
            ]
        }
        
        
        var header = HTTPHeaders()
        let abc = HTTPHeader(name: THconstant.headerContentTypeName, value: keyName.apiMultiformHeader)
        if token != keyName.emptyStr {
            header = [ "accesstoken": "Bearer \(String(describing: token))" ]
            header.add(abc)
        } else {
            header.add(abc)
        }

        logd(v: "Auth token - \n",token)

        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 600
        AF.upload(multipartFormData: { multiPart in

            if let paramters = params {
                for (key, value) in paramters {
                    if let temp = value as? Bool {
                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? String {
                        multiPart.append(temp.data(using: .utf8)!, withName: key)
                    }
                }
            }

            if let data = filesData, let file = filesName {
                for (index, value) in data.enumerated() {
                        multiPart.append(value, withName: keyName.fileName, fileName: file[index], mimeType:MimeTypes.image)
                }
            }

            //SwiftLoader.show(title: "Uploading..", animated: true)
        }, to: apiURL, method: .post, headers: headers1).response(completionHandler: { response in
           // SwiftLoader.hide()
//               DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                   // SwiftLoader.hide()
                    do {
                        if data != nil{
                            
//                               let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                                print(jsonResponse as! NSDictionary)
                            
                            let dataReceived = try JSONDecoder().decode(T.self, from: data!)
                            if response.response?.statusCode != 401 {
                                completionHandler(dataReceived, nil, response.response?.statusCode)
                            } else {
                                objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                                print("Token Expire")
                            }
                           
                        }
                       
                    } catch let jsonError {
                        completionHandler(nil, jsonError, response.response?.statusCode)
                    }
                case .failure(let error):
                    //SwiftLoader.hide()
                    logd(v: error.localizedDescription)
                    completionHandler(nil, error, response.response?.statusCode)
                }
//               }
        })
    }
    
  
    // MARK: validate value
    func validateValueReview(productId:String,OrderId:String,OrderItemId:String,comment:String,variantId:String,rating1:Int,images:[String]){
        guard hostVC.checkInternet else {
            return
        }
        
            GlobalLoader.shared.show()
        let bodyRequest = ReviewRequest(productId: productId, rating: rating1, comment: comment, variantId: variantId, orderId: OrderId, orderItemId: OrderItemId, images: images)
        
            THApiHandler.post(requestBody: bodyRequest, responseType: ReviewResponse.self, progressView: hostVC.view) { [weak self] dataResponse, error,msg  in
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
    //@Serializabledata class AddUpdateReviewRequest(    val comment: String? = null, // Great product, loved the quality!    val images: List<String>? = null,    val orderId: String, // 6848692f665a8ce30df60dd8    val orderItemId: String, // 6848692f665a8ce30df60dd9    val productId: String, // 683d5b4a0210931fe2aac5ed    val rating: Double, // 4    val variantId: String // 683d5bbf0210931fe2aac622)
    
    // MARK: validate value
    func validateValue2(){
        guard hostVC.checkInternet else {
            return
        }
        uploadDocumentAPI11()
        
    }
    
    // MARK: validate value
    func validateValue(){
        guard hostVC.checkInternet else {
            return
        }
        uploadDocumentAPI()
        
    }
    enum fileSelection : String{
        case image = "image/jpeg"
        case doc = "application/pdf"
        case cancel
    }
    
    private  func uploadDocumentAPI() {
        func uploadImage(paramName: String, fileName: String, image: UIImage) {
            let url = URL(string: "http://192.168.29.137:3007/api/upload/image")

            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString

            let session = URLSession.shared

            // Set the URLRequest to POST and to the specified URL
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"

            // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
            // And the boundary is also set here
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var data = Data()

            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"images\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)

            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                if error == nil {
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print(json)
                    }
                }
            }).resume()
        }
    }
    // MARK: validate value

func getReviewApi(productId:String,page:Int,limit: Int) {
        GlobalLoader.shared.show()
        THApiHandler.getApi(responseType: ReviewResponse123.self,page:"1",limit: "20",subcategoryId: productId) { [weak self] dataResponse, error in
                debugPrint(dataResponse as Any)
                GlobalLoader.shared.hide()
                if dataResponse != nil{
                    
                    if let reviews = dataResponse?.data?.reviews {
                        self?.modelReviewlist = reviews
                        self?.customerImages = dataResponse?.data?.customerImages ?? []
                              DispatchQueue.main.async {
                                 // self?.hostVC.collectionCustomerImages.reloadData()
                                  self?.hostVC.tblReview.reloadData()
                              }
                          } else {
                              print("❌ Failed to fetch reviews or no reviews available")
                          }
                }
          }
    }
    
    
    func validateValueOrderList(){
        guard hostVC.checkInternet else {
            return
        }
        getOrderApi()
    }
    private func getOrderApi() {
        GlobalLoader.shared.show()
        
        THApiHandler.getApi(
            responseType: DeliveredOrderReviewResponse.self,
            page: "1",
            limit: "20",
            subcategoryId: ""
        ) { [weak self] dataResponse, error in
            DispatchQueue.main.async {
                GlobalLoader.shared.hide()

                guard let self = self else { return }

                if let data = dataResponse?.data {
                    self.hostVC.viewEmpty.isHidden = true

                    self.model12 = data
                    self.hostVC.viewEmpty.isHidden = !data.isEmpty
                    self.hostVC.tblReview.reloadData()
                } else {
                    self.hostVC.viewEmpty.isHidden = false
                    // Optional: show error alert
                    // self.showAlert("Something went wrong. Please try again.")
                }

                debugPrint("Response:", dataResponse as Any)
            }
        }
    }

}
