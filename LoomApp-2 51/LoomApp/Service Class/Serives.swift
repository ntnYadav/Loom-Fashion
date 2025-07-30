//
//  Serives.swift
//  SafeTalk
//
//  Created by Loom App on 01/04/25.
//

import UIKit

import Alamofire


class Services {
  //  private weak var controller: ClientVc?

    struct URLs{
        
        //Test Url

        //Live Url
        static let BASE_URL = ""

        static let login = "/Login"
        static let registration = "/registration"
        static let Logout = "/Logout"
        static let SignUp = "/SignUp"
    }
    
    public static func getLoginUrl()-> String{
        return URLs.BASE_URL + URLs.login
    }
    public static func getRegistartionUrl() -> String{
        return URLs.BASE_URL + URLs.SignUp
    }
   
    public static func login(token: String,url: String, parameter: [String:String?],completion: @escaping(Login) -> Swift.Void)
    {
        let httpHeader: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .post,
                   parameters: parameter, encoder: JSONParameterEncoder.default, headers: httpHeader
                  ).responseDecodable(of: Login.self, decoder: JSONDecoder()) { response in

                     switch response.result {
                         case .success(let result):
                         completion(result)
                         case .failure(let error):
                       // completion(error)
                         print(error)
                     }
            }
    }
    

}
enum ApiError: Error{
    case serverEroor
    case parsingEror
}
