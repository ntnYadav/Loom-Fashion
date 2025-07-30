//
//  SFUserDefaultData.swift
//  Scrowbly-FINT
//
//  Created by chetu on 26/08/22.
//

import Foundation
import UIKit

class THUserDefaultValue {

    static let userDefault =  UserDefaults.standard

    static var authToken: String? {
        set {
            userDefault.setValue(newValue, forKey: "")
        }
        get {
            return userDefault.string(forKey: "")
        }
    }
    
    
    static var authTokenTemp: String? {
        set {
            userDefault.setValue(newValue, forKey: "authTokenTemp")
        }
        get {
            return userDefault.string(forKey: "authTokenTemp")
        }
    }
    
    
    static var userdateCurrentDate: String? {
        set {
            userDefault.set(newValue, forKey: "CurrentDate")
        }
        get {
            return userDefault.string(forKey: "CurrentDate")
        }
    }
    
    static var userpincodeSecond: String? {
        set {
            userDefault.set(newValue, forKey: "userpincodeSecond")
        }
        get {
            return userDefault.string(forKey: "userpincodeSecond")
        }
    }
    
    static var userdatefrmate :String? {
        set {
            return userDefault.set(newValue, forKey: "userdateformate")
        }
        get {
            return userDefault.string(forKey: "userdateformate")
        }
    }
    
    static var userdateDays :String? {
        set {
            return userDefault.set(newValue, forKey: "userdateDays")
        }
        get {
            return userDefault.string(forKey: "userdateDays")
        }
    }
    
    
    static var isUsercolorsize: String? {
        set {
            userDefault.setValue(newValue, forKey: "iscolorsize")
        }
        get {
            return userDefault.string(forKey: "iscolorsize")
        }
    }
    static var isUserPincode: String? {
        set {
            userDefault.setValue(newValue, forKey: "isUserPincode")
        }
        get {
            return userDefault.string(forKey: "isUserPincode")
        }
    }
    static var isUserLoging :Bool {
        set {
            return userDefault.set(newValue, forKey: "isLogin")
        }
        get {
            return userDefault.bool(forKey: "isLogin")
        }
    }

    static var isUserScrolling :Bool {
        set {
            return userDefault.set(newValue, forKey: "isUserScrolling")
        }
        get {
            return userDefault.bool(forKey: "isUserScrolling")
        }
    }
    
    static var isUserPincodeLoging :Bool {
        set {
            return userDefault.set(newValue, forKey: "isPincodeLogin")
        }
        get {
            return userDefault.bool(forKey: "isPincodeLogin")
        }
    }
    
    static var isUserSize :Bool {
        set {
            return userDefault.set(newValue, forKey: "isSize")
        }
        get {
            return userDefault.bool(forKey: "isSize")
        }
    }
    
    static var fromLogout :Bool {
        set {
            return userDefault.set(newValue, forKey: "logut")
        }
        get {
            return userDefault.bool(forKey: "logut")
        }
    }
    
    
    static var userEmail :String? {
        set {
            return userDefault.set(newValue, forKey: "userEmail")
        }
        get {
            return userDefault.string(forKey: "userEmail")
        }
    }
    
    
    static var userFirstName :String? {
        set {
            return userDefault.set(newValue, forKey: "userFirstName")
        }
        get {
            return userDefault.string(forKey: "userFirstName")
        }
    }
    
    static var userLastName :String? {
        set {
            return userDefault.set(newValue, forKey: "userLastName")
        }
        get {
            return userDefault.string(forKey: "userLastName")
        }
    }
    
    static var userDeviceToken :String? {
        set {
            return userDefault.set(newValue, forKey: "userDeviceToken")
        }
        get {
            return userDefault.string(forKey: "userDeviceToken")
        }
    }
    
    
    static var userPassword :String? {
        set {
            return userDefault.set(newValue, forKey: "userPassword")
        }
        get {
            return userDefault.string(forKey: "userPassword")
        }
    }
    
    static var userID :Int? {
        set {
            return userDefault.set(newValue, forKey: "userID")
        }
        get {
            return userDefault.integer(forKey: "userID")
        }
    }
    
    static var userBagCount :Int? {
        set {
            return userDefault.set(newValue, forKey: "userBagCount")
        }
        get {
            return userDefault.integer(forKey: "userBagCount")
        }
    }
    
    static var userwishlistCount :Int? {
        set {
            return userDefault.set(newValue, forKey: "userwishlistCount")
        }
        get {
            return userDefault.integer(forKey: "userwishlistCount")
        }
    }
    
    static var phoneNumber:String?{
        set{
            return userDefault.set(newValue, forKey: "phoneNumber")
        }
        get{
            return userDefault.string(forKey: "phoneNumber")
        }
    }
    static var imgURL:String?{
        set{
            return userDefault.set(newValue, forKey: "imageURL")
        }
        get{
            return userDefault.string(forKey: "imageURL")
        }
    }
  
}   //Class ends here
