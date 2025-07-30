//
//  LoginModel.swift
//  TouringHealth
//
//  Created by chetu on 20/10/22.
//

import Foundation

// MARK: - LoginBody
struct ContactModelBody: Codable {
    let name: String
    let phoneNumber: String
    let email: String
    let deviceType: String
    let deviceToken: String

}


// MARK: - Welcome
//struct LoginModelResponse: Codable {
//    let success: Bool
//    let message, data: String
//}


//struct ContactModelResponse: Codable {
//    let success: Bool
//    let message: String
//    let data: OTPData
//}


struct ContactModelResponse: Codable {
    let success: Bool?
    let message: String?
    let data: UserData?
}

struct UserData: Codable {
    let name: String?
    let email: String?
    let phoneNumber: String?
    let dob: String?
    let anniversary: String?
    let gender: String?
    let style_preference: [String]?
    let addresses: [String]?
    let searches: [String]?
    let isBlocked: Bool?
    let isDeleted: Bool?
    let deviceType: String?
    let accesstoken: String?
    let amountSpent: String?
    let orderCount: String?
    let loyaltyPoints: Int?
    let isEmailVerified: Bool?
    let isPhoneVerified: Bool?
    let deviceToken: String?
    let devices: [DeviceInfo]?
    let loginCount: Int?
    let totalTimeSpent: Int?
    let averageTimeSpent: Int?
    let _id: String?
    let createdAt: String?
    let updatedAt: String?
}

struct DeviceInfo: Codable {
    let deviceToken: String?
    let deviceType: String?
    let browserName: String?
    let lastLoggedIn: String?
    let _id: String?
}
