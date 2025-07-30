//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//
import Foundation

struct DeliveredOrderReviewResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [DeliveredOrderReviewItem]?
}

struct DeliveredOrderReviewItem: Codable {
    let orderId: String?
    let deliveredAt: String?
    let orderItemId: String?
    let productId: String?
    let variantId: String?
    let title: String?
    let image: String?
    let size: String?
    let color: String?
    let quantity: Int?
    let review: DeliveredReviewDetail?
}

struct DeliveredReviewDetail: Codable {
    let id: String?
    let orderId: String?
    let orderItemId: String?
    let rating: Double?
    let comment: String?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case orderId
        case orderItemId
        case rating
        case comment
        case images
    }
}
