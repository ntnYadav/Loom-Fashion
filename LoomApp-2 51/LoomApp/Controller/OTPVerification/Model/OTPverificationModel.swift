//
//  OTPverificationModel.swift
//  TouringHealth
//
//  Created by chetu on 18/10/22.
//

import Foundation

// MARK: - OTPverificationBody
struct OTPverificationBody: Codable {
    let phoneNumber, otp: String
    let deviceType: String
    let deviceToken: String
}
struct OTPverificationBody1: Codable {
    let phoneNumber, otp: String
  
}
//// MARK: - PostDetailsModel
//struct OTPverificationResponse: Codable {
//    let message: String
//    let status: Bool
//    let statusCode: Int
//    let data: DataOTPverification?
//}

//struct OTPVerifyResponse: Codable {
//    let success: Bool
//    let message: String
//    let data: OTPVerifyData?
//}
//
//struct OTPVerifyData: Codable {
//    let phoneNumber: String
//    let isNewUser: Bool
//}


struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let data: LoginData
}

struct LoginData: Codable {
    let token: String
    let user: User
    let isNewUser: Bool
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let phoneNumber: String
    let stylePreference: [String]
    let addresses: [String]
    let searches: [String]
    let isBlocked: Bool
    let deviceType: String
    let deviceToken: String
    let loginCount: Int
    let totalTimeSpent: Int
    let averageTimeSpent: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, stylePreference = "style_preference", addresses, searches,
             isBlocked, deviceType, deviceToken, loginCount, totalTimeSpent, averageTimeSpent,
             createdAt, updatedAt
    }
}




// MARK: - ResponseForgetPasswordOTP
struct ResponseForgetPasswordOTP: Codable {
    let message: String?
    let status: Bool?
    let statusCode: Int?
    let data: ForgetPasswordOTPData?
}

// MARK: - DataClass
struct ForgetPasswordOTPData: Codable {
    let id: Int
    let name: String?
    let email: String
    let emailVerifiedAt: String?
    let roleID, membershipID, invitationID: Int?
    let createdAt, updatedAt: String?
    let gender, dob: String?
    let active: Int?
    let updatedBy: String?
    let otpVerified: Int?
    let otpExpiryTime: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case roleID = "role_id"
        case membershipID = "membership_id"
        case invitationID = "invitation_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gender, dob, active
        case updatedBy = "updated_by"
        case otpVerified = "otp_verified"
        case otpExpiryTime = "otp_expiry_time"
    }
}




import Foundation

struct OTPLoginResponse: Codable {
    let success: Bool?
    let message: String?
    let data: OTPLoginData?
}

struct OTPLoginData: Codable {
    let token: String?
    let user: OTPUser?
    let isNewUser: Bool?
    let userBag: UserBag?

}
struct UserBag: Codable {
    let cartCount: Int?
    let wishlistCount: Int?
}
struct OTPUser: Codable {
    let defaultAddressSnapshot: AddressSnapshot?
    let id: String?
    let name: String?
    let email: String?
    let phoneNumber: String?
    let dob: String?
    let anniversary: String?
    let gender: String?
    let stylePreference: [String]?
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
    let devices: [UserDevice]?
    let loginCount: Int?
    let totalTimeSpent: Int?
    let averageTimeSpent: Int?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case defaultAddressSnapshot
        case id = "_id"
        case name, email, phoneNumber, dob, anniversary, gender
        case stylePreference = "style_preference"
        case addresses, searches, isBlocked, isDeleted, deviceType, accesstoken
        case amountSpent, orderCount, loyaltyPoints, isEmailVerified, isPhoneVerified
        case deviceToken, devices, loginCount, totalTimeSpent, averageTimeSpent, createdAt, updatedAt
    }
}

struct AddressSnapshot: Codable {
    let id: String?
    let city: String?
    let state: String?
    let pinCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case city, state, pinCode
    }
}

struct UserDevice: Codable {
    let deviceToken: String?
    let deviceType: String?
    let browserName: String?
    let lastLoggedIn: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case deviceToken, deviceType, browserName, lastLoggedIn
        case id = "_id"
    }
}
