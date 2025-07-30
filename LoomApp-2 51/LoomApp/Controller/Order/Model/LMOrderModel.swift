//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation

struct CancelOrderItemRequest: Codable {
    let orderId: String
    let itemId: String
    let reason: String
}

struct OrderItemCancelResponse: Decodable {
    let success: Bool?
    let message: String?
}

struct OrderResponselisting: Codable {
    let success: Bool?
    let message: String?
    let data: [Order1]?
}

struct Order1: Codable {
    let orderId: String?
    let orderNumber: String?
    let shortOrderId: String?
    let orderDate: String?
    let sessionExpiry: String?
    let paymentStatus: String?
    let paymentMethod: String?
    let orderStatus: String?
    let shippingAddress: ShippingAddress?
    let itemId: String?
    let variantId: String?
    let productId: String?
    let productTitle: String?
    let productImage: String?
    let size: String?
    let color: String?
    let quantity: Int?
    let itemStatus: String?
    let itemStatusTimestamps: [ItemStatusTimestampData]?
    let priceSnapshot: PriceSnapshotData2?
    let isReplacement: Bool?
}

struct ShippingAddress: Codable {
    let _id: String?
    let name: String?
    let mobile: String?
    let alternateMobile: String?
    let houseNumber: String?
    let area: String?
    let city: String?
    let state: String?
    let pinCode: String?
    let country: String?
}

struct ItemStatusTimestampData: Codable {
    let status: String?
    let timestamp: String?
    let _id: String?
}

struct PriceSnapshotData2: Codable {
    let mrp: Double?
    let sellingPrice: Double?
    let discountAmount: Double?
    let walletCreditUsed: Double?
    let deliveryCharge: Double?
    let couponDiscount: Double?
    let totalAmount: Double?
}
///OrderDetail
///




// MARK: - Root
struct OrderItemDetailResponse: Codable {
    let success: Bool?
    let message: String?
    let data: OrderItemData?
}

// MARK: - Data
struct OrderItemData: Codable {
    let orderId: String?
    let orderNumber: String?
    let shortOrderId: String?
    let orderDate: String?
    let sessionExpiry: String?
    let paymentStatus: String?
    let paymentMethod: String?
    let orderStatus: String?
    let shippingAddress: AddressDetail?
    let billingAddress: AddressDetail?
    let itemId: String?
    let variantId: String?
    let productId: String?
    let productTitle: String?
    let productImage: String?
    let size: String?
    let color: String?
    let quantity: Int?
    var itemStatus: String?
    let itemStatusTimestamps: [ItemStatusTimestampDetail]?
    let priceSnapshot: PriceSnapshotDetail?
    let isReplacement: Bool?
    let otherItems: [OtherItemDetail]?
}

// MARK: - Address
struct AddressDetail: Codable {
    let _id: String?
    let name: String?
    let mobile: String?
    let alternateMobile: String?
    let houseNumber: String?
    let area: String?
    let city: String?
    let state: String?
    let pinCode: String?
    let country: String?
}

// MARK: - Item Status Timestamp
struct ItemStatusTimestampDetail: Codable {
    let status: String?
    let timestamp: String?
    let _id: String?
}

// MARK: - Price Snapshot
struct PriceSnapshotDetail: Codable {
    let mrp: Double?
    let sellingPrice: Double?
    let discountAmount: Double?
    let walletCreditUsed: Double?
    let deliveryCharge: Double?
    let couponDiscount: Double?
    let totalAmount: Double?
}

// MARK: - Other Item
struct OtherItemDetail: Codable {
    let itemId: String?
    let productTitle: String?
    let productImage: String?
    let itemStatus: String?
    let itemStatusTimestamps: [ItemStatusTimestamp]?
}
