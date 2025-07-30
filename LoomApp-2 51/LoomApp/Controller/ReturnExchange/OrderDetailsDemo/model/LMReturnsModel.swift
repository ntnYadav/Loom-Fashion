//
//  LMReturnsModel.swift
//  LoomApp
//
//  Created by Abdul Quadir on 16/07/25.
//

import Foundation
// MARK: - Root Response
struct ReturnsDetailResponse: Codable {
    let success: Bool?
    let message: String?
}


struct RefundDetails: Codable {
    var upiId: String?
    var bankAccountNumber: String?
    var ifscCode: String?
    var bankName: String?
    var accountHolderName: String?
}

struct ReturnExchangeRequest: Codable {
    let orderId: String
    let orderItemId: String
    let pickupAddress: String
    let images: [String]
    let reason: String
    let comments: String
    let type: String  // "REPLACEMENT" or "REFUND"
    
    // Exchange
    let productId: String
    let replacementVariantId: String
    let deliveryAddress: String
    
    // Refund
    let refundMethod: String
    let refundDetails: RefundDetails
    
    struct RefundDetails: Codable {
        let upiId: String
        let bankAccountNumber: String
        let ifscCode: String
        let accountHolderName: String
    }
}
