//
//  ResendOTPModel.swift
//  TouringHealth
//
//  Created by chetu on 19/10/22.
//

import Foundation

// MARK: - ResendOTPBody
struct ResendOTPBody: Codable {
    let email : String
}

// MARK: - ResendOTPResponse
struct ResendOTPResponse: Codable {
    let message: String
    let status: Bool
    let statusCode: Int
    let data: DataResendOTP?
}


// MARK: - DataClass
struct DataResendOTP: Codable {
   
}
