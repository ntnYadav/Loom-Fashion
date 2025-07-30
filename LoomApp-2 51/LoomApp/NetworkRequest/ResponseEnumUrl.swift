//
//  ResponseEnumUrl.swift
//  Created by chetu on 29/09/22.
//

import Foundation



enum Domains :String{
    case devlopmentServer = "https://user-api.loomfashion.co.in/"
    case QAserver = "https://TouringHealth-QA.chetu.com/api"
    case UATserver =    "https://uat.thwwwsuccess.com/api"  //"http://52.202.143.198/api"
    case UATproductionserver = "https://thwwwsuccess.com/api"  
}

private var baseUrl: String {
    return THconstant.baseURL
}

func getURL<T: Decodable>(type: T.Type?) -> String {
    var url = ""
    switch type {
    case _ as LoginModelResponse.Type :
        url = "auth_user/auth/send_otp"
    case _ as OTPLoginResponse.Type :
       url = "auth_user/auth/verify_otp"
    case _ as ContactModelResponse.Type :
       url = "auth_user/user/register"
    case _ as AddAddressResponse.Type :
       url = "auth_user/address/create"
    case _ as AddressResponseList.Type :
       url = "auth_user/address/addresses"
    case _ as AddressDeleteResponse.Type :
       url = "auth_user/address/delete"
    case _ as EditAddressResponse.Type :
       url = "auth_user/address/update/"
    case _ as UserResponse.Type :
       url = "auth_user/user/getprofile"
    case _ as UserProfileResponse.Type :
       url = "auth_user/user/update_profile"
    case _ as ApiResponse.Type :
       url = "product/admin/cat_sub/get_sucategories_user"
    case _ as ProductResponse.Type :
       url = "product/admin/cat_sub/get_sucategories_user"
    case _ as AddToCartResponse.Type :
       url = "https://cart-api.loomfashion.co.in/cart/crt/add_item"
    case _ as DeleteAccountResponse.Type :
       url = "auth_user/user/delete_account"
        
        
        
        
    default:
        logd(v: "")
    }
    return baseUrl + url
}


 
