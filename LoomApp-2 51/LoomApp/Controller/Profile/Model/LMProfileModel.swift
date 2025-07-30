//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation

struct UserResponse: Codable {
    let success: Bool?
    let message: String?
    let data: Userprofile?
}

struct Userprofile: Codable {
      let id: String?
      let name: String?
      let email: String?
      let phoneNumber: String?
      let dob: String?
      let gender: String?
      let anniversary: String?
      let stylePreference: [String]?
      let addresses: [String]?
      let searches: [String]?
      let isBlocked: Bool?
      let deviceType: String?
      let accesstoken: String?
      let deviceToken: String?
      let loginCount: Int?
      let totalTimeSpent: Int?
      let averageTimeSpent: Int?
      let createdAt: String?
      let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber
        case dob, anniversary, gender
        case stylePreference = "style_preference"
        case addresses, searches, isBlocked, deviceType
        case accesstoken, deviceToken, loginCount, totalTimeSpent, averageTimeSpent
        case createdAt, updatedAt
    }
}
//////
///
///    private  func callUpdateApi(name:String,phoneNo:String,email:String,dob:String,anniversary:String,gender:String,style:String) {

struct ProfileUpdate: Codable {
let dob: String?
let anniversary: String?
let gender: String?
let style_preference:[String]?
}
////Upsdate profile
///

struct UserProfileResponse: Codable {
    let success: Bool?
    let message: String?
    let data: UserProfile?
}

struct UserProfile: Codable {
    let id: String?
    let name: String?
    let email: String?
    let phoneNumber: String?
    let stylePreference: [String]?
    let addresses: [String]?
    let searches: [String]?
    let isBlocked: Bool?
    let deviceType: String?
    let deviceToken: String?
    let loginCount: Int?
    let totalTimeSpent: Int?
    let averageTimeSpent: Int?
    let createdAt: String?
    let updatedAt: String?
    let accesstoken: String?
    let dob: String?
    let anniversary: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, stylePreference = "style_preference"
        case addresses, searches, isBlocked, deviceType, deviceToken
        case loginCount, totalTimeSpent, averageTimeSpent
        case createdAt, updatedAt, accesstoken, dob, anniversary, gender
    }
}

