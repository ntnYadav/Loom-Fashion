//
//  Register.swift
//  SafeTalk
//
//  Created by SafeTalk on 11/10/22.
//

import Foundation

// MARK: - Welcome
struct Login: Codable {
    let statusCode: Int?
        let message,token: String?
        let userDetails: userDetailsLogin?
}

//struct Login: Codable {
//    let success: Bool
//    let message, data: String
//}


// MARK: - UserDetails
struct userDetailsLogin: Codable {
    let userID: Int
    let name, email, phoneNumber, user_type,otpStatus: String?
    let password, device, accessToken, refreshToken: String
    let accessTokenTime, refreshTokenTime: String
    let admin, isActive, loginActive: Bool
    let createdDate, updatedDate: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, email, phoneNumber,otpStatus
        case user_type = "user_type"
        case password, device, accessToken, refreshToken, accessTokenTime, refreshTokenTime, admin, isActive, loginActive, createdDate, updatedDate
    }
}
