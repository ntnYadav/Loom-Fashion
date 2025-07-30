//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation


// MARK: - Root Response
struct CartResponse: Codable {
    let success: Bool?
    let message: String?
    let data: CartDataitem?
}

// MARK: - Cart Data
struct CartDataitem: Codable {

    let id: String?
    let userId: String?
    var items: [CartItemdata]
    let couponDiscount: Double?
    let abandoned: Bool?
    let lastActiveAt: String?
    let createdAt: String?
    let updatedAt: String?
    var pricingSummary: PricingSummary
    let itemCount: Int
    let isPrepaid10Active: Bool?

    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, items, couponDiscount, abandoned, lastActiveAt, createdAt, updatedAt, pricingSummary, itemCount, isPrepaid10Active
    }
}

// MARK: - Cart Item
struct CartItemdata: Codable {
    let productId: String?
    let variantId: String?
    let quantity: Int?
    let priceSnapshot: PriceSnapshotdata
    let inventoryStatus: String?
    let avlVarQnty: Int?
    let remindersSent: Int?
    let recoveryEmailsSent: Int?
    let couponUsed: Bool?
    let lastCheckedAt: String?
    let id: String?
    let shippingOptions: [String]?
    let addedAt: String?
    let productTitle: String?
    let productImage: String?
    var color: String?
    var size: String?
    let valuesTable: String?


    enum CodingKeys: String, CodingKey {
        case productId, variantId, quantity, priceSnapshot, inventoryStatus
        case avlVarQnty = "avl_var_qnty"
        case remindersSent, recoveryEmailsSent, couponUsed, lastCheckedAt,valuesTable
        case id = "_id"
        case shippingOptions, addedAt, productTitle, productImage, color, size
    }
}

// MARK: - Price Snapshot
struct PriceSnapshotdata: Codable {
    let basePrice: Double?
    let sellingPrice: Double?
    let source: String?
}

// MARK: - Pricing Summary
struct PricingSummary: Codable {
    let baseTotal: Double?
    let sellingTotal: Double?
    let savings: Double?
    var couponCode: String?
    var couponDiscount: Double = 0.0
    var payableAmount: Double?
    let deliveryCharge: Double?
    let finalAmount: Double?
    var wallet: Double?
    var coins: Double?
    var sliderValue: Double?
    var coinsFinal: Double?


}

///
//let dummyPriceSnapshot = PriceSnapshotdata(
//    basePrice: 1000.0,
//    sellingPrice: 750.0,
//    source: "variant"
//)
//let dummyCartItem = CartItemdata (
//    productId: "dummy_product_id",
//    variantId: "OtherDetail",
//    quantity: 1,
//    priceSnapshot: dummyPriceSnapshot,
//    inventoryStatus: "IN_STOCK",
//    avlVarQnty: 1,
//    recoveryEmailsSent:true,
//    remindersSent: false,
//    couponUsed: false,
//    lastCheckedAt: "2025-05-20T10:00:00Z",
//    id: "_id",
//    addedAt: "2025-05-20T10:00:00Z",
//    productTitle: "OtherDetail",
//    productImage: "productTitle",
//    recoveryEmailsSent:true,
//    remindersSent: false,
//    shippingOptions: ["string"],
//    color: "",
//    size: "",
//    valuesTable: "productImage"
//)
//




let dummyPriceSnapshot1 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

var dummyCartItem1 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "offer",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot1,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "Blue",
    size: "M",
    valuesTable: nil
)


let dummyPriceSnapshot2 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem2 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "price",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot2,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "Blue",
    size: "M",
    valuesTable: nil
)

let dummyPriceSnapshot3 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem3 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "dummy_variant_id",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot3,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "Blue",
    size: "M",
    valuesTable: nil
)


let dummyPriceSnapshot4 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem4 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "wallet",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot3,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "no",
    size: "no",
    valuesTable: nil
)
let dummyPriceSnapshot5 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem5 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "wallet1",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot3,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "no",
    size: "no",
    valuesTable: nil
)

let dummyPriceSnapshot6 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem6 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "ActiveisPrepaid",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot3,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "no",
    size: "no",
    valuesTable: nil
)
let dummyPriceSnapshot7 = PriceSnapshotdata(
    basePrice: 1000.0,
    sellingPrice: 750.0,
    source: "variant"
)

let dummyCartItem7 = CartItemdata(
    productId: "dummy_product_id",
    variantId: "WithoutLogin",
    quantity: 1,
    priceSnapshot: dummyPriceSnapshot3,
    inventoryStatus: "IN_STOCK",
    avlVarQnty: 1,
    remindersSent: 0,
    recoveryEmailsSent: 0,
    couponUsed: false,
    lastCheckedAt: "2025-05-20T10:00:00Z",
    id: "dummy_id",
    shippingOptions: [],
    addedAt: "2025-05-20T10:00:00Z",
    productTitle: "Dummy Product",
    productImage: "https://example.com/image.jpg",
    color: "no",
    size: "no",
    valuesTable: nil
)

struct CartUpdateResponse: Codable {
    let success: Bool
    let message: String
    let data: CartDataWrapper
}

struct CartDataWrapper: Codable {
    let cart: CartInnerWrapper
}

struct CartInnerWrapper: Codable {
    let cart: CartDataupdate
    let fallbackUsed: Bool
    let message: String
}

struct CartDataupdate: Codable {
    let userId: String
    let items: [CartItemData]
    let couponDiscount: Int
    let abandoned: Bool
    let lastActiveAt: String
    let createdAt: String
    let updatedAt: String
    let id: String
}

struct CartItemData: Codable {
    let recoveryEmailsSent: Int?
    let productId: String
    let variantId: String
    let quantity: Int
    let priceSnapshot: PriceSnapshotData
    let inventoryStatus: String
    let avlVarQnty: Int
    let remindersSent: Int
    let couponUsed: Bool
    let lastCheckedAt: String
    let id: String
    let addedAt: String
    let shippingOptions: [String]?
    let color: String
    let size: String


    enum CodingKeys: String, CodingKey {
        case recoveryEmailsSent
        case productId
        case variantId
        case quantity
        case priceSnapshot
        case inventoryStatus
        case avlVarQnty = "avl_var_qnty"
        case remindersSent
        case couponUsed
        case lastCheckedAt
        case id = "_id"
        case addedAt
        case shippingOptions
        case color
        case size

    }
}

struct PriceSnapshotData: Codable {
    let basePrice: Double
    let sellingPrice: Double
    let source: String
}


struct cartModel: Codable {
    let quantity: Int
 
}


////Remove cart


// MARK: - Root Response
struct CartRemovalResponse: Codable {
    let success: Bool
    let message: String
    let data: CartData1
}

// MARK: - Cart Data
struct CartData1: Codable {
    let userId: String
    let items: [CartItem1]
    let couponDiscount: Double
    let abandoned: Bool
    let lastActiveAt: String
    let createdAt: String
    let updatedAt: String
    let id: String
}

// MARK: - Cart Item
struct CartItem1: Codable {
    let recoveryEmailsSent: Int?
    let productId: String
    let variantId: String
    let quantity: Int
    let priceSnapshot: PriceSnapshot1
    let inventoryStatus: String
    let avlVarQnty: Int
    let remindersSent: Int
    let couponUsed: Bool
    let lastCheckedAt: String
    let _id: String
    let addedAt: String
    let shippingOptions: [String]
    
    enum CodingKeys: String, CodingKey {
        case recoveryEmailsSent
        case productId
        case variantId
        case quantity
        case priceSnapshot
        case inventoryStatus
        case avlVarQnty = "avl_var_qnty"
        case remindersSent
        case couponUsed
        case lastCheckedAt
        case _id
        case addedAt
        case shippingOptions
    }
}

// MARK: - Price Snapshot
struct PriceSnapshot1: Codable {
    let basePrice: Double
    let sellingPrice: Double
    let source: String
}

