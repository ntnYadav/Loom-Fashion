//
//  LoginModel.swift
//  TouringHealth
//
//  Created by chetu on 20/10/22.
//

import Foundation

// MARK: - LoginBody
struct LoginModelBody: Codable {
    let phoneNumber: String
    let isResend: Bool

}


struct LoginModelBodySuggestUser: Codable {
    let guestId: String
}

// MARK: - Welcome
//struct LoginModelResponse: Codable {
//    let success: Bool
//    let message, data: String
//}

struct DeleteAccountResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [String: String]?
}
struct LoginModelResponse: Codable {
    let success: Bool?
    let message: String?
    let data: OTPData?
}

struct OTPData: Codable {
    let otp: String?
}




// MARK: - LoginResponse
struct LoginModelResponse1: Codable {
    let message: String?
    let status: Bool?
    let data: Data?
}

// MARK: - DataClass
struct DataLogin: Codable {
    let id: Int
    let name: String?
    let email: String
    let emailVerifiedAt: String?
    let roleID, membershipID, invitationID: Int
    let createdAt, updatedAt: String
    let gender, dob: String?
    let active: Int
    let updatedBy: String?
    let otpVerified: Int
    let otpExpiryTime: String

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

// MARK: - Result
struct Result: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

//UPDATED model file
// MARK: - Welcome
//struct LoginModelResponse: Codable {
//    let message: String
//    let status: Bool
//    let statusCode: Int
//    let result: Result?
//    let data: DataLogin?
//}
//
//// MARK: - DataClass
//struct DataLogin: Codable {
//    let id: Int
//    let name: String?
//    let email: String
//    let emailVerifiedAt: String?
//    let roleID, membershipID, invitationID: Int
//    let createdAt, updatedAt: String
//    let gender, dob: String?
//    let active: Int
//    let updatedBy: String?
//    let otpVerified: Int
//    let otpExpiryTime: String
//    let lastName, phoneNumber, countryCode: String?
//    let deleted: Int
//    let deletedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, email
//        case emailVerifiedAt = "email_verified_at"
//        case roleID = "role_id"
//        case membershipID = "membership_id"
//        case invitationID = "invitation_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case gender, dob, active
//        case updatedBy = "updated_by"
//        case otpVerified = "otp_verified"
//        case otpExpiryTime = "otp_expiry_time"
//        case lastName = "last_name"
//        case phoneNumber = "phone_number"
//        case countryCode = "country_code"
//        case deleted
//        case deletedAt = "deleted_at"
//    }
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let tokenType, expiresIn, accessToken, refreshToken: String
//
//    enum CodingKeys: String, CodingKey {
//        case tokenType = "token_type"
//        case expiresIn = "expires_in"
//        case accessToken = "access_token"
//        case refreshToken = "refresh_token"
//    }
//}
//
import Foundation

// MARK: - Root Response
struct OTPResponse: Codable {
    let success: Bool?
    let message: String?
    let data: OTPDataData?
}

// MARK: - Data
struct OTPDataData: Codable {
    let token: String?
    let user: UserOTP?
    let isNewUser: Bool?
}

// MARK: - User
struct UserOTP: Codable {
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
    let devices: [String]?
    let loginCount: Int?
    let totalTimeSpent: Int?
    let averageTimeSpent: Int?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, dob, anniversary, gender
        case stylePreference = "style_preference"
        case addresses, searches, isBlocked, isDeleted, deviceType
        case accesstoken, amountSpent, orderCount, loyaltyPoints
        case isEmailVerified, isPhoneVerified, deviceToken, devices
        case loginCount, totalTimeSpent, averageTimeSpent, createdAt, updatedAt
    }
}
