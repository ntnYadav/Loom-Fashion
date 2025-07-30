//
//  NetworkRequest.swift
//
//
//  Created by chetu on 29/09/22..
//

import UIKit
import Foundation
import Alamofire
#if canImport(FoundationNetworking)
import FoundationNetworking
import FoundationNetworking
#endif
import Toast_Swift

class THApiHandler {

   // var object = LoginViewController()

 //MARK: Header for Api's
    private class func getHeaheaders(appendHeader: [String: String]? = nil, type: Int? = nil) -> HTTPHeader {
        switch type {
        case 0:
            return HTTPHeader(name: THconstant.headerContentTypeName, value: THconstant.headerContentTypeValue)
        case 1:
            return HTTPHeader(name: THconstant.headerContentTypeName, value: THconstant.headerContentTypeValue)
        default:
            return HTTPHeader(name: THconstant.headerContentTypeName, value: THconstant.headerContentTypeValue)
        }
    }

    class func getDefaultSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60.0
        config.timeoutIntervalForResource = 60.0
        return URLSession(configuration: config)
        
    }
    //MARK : api calling start session
//    class func satrtSessionApiCall(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        let token = THUserDefaultValue.authToken ?? keyName.emptyStr
//        var requestNew = request
//        if token != keyName.emptyStr {
//            requestNew.setValue(keyName.bearer + token, forHTTPHeaderField: keyName.authorization)
//        }
//
//        let task = getDefaultSession().dataTask(with: requestNew) { (data, response, err) in
//            if response != nil {
//                debugPrint(response as Any)
//            }
//            if let httpResponse = response as? HTTPURLResponse {
//                let token = handleError(statusCode: httpResponse.statusCode)
//                if token {
//
//                }
//            }
//            if let data = data {
//                completionHandler(data, response, err)
//            }
//        }
//        task.resume()
//    }

    typealias CompletionHandlerRefresh = (Bool?) -> Void

    //MARK: post API
    class func post<T: Decodable, Q: Encodable>(requestBody: Q?, responseType: T.Type, progressView: UIView? = nil, type: Int? = nil, id: Int? = nil,editId: String? = nil, completionHandler: @escaping (T?, Error?,String) -> Void) {
        
        var urlString = keyName.emptyStr
        urlString = getURL(type: responseType)
        switch responseType {
        case _ as LoginModelResponse.Type :
            urlString = getURL(type: responseType)
        case _ as LoginResponse.Type :
            urlString = getURL(type: responseType)
        case _ as ContactModelResponse.Type :
            urlString = getURL(type: responseType)
        case _ as AddAddressResponse.Type :
            urlString = getURL(type: responseType)
        case _ as EditAddressResponse.Type :
            urlString = getURL(type: responseType) + (editId ?? "")
        case _ as AddToCartResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/cart/crt/add_item"
        case _ as SoftReservationResponse.Type :
            urlString = "https://order-api.loomfashion.co.in/order/check/checkout"
        case _ as OrderResponse.Type :
            urlString = "https://order-api.loomfashion.co.in/order/check/payment"
        case _ as OrderItemCancelResponse.Type :
            urlString = "https://order-api.loomfashion.co.in/order/check/order/item/cancel"
        case _ as DeliveryEstimateResponse.Type :
            urlString = "https://order-api.loomfashion.co.in/order/ship/get_estimate_delivery"
            
        case _ as ReviewResponse.Type :
            urlString = "https://review-api.loomfashion.co.in/api/review/add_update_review"
        case _ as WishlistResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/wishlist/add_remove_wishlist"
        case _ as OrderResponse12.Type :
            urlString = "https://payment-api.loomfashion.co.in/api/payment/create-order"
        case _ as RazorpayVerificationResponse.Type :
            urlString = "https://payment-api.loomfashion.co.in/api/payment/verify-payment"
        case _ as PaymentResponse123.Type :
            urlString = "https://order-api.loomfashion.co.in/order/check/payment"
        case _ as WishlistToCartResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/wishlist/moveToCart"
        case _ as ReturnsDetailResponse.Type :
            urlString = "https://order-api.loomfashion.co.in/order/returns/return_request"
        case _ as GuestMergeResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/cart/crt/merge"
            
            
        default:
            urlString = getURL(type: responseType)
        }

        
        let token = THUserDefaultValue.authToken
        print("Token===\(token)")
        var  headers = HTTPHeaders()
        
        let tempToken = THUserDefaultValue.authTokenTemp
        
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }

               
        } else {
            if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
                print("Token from UserDefaults: \(savedToken)")
                headers = [
                    "accesstoken": "\(savedToken)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        }
        

        AF.request(urlString, method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: 200 ..< 700).responseData { response in
         //   DispatchQueue.main.async {
                // SwiftLoader.hide()

           

                switch response.result {
                case .success(let data):
                    do {
                   
                        let statusCode = response.response?.statusCode
                        if(statusCode == 200 || statusCode == 201 ) {
                            let dataReceived1 = try JSONDecoder().decode(T.self, from: data)
                             
                             print("dataReceived1==\(dataReceived1)")

                             if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                 completionHandler(dataReceived1 , nil, "")
                             } else {
                                // objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                                 print("Token Expire")
                             }
                        } else {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            //completionHandler(jsonResponse.message as? T, jsonError)
                            print(jsonResponse as! NSDictionary)
                            let objdata = jsonResponse as! NSDictionary
                            completionHandler(nil,nil,objdata["message"] as! String)

                        }
                                  
                    } catch let jsonError {
                        completionHandler(nil, jsonError, "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error, "")
                }
          //  }
        }
    }

    //MARK: post API
    class func post1<T: Decodable, Q: Encodable>(requestBody: Q?, responseType: T.Type, progressView: UIView? = nil, type: Int? = nil, id: Int? = nil, completionHandler: @escaping (T?, Error?,String) -> Void) {
        
        var urlString = keyName.emptyStr
        urlString = getURL(type: responseType)
        switch responseType {
        case _ as LoginModelResponse.Type :
            urlString = getURL(type: responseType)
        case _ as OTPLoginResponse.Type :
            urlString = getURL(type: responseType)
        case _ as ContactModelResponse.Type :
            urlString = getURL(type: responseType)
            
        default:
            urlString = getURL(type: responseType)
        }
//
////        if let ID = id {
//            urlString = "http://192.168.29.137:3001/auth_user/auth/send_otp"
//
////        }
     
     //   debugPrint("urlString == \(urlString)")

        let token = THUserDefaultValue.authToken
        var  headers = HTTPHeaders()
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            print("Token===\(token)")
            if let accessToken = token {
                headers = [.authorization(bearerToken: accessToken)]
            }
        }
        
        
        
    
        // SwiftLoader.show(title: keyName.loading, animated: true)

        AF.request(urlString, method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: 200 ..< 700).responseData { response in
         //   DispatchQueue.main.async {
                // SwiftLoader.hide()
                switch response.result {
                case .success(let data):
                    do {
                        
                        let statusCode = response.response?.statusCode
                        if(statusCode == 200 || statusCode == 201 ) {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            let objdata = jsonResponse as! NSDictionary
                            if objdata["message"] as! String == "OTP verified. User logged in." {
                                
                                let dataReceived1 = try JSONDecoder().decode(T.self, from: data)
                                print("dataReceived1==\(dataReceived1)")
                                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                    completionHandler(dataReceived1 , nil, "")
                                } else {
                                    print("Token Expire")
                                }
                                
                               
                            } else {

                                //let dataReceived1 = try JSONDecoder().decode(OTPVerifyResponse(), from: data)
                                //print("dataReceived1==\(dataReceived1)")
                                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                    completionHandler(nil , nil, "Redirect" as! String)
                                } else {
                                    print("Token Expire")
                                }
                            }
                        } else {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            //completionHandler(jsonResponse.message as? T, jsonError)
                            print(jsonResponse as! NSDictionary)
                            let objdata = jsonResponse as! NSDictionary
                            completionHandler(nil,nil,objdata["message"] as! String)
                        }
                        
                        
                        
                        
                        
                        
                     
                        
                        
                    } catch let jsonError {
                        completionHandler(nil, jsonError, "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error, "")
                }
          //  }
        }
    }
    
    
    
    //MARK: post API
    class func post5<T: Decodable, Q: Encodable>(requestBody: Q?, responseType: T.Type, progressView: UIView? = nil, type: Int? = nil, id: Int? = nil, completionHandler: @escaping (T?, Error?,String) -> Void) {
        
        var urlString = keyName.emptyStr
        urlString = getURL(type: responseType)
        switch responseType {
   
        case _ as OTPLoginResponse.Type :
            urlString = getURL(type: responseType)
       
        default:
            urlString = getURL(type: responseType)
        }
//
////        if let ID = id {
//            urlString = "http://192.168.29.137:3001/auth_user/auth/send_otp"
//
////        }
     
     //   debugPrint("urlString == \(urlString)")

        let token = THUserDefaultValue.authToken
        var  headers = HTTPHeaders()
        
        
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            print("Token===\(token)")
            if let accessToken = token {
                headers = [.authorization(bearerToken: accessToken)]
            }
        }
        
        
        
        if let accessToken = token {
            headers = [.authorization(bearerToken: accessToken)]
        }
        // SwiftLoader.show(title: keyName.loading, animated: true)

        AF.request(urlString, method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: 200 ..< 700).responseData { response in
         //   DispatchQueue.main.async {
                // SwiftLoader.hide()
                switch response.result {
                case .success(let data):
                    do {
                        
                        let statusCode = response.response?.statusCode
                        if(statusCode == 200 || statusCode == 201 ) {
                                
                                let dataReceived1 = try JSONDecoder().decode(T.self, from: data)
                                print("dataReceived1==\(dataReceived1)")
                                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                    completionHandler(dataReceived1 , nil, "")
                                } else {
                                    print("Token Expire")
                                }
                                
                               
                          
                        } else {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            //completionHandler(jsonResponse.message as? T, jsonError)
                            print(jsonResponse as! NSDictionary)
                            let objdata = jsonResponse as! NSDictionary
                            completionHandler(nil,nil,objdata["message"] as! String)
                        }
                        
                        
                        
                        
                        
                        
                     
                        
                        
                    } catch let jsonError {
                        completionHandler(nil, jsonError, "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error, "")
                }
          //  }
        }
    }
    
    
    
    
    
    func dataToJSON(data: Data) -> Any? {
       do {
           return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       } catch let myJSONError {
           print(myJSONError)
       }
       return nil
    }

    //MARK : Upload document and Image multipart
//    class func uploadDocument< T: Decodable>(fileData: Data? = nil, filename: String? = nil, responseType: T.Type, params: [String: Any]? = nil,
//                                             id: String? = nil, mimeType: String? = nil, progressView: UIView? = nil, filesData: [Data]? = nil,
//                                             filesName: [String]? = nil, type: Int? = nil, completionHandler: @escaping (T?, Error?,Int?) -> Void) {
//
//
//        let urlString = getURL(type: responseType)
//        debugPrint("urlString == \(urlString)")
//        let apiURL = URL(string: urlString)!
//
//        var token = String()
//        if let auth = THUserDefaultValue.authToken {
//            token = auth
//        }
//
//        var header = HTTPHeaders()
//        let abc = HTTPHeader(name: THconstant.headerContentTypeName, value: keyName.apiMultiformHeader)
//        if token != keyName.emptyStr {
//            header = [ "Authorization": "Bearer \(String(describing: token))" ]
//            header.add(abc)
//        } else {
//            header.add(abc)
//        }
//
//        logd(v: "Auth token - \n",token)
//
//        let manager = Alamofire.Session.default
//        manager.session.configuration.timeoutIntervalForRequest = 120
//        AF.upload(multipartFormData: { multiPart in
//
//            if let paramters = params {
//                for (key, value) in paramters {
//                    if let temp = value as? Bool {
//                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
//                    }
//                    if let temp = value as? String {
//                        multiPart.append(temp.data(using: .utf8)!, withName: key)
//                    }
//                }
//            }
//            if let data = filesData, let file = filesName {
//                for (index, value) in data.enumerated() {
//                    if file[index].components(separatedBy: keyName.separator)[1].isFileDocType() {
//                        multiPart.append(value, withName: keyName.fileName, fileName: file[index], mimeType: MimeTypes.pdf)
//                    } else {
//                        multiPart.append(value, withName: keyName.fileName, fileName: file[index], mimeType: MimeTypes.image)
//                    }
//                }
//            }
//
//            // SwiftLoader.show(title: keyName.loading, animated: true)
//        }, to: apiURL, method: .post, headers: header).response(completionHandler: { response in
//            // SwiftLoader.hide()
//            DispatchQueue.main.async {
//                switch response.result {
//                case .success(let data):
//                    // SwiftLoader.hide()
//                    do {
//                        let dataReceived = try JSONDecoder().decode(T.self, from: data!)
//                        if response.response?.statusCode != 401 {
//                            completionHandler(dataReceived, nil, response.response?.statusCode)
//                        } else {
//                            objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
//                            print("Token Expire")
//                        }
//
//
//                    } catch let jsonError {
//                        completionHandler(nil, jsonError, response.response?.statusCode)
//                    }
//                case .failure(let error):
//                    // // SwiftLoader.hide()
//                    logd(v: error.localizedDescription)
//                    completionHandler(nil, error, response.response?.statusCode)
//                }
//            }
//        })
//    }
//
//
////MARK : Upload document and Image multipart
       class func uploadDocumentOrImage< T: Decodable>(responseType: T.Type, params: [String: Any]? = nil, mimeType: String? = nil, filesData: [Data]? = nil,filesName: [String]? = nil, completionHandler: @escaping (T?, Error?,Int?) -> Void) {


           let urlString = getURL(type: responseType)
           debugPrint("urlString == \(urlString)")
           let apiURL = URL(string: "https://review-api.loomfashion.co.in/api/upload/image")!

           //https://review-api.loomfashion.co.in/api/upload/image

           let token = THUserDefaultValue.authToken
           print("Token===\(token)")
           var  headers = HTTPHeaders()
           
           if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
               print("Token from UserDefaults: \(savedToken)")
               headers = [
                   "accesstoken": "\(savedToken)", // or just use "accesstoken": accessToken if that's what your API expects
               ]
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
                      
                           multiPart.append(value, withName: keyName.fileName, fileName: "images", mimeType:MimeTypes.image)
                       
                   }
               }

               // // SwiftLoader.show(title: "Uploading..", animated: true)
           }, to: apiURL, method: .post, headers: headers).response(completionHandler: { response in
               // // SwiftLoader.hide()
//               DispatchQueue.main.async {
                   switch response.result {
                   case .success(let data):
                       // // SwiftLoader.hide()
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
                       // // SwiftLoader.hide()
                       logd(v: error.localizedDescription)
                       completionHandler(nil, error, response.response?.statusCode)
                   }
//               }
           })
       }

    
    class func uploadDocumentOrImageContactUs< T: Decodable>(responseType: T.Type, params: [String: Any]? = nil, mimeType: String? = nil, filesData: [Data]? = nil,filesName: [String]? = nil, completionHandler: @escaping (T?, String?,Error?,Int?) -> Void) {


        let urlString = getURL(type: responseType)
        debugPrint("urlString == \(urlString)")
        let apiURL = URL(string: urlString)!

        var token = String()
        if let auth = THUserDefaultValue.authToken {
            token = auth
        }

        var header = HTTPHeaders()
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                header = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            let abc = HTTPHeader(name: THconstant.headerContentTypeName, value: keyName.apiMultiformHeader)
            if token != keyName.emptyStr {
                header = [ "Authorization": "Bearer \(String(describing: token))"]
                header.add(abc)
            } else {
                header.add(abc)
            }

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
//                    if file[index].components(separatedBy: keyName.separator)[1].isFileDocType() {
//                        multiPart.append(value, withName: keyName.fileName, fileName: file[index], mimeType: MimeTypes.pdf)
//                    } else {
                        multiPart.append(value, withName: keyName.fileName, fileName: file[index], mimeType:MimeTypes.image)
                   // }
                }
            }

            // // SwiftLoader.show(title: "Uploading..", animated: true)
        }, to: apiURL, method: .post, headers: header).response(completionHandler: { response in
            // // SwiftLoader.hide()
//               DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    // // SwiftLoader.hide()
                    do {
                        if data != nil{

//                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                             print(jsonResponse as! NSDictionary)
//                          //  let msg = jsonResponse["message"]
//
//                          //  let jsonP = jsonResponse["result"] as! [Any]
//                                        for jsonL in jsonResponse  as! NSDictionary {
//                                            let message = jsonL["message"]!
//                                        }
//
//
                            let dataReceived = try JSONDecoder().decode(T.self, from: data!)
                            if response.response?.statusCode != 401 {
                                completionHandler(dataReceived, "mes",nil, response.response?.statusCode)
                            } else {
                                objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                                print("Token Expire")
                            }

                        }

                    } catch let jsonError {
                        completionHandler(nil, "mes",jsonError, response.response?.statusCode)
                    }
                case .failure(let error):
                    // // SwiftLoader.hide()
                    logd(v: error.localizedDescription)
                    completionHandler(nil, "mes",error, response.response?.statusCode)
                }
//               }
        })
    }
 
    //MARK: post API
    class func postPatch<T: Decodable, Q: Encodable>(requestBody: Q?, responseType: T.Type, progressView: UIView? = nil, type: Int? = nil, id: Int? = nil,editId: String? = nil, completionHandler: @escaping (T?, Error?,String) -> Void) {
        
        var urlString = keyName.emptyStr
        urlString = getURL(type: responseType)
        switch responseType {
        case _ as EditAddressResponse.Type :
            urlString = getURL(type: responseType) + (editId ?? "")
        case _ as UserProfileResponse.Type :
            urlString = getURL(type: responseType)
        case _ as CartUpdateResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/cart/crt/update_item/" + (editId ?? "")
            
            
        default:
            urlString = getURL(type: responseType)
        }

        let token = THUserDefaultValue.authToken
        print("Token===\(token)")
        var  headers = HTTPHeaders()
        
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
                print("Token from UserDefaults: \(savedToken)")
                headers = [
                    "accesstoken": "\(savedToken)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        }
        
        

        AF.request(urlString, method: .patch, parameters: requestBody, encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: 200 ..< 700).responseData { response in
         //   DispatchQueue.main.async {
                // SwiftLoader.hide()

           

                switch response.result {
                case .success(let data):
                    do {
                   
                        let statusCode = response.response?.statusCode
                        if(statusCode == 200 || statusCode == 201 ) {
                            let dataReceived1 = try JSONDecoder().decode(T.self, from: data)
                             
                             print("dataReceived1==\(dataReceived1)")

                             if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                                 completionHandler(dataReceived1 , nil, "")
                             } else {
                                // objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                                 print("Token Expire")
                             }
                        } else {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            //completionHandler(jsonResponse.message as? T, jsonError)
                            print(jsonResponse as! NSDictionary)
                            let objdata = jsonResponse as! NSDictionary
                            completionHandler(nil,nil,objdata["message"] as! String)

                        }
                        
                        
                        
                        
                        
                        
                     
                        
                        
                    } catch let jsonError {
                        completionHandler(nil, jsonError, "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error, "")
                }
          //  }
        }
    }
    
//MARK: Get API
//    //let headers: HTTPHeaders = [
//    "Accept": "application/json"
//]
   
    class func getApiGoogleAPI1< T: Decodable>(responseType: T.Type, header: [String: Any]? = nil, id: Int? = nil,idStr: String? = nil,page: String? = nil,limit: String? = nil, subcategoryId:String? = nil, tagValue: String? = nil, bodyPart_id: String? = nil, params:[String: Any]? = nil, phoneNo: String? = nil,
                                     progressView: UIView? = nil,community_id:String? = nil, completionHandler: @escaping (T?, Error?) -> Void) {
        
        var urlString = getURL(type: responseType)
        switch responseType {
        case _ as GeocodeResponse.Type :
            if let subcategoryId = subcategoryId {
                
                urlString = "https://user-api.loomfashion.co.in/auth_user/user/get_addresses_by_pincode/\(subcategoryId)"
                //urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(subcategoryId)&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
            }
      
        default:
            urlString = getURL(type: responseType)
        }
        debugPrint("BaseURL == \(urlString)")
        var  headers = HTTPHeaders()
        headers = [
                "Accept": "application/json"
        ]
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: { response in
            DispatchQueue.main.async {
                print(response)
                
                switch response.result {
                case .success(let data):
                    do {
                        let dataReceived = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(dataReceived, nil)
                    } catch let jsonError {
                        //self.decodeSubcategoryResponse(from: data)
                        completionHandler(nil, jsonError)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    
                    completionHandler(nil, error)
                }
                
            }
        })
        
    }
    
    class func getApiGoogleAPI< T: Decodable>(responseType: T.Type, header: [String: Any]? = nil, id: Int? = nil,idStr: String? = nil,page: String? = nil,limit: String? = nil, subcategoryId:String? = nil, tagValue: String? = nil, bodyPart_id: String? = nil, params:[String: Any]? = nil, phoneNo: String? = nil,
                                     progressView: UIView? = nil,community_id:String? = nil, completionHandler: @escaping (T?, Error?) -> Void) {
        
        var urlString = getURL(type: responseType)
        switch responseType {
        case _ as GeocodeResponse.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(subcategoryId)&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
            }
        case _ as PincodeResponse.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://api.postalpincode.in/pincode/\(subcategoryId)"
            }
        default:
            urlString = getURL(type: responseType)
        }
        debugPrint("BaseURL == \(urlString)")
        var  headers = HTTPHeaders()
        headers = [
                "Accept": "application/json"
        ]
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: headers).responseData(completionHandler: { response in
            DispatchQueue.main.async {
                print(response)
                
                switch response.result {
                case .success(let data):
                    do {
                        let dataReceived = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(dataReceived, nil)
                    } catch let jsonError {
                        //self.decodeSubcategoryResponse(from: data)
                        completionHandler(nil, jsonError)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    
                    completionHandler(nil, error)
                }
                
            }
        })
        
    }

    
    class func getApi< T: Decodable>(responseType: T.Type, header: [String: Any]? = nil, id: Int? = nil,idStr: String? = nil,page: String? = nil,limit: String? = nil, subcategoryId:String? = nil, tagValue: String? = nil, MaxPrice:Double = 0.0,MinPrice:Double = 0.0 ,bodyPart_id: String? = nil, params:[String: Any]? = nil, phoneNo: String? = nil, sortBy: String? = nil,
                                     progressView: UIView? = nil,community_id:String? = nil, completionHandler: @escaping (T?, Error?) -> Void) {
        
        var urlString = getURL(type: responseType)
        
        switch responseType {
        case _ as GeocodeResponse.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(subcategoryId)&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
            }
        case _ as GeocodeResponse.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(subcategoryId)&key=AIzaSyDj3h6PfNK3lNIIsWRhtsprgvH1ouV-B6o"
            }
        case _ as AddressResponseList.Type :
            urlString = getURL(type: responseType)
        case _ as CartResponse.Type :
            urlString = "https://cart-api.loomfashion.co.in/cart/crt/get_cart"
        case _ as BannerResponse.Type :
            urlString = "https://admin-api.loomfashion.co.in/api/user/banners"
        case _ as OrderResponselisting.Type :
            urlString = "https://order-api.loomfashion.co.in/order/check/order_item"
        case _ as OrderItemDetailResponse.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://order-api.loomfashion.co.in/order/check/order_item_details/\(subcategoryId)"
            }
            //&page=1&limit=20
        case _ as ReviewResponse123.Type :
            if let subcategoryId = subcategoryId {
                urlString = "https://review-api.loomfashion.co.in/api/review/product/\(subcategoryId)"
            }
        case _ as ProductListResponse.Type :
            if let subcategoryId = subcategoryId {
                if let page = page {
                    if let limit = limit {
                        urlString = "https://product-api.loomfashion.co.in/product/admin/prod/searchAnything?query=\(subcategoryId)" + "&page=" + "\(page)" + "&limit=" + "\(limit)"
                    }
                }

            }
            
        case _ as UserResponse.Type :
            urlString = getURL(type: responseType)
        case _ as ApiResponse.Type :
            if let userId = subcategoryId {
                if let page = page {
                    if let limit = limit {
                        urlString = THconstant.baseurlTemp + "cat_sub/get_sucategories_user"
                        urlString = urlString + "?subcategoryId=" + "\(userId)" + "&page=" + "\(page)" + "&limit=" + "\(limit)"
                        print("urlString--\(urlString)")
                    }
                }
            }
       
        case _ as ProductResponse.Type :
            
            if tagValue == "new" || tagValue == "hot-selling" {
                if let tagValue = tagValue {
                    urlString = "https://product-api.loomfashion.co.in/product/admin/prod/getproductbyTag?tag=" + "\(tagValue)"  + "&minPrice=" + "\(MinPrice)" + "&maxPrice=" + "\(MaxPrice)"
                    //+ "?&page=" + "\(page ?? "")" + "&limit=" + "\(limit ?? "")"
                }
            } else {
                if let userId = idStr {
                    if subcategoryId == "" {
                        urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/"
                        urlString = urlString + "\(userId)" + "?sort=" + "\(sortBy ?? "")" + "&page=" + "\(page ?? "")" + "&limit=" + "\(limit ?? "")"  + "&minPrice=" + "\(Int(MinPrice))" + "&maxPrice=" + "\(Int(MaxPrice))"
                    } else {
                        if let subcategoryId = subcategoryId {
                            urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/"
                            urlString = urlString + "\(userId)?" + "\(subcategoryId)" + "&sort=" + "\(sortBy ?? "")" + "&minPrice=" + "\(MinPrice)" + "&maxPrice=" + "\(MaxPrice)"
                            
                           // urlString = urlString + "\(userId)?" + "&sort" + "\(sortby)" + "&minPrice=" + "\(MinPrice)" + "&maxPrice=" + "\(MaxPrice)"
                        }
                    }
                }
            }
          
            
            
            
        case _ as ProductResponse.Type :
            if let userId = idStr {
                if subcategoryId == "" {
                    urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/"
                    urlString = urlString + "\(userId)" + "?&page=" + "\(page ?? "")" + "&limit=" + "\(limit ?? "")"
                } else {
                    if let subcategoryId = subcategoryId {
                        urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/"
                        urlString = urlString + "\(userId)?" + "\(subcategoryId)"
                    }
                }
                   
                
            }
        case _ as ProductResponse1.Type :
            if let userId = idStr {
                urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/"
                if let tagValue = tagValue {
                    urlString = urlString + "\(userId)" + "?sort=" + "\(tagValue)"
                }
            }
        case _ as ProductResponsetag.Type :
            if let userId = idStr {
                if let userId = idStr {
                    urlString = THconstant.baseurlTemp + "prod/get_product_BySubcategory3/" + userId
                }
            }
        case _ as ProductDetailResponse.Type :
            if let userId = subcategoryId {
                    urlString = THconstant.baseurlTemp + "prod/product_details/" + userId
                
            }
        case _ as PromoResponse.Type :
                    urlString = "https://admin-api.loomfashion.co.in/api/user/codes"
                
        case _ as SubcategoryResponse.Type :
                    urlString = "https://product-api.loomfashion.co.in/product/admin/cat_sub/get_subcategories?page=1&pageSize=10"
        case _ as WishlistResponse9.Type :
                    urlString = "https://cart-api.loomfashion.co.in/wishlist/getwishlist" + "?&page=" + "\(page ?? "")" + "&limit=" + "\(limit ?? "")"
        case _ as DeliveredOrderReviewResponse.Type :
                    urlString = "https://review-api.loomfashion.co.in/api/review/getmergereview" + "?&page=" + "\(page ?? "")" + "&limit=" + "\(limit ?? "")"
        case _ as WalletPointsResponse.Type :
                    urlString = "https://user-api.loomfashion.co.in/auth_user/wallet/wallet_points_history"
            
  
            
        default:
            urlString = getURL(type: responseType)
        }
        
        debugPrint("BaseURL == \(urlString)")
        
        
        let token = THUserDefaultValue.authToken
        debugPrint("token == \(token)")

        var  headers = HTTPHeaders()
        
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
                headers = [
                    "accesstoken": "\(savedToken)",
                ]
            }
        }
        
        
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: headers).responseData(completionHandler: { response in
            DispatchQueue.main.async {
                print(response)
                
                switch response.result {
                case .success(let data):
                    do {
                        let dataReceived = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(dataReceived, nil)
                    } catch let jsonError {
                        print(jsonError)
                        //self.decodeSubcategoryResponse(from: data)
                        completionHandler(nil, jsonError)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    
                    completionHandler(nil, error)
                }
                
            }
        })
        
    }

   class func decodeSubcategoryResponse(from data: Data) -> ProductResponse? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ProductResponse.self, from: data)
            return response
        } catch {
            print("Decoding error:", error)
            return nil
        }
    }
    
//    func decodeProductResponse(from jsonData: Data) -> ProductResponse? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase // Optional, if keys were snake_case
//
//        do {
//            let response = try decoder.decode(ProductResponse.self, from: jsonData)
//            return response
//        } catch {
//            print("Decoding failed with error: \(error)")
//            return nil
//        }
//    }
    
    
     //MARK: put API
    
    class func putAPICall<T: Decodable, Q: Encodable>(requestBody: Q?, responseType: T.Type, completionHandler: @escaping (T?, Error?) -> Void) {

        let urlString = getURL(type: responseType)
      
     
        print("urlString == \(urlString)")
        

        let token = THUserDefaultValue.authToken
        var headers = HTTPHeaders()
        
        
        
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            if let accessToken = token {
                headers = [.authorization(bearerToken: accessToken)]
            }
        }
        
        
       

        // SwiftLoader.show(title: keyName.loading, animated: true)
        AF.request(urlString, method: .put, parameters: requestBody, encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: 200 ..< 700).responseData { response in
           // DispatchQueue.main.async {
                // SwiftLoader.hide()
                switch response.result {
                case .success(let data):
                    do {
                        let dataReceived = try JSONDecoder().decode(T.self, from: data)
                        if response.response?.statusCode != 401 {
                            completionHandler(dataReceived, nil)
                        } else {
                            objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                            print("Token Expire")
                        }
              
                    } catch let jsonError {
                        completionHandler(nil, jsonError)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil, error)
                }
            }
        //}
    }

    class func deleteAPICall<T: Decodable>(responseType: T.Type,id: String? = nil, completionHandler: @escaping (T?, Error?) -> Void) {

        var urlString = getURL(type: responseType)

        switch responseType {
        case _ as AddressDeleteResponse.Type :
            urlString = getURL(type: responseType)
            if let userId = id {
                urlString = urlString + "/" + "\(userId)"
                }
        case _ as DeleteAccountResponse.Type :
            urlString = getURL(type: responseType)
                
            
        case _ as CartRemovalResponse.Type :
            urlString = getURL(type: responseType)
            if let userId = id {
                urlString = "https://cart-api.loomfashion.co.in/cart/crt/delete_item/" + "\(userId)"
                }
        case _ as RemoveWishlistResponse.Type :
            urlString = getURL(type: responseType)
            if let product = id {
                urlString = "https://cart-api.loomfashion.co.in/wishlist/removefromwishlist/" + "\(product)"
                }
            
            
        default:
             urlString = getURL(type: responseType)
        }
        
            //https://cart-api.loomfashion.co.in/health
        
        
        
        //CartRemovalResponse AddressDeleteResponse
        print("urlString == \(urlString)")
        let token = THUserDefaultValue.authToken
        print("Token===\(token)")
        var  headers = HTTPHeaders()
        
        
        
        
        let tempToken = THUserDefaultValue.authTokenTemp
        if tempToken != nil {
            if let tempToken1 = THUserDefaultValue.authTokenTemp {
                headers = [
                    "x-guest-id": "\(tempToken1)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        } else {
            if  let savedToken = UserDefaults.standard.string(forKey: "accessToken") {
                print("Token from UserDefaults: \(savedToken)")
                headers = [
                    "accesstoken": "\(savedToken)", // or just use "accesstoken": accessToken if that's what your API expects
                ]
            }
        }
        
        
        
        
       

        

        // SwiftLoader.show(title: keyName.loading, animated: true)
        AF.request(urlString, method: .delete, headers: headers)
            .validate(statusCode: 200 ..< 700)
            .responseData { response in
                DispatchQueue.main.async {
                    // SwiftLoader.hide()
                    switch response.result {
                    case .success(let data):
                        do {
                            let dataReceived = try JSONDecoder().decode(T.self, from: data)
                            if response.response?.statusCode != 401 {
                                completionHandler(dataReceived, nil)
                            } else {
                                objc.showAlert(title: keyName.sessionTitle, message: keyName.sessionMessage)
                                print("Token Expired")
                            }
                        } catch let jsonError {
                            completionHandler(nil, jsonError)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completionHandler(nil, error)
                    }
                }
            }
    }

}

extension Data {
    /// Append string to Data
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    /// - parameter string:       The string to be added to the `Data`.
    mutating func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8,
                                  allowLossyConversion: true) {
            append(data)
        }
    }
}

var objc = THApiHandler()
extension THApiHandler{
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: keyName.ok, style: .default, handler: { action in
            NotificationCenter.default.post(name: Notification.Name("tokenExpire"), object: nil)
                                        })
        alert.addAction(ok)
        // Get the window's root view controller
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}
 


/**{
 "success": false,
 "message": "Invalid OTP",
 "data": []
}**/
extension String {
    var capitalizedFirstLetter: String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
}
