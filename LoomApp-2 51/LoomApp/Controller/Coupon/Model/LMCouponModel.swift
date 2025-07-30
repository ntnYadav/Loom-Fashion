//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation

struct PromoResponse: Codable {
    let success: Bool
    let message: String
    let data: PromoData
}

struct PromoData: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let results: [PromoCode]
}

struct PromoCode: Codable {
    let id: String
    let code: String
    let description: String
    let discountType: String
    let discountValue: Int
    let minimumPurchase: Int
    let validFor: String
    let isActive: Bool
    let expiryDate: String
    let startDate: String
    let createdAt: String
    let updatedAt: String
    let title: String
    let codeType:String

    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code, description, discountType, discountValue, minimumPurchase, validFor, isActive, expiryDate, startDate, createdAt, updatedAt, title, codeType
    }
}
