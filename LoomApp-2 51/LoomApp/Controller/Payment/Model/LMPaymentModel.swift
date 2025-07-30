//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

struct RazorpayVerificationResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [String: String]? // Use AnyCodable to allow flexible data content
}
struct RazorpayPaymentVerification: Codable {
    let razorpay_order_id: String
    let razorpay_payment_id: String
    let razorpay_signature: String
    let paymentId: String?  // Optional: your internal payment ID
}


struct OrderPayment: Codable {
    let amount: Double
    let orderId: String
    let email: String
    let contact: String
    let paymentmethod: String
    let notes: Notes
}

struct Notes: Codable {
    let name: String
    let product: String
}

struct paymentCODModel: Codable {
    let paymentMethod: String?
    let orderId: String?
    let paymentId:String?
}


struct paymentModel: Codable {
    let couponDiscount: Int
    let addressId: String
    let couponCode:String
    let walletPointsToUse:String
}

struct SoftReservationResponse: Codable {
    let success: Bool
    let message: String
    let data: ReservationData
}

struct ReservationData: Codable {
    let orderId: String
    let shortOrderId: String
    let orderNumber: String
    let expiresIn: Int
    let payableAmount: Double

    enum CodingKeys: String, CodingKey {
        case orderId, shortOrderId, orderNumber, expiresIn
        case payableAmount = "payable_amount"
    }
}

////////////
///
///
///import Foundation

struct OrderResponse: Codable {
    let message: String?
    let order: Order?
}

struct Order: Codable {
    let userSnapshot: UserSnapshot?
    let orderValue: OrderValue?
    let payment: Payment?
    let refundSummary: RefundSummary?
    let promotions: Promotions?
    let id: String?
    let items: [OrderItemOrder]?
    let shippingAddress: Addressdata?
    let billingAddress: Addressdata?
    let shippingIsBilling: Bool?
    let orderStatus: String?
    let source: String?
    let orderDate: String?
    let orderNumber: String?
    let shortOrderId: String?
    let createdAt: String?
    let updatedAt: String?
    let isCancellable: Bool?
    let isReturnable: Bool?

    enum CodingKeys: String, CodingKey {
        case userSnapshot, orderValue, payment, refundSummary, promotions
        case id = "_id"
        case items, shippingAddress, billingAddress, shippingIsBilling, orderStatus, source, orderDate, orderNumber, shortOrderId, createdAt, updatedAt, isCancellable, isReturnable
    }
}

struct UserSnapshot: Codable {
    let username: String?
    let email: String?
    let gender: String?
}

struct OrderValue: Codable {
    let itemsTotal, shippingFee, discountTotal, walletCreditUsed, couponDiscount, deliveryCharge, grandTotal: Double
    let currency: String
}

struct Payment: Codable {
    let method: String?
    let status: String?
}

struct RefundSummary: Codable {
    let refundStatus: String?
}

struct Promotions: Codable {
    let couponCode: String?
    let couponDiscount: Double?
}

struct OrderItemOrder: Codable {
    let priceSnapshot: PriceSnapshotDataOrder?
    let productSnapshot: PriceSnapshotDataOrder?
    let returnDetails: ReturnDetails?
    let productId, variantId: String?
    let quantity: Int?
    let itemStatus: String?
    let itemStatusTimestamps: [ItemStatusTimestamp]?
    let isReplacement: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case priceSnapshot, productSnapshot, returnDetails, productId, variantId, quantity, itemStatus, itemStatusTimestamps, isReplacement
        case id = "_id"
    }
}

struct PriceSnapshotDataOrder: Codable {
    let mrp, sellingPrice, discountAmount, walletCreditUsed, deliveryCharge, couponDiscount, totalAmount: Double?
}

struct ProductSnapshot: Codable {
    let productTitle: String?
    let productImage: String?
    let size: String?
    let color: String?
}

struct ReturnDetails: Codable {
    let images: [String]?
}

struct ItemStatusTimestamp: Codable {
    let status: String?
    let timestamp: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case status, timestamp
        case id = "_id"
    }
}

struct Addressdata: Codable {
    let id: String?
    let name, mobile, houseNumber, area, city, state, pinCode, country: String?
    let alternateMobile: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, mobile, houseNumber, area, city, state, pinCode, country, alternateMobile
    }
}




import Foundation

struct OrderResponse12: Codable {
    let success: Bool?
    let message: String?
    let data: OrderData?
}

struct OrderData: Codable {
    let razorpayOrder: RazorpayOrder?
    let orderId: String?
    let razorpayOrderId: String?
    let paymentLink: String?
}

struct RazorpayOrder: Codable {
    let amount: Double?
    let amountDue: Double?
    let amountPaid: Double?
    let attempts: Double?
    let createdAt: Double?
    let currency: String?
    let entity: String?
    let id: String?
    let notes: OrderNotes?
    let offerId: String?
    let receipt: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case amount
        case amountDue = "amount_due"
        case amountPaid = "amount_paid"
        case attempts
        case createdAt = "created_at"
        case currency
        case entity
        case id
        case notes
        case offerId = "offer_id"
        case receipt
        case status
    }
}

struct OrderNotes: Codable {
    let name: String?
    let orderId: String?
    let product: String?
    let userId: String?
}
//////
///
///
///
///
///
///
///
struct PaymentResponse123: Codable {
    let message: String?
    let order123: Order?
 
    struct Order123: Codable {
        let orderNumber: String?
        let orderValue: OrderValue?
 
        struct OrderValue: Codable {
            let couponDiscount: Double?
            let currency: String?
            let deliveryCharge: Double?
            let discountTotal: Double?
            let grandTotal: Double?
            let itemsTotal: Double?
            let shippingFee: Double?
            let walletCreditUsed: Double?
        }
    }
}
///
struct PaymentStatusResponse: Codable {
    let message: String?
    let order: Order12?
}

struct Order12: Codable {
    let userSnapshot: UserSnapshot12?
    let shiprocketTrackingStatus: ShiprocketTrackingStatus12?
    let orderValue: OrderValue12?
    let payment: Payment12?
    let refundSummary: RefundSummary12?
    let promotions: Promotions12?
    let id: String?
    let userId: String?
    let sessionExpiry: String?
    let items: [OrderItem12]?
    let shippingAddress, billingAddress: Address?
    let shippingIsBilling: Bool?
    let orderStatus, source, orderDate, orderNumber: String?
    let shortOrderId, createdAt, updatedAt: String?
    let isCancellable, isReturnable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userSnapshot, shiprocketTrackingStatus, orderValue, payment, refundSummary, promotions
        case id = "_id"
        case userId, sessionExpiry, items, shippingAddress, billingAddress, shippingIsBilling, orderStatus, source, orderDate, orderNumber, shortOrderId, createdAt, updatedAt, isCancellable, isReturnable
    }
}

struct UserSnapshot12: Codable {
    let username, email, gender: String?
}

struct ShiprocketTrackingStatus12: Codable {
    let statusHistory: [StatusHistory12]?
}

struct StatusHistory12: Codable {
    let status, timestamp: String?
    let id, _id: String?
    
    enum CodingKeys: String, CodingKey {
        case status, timestamp
        case id = "id"
        case _id = "_id"
    }
}

struct OrderValue12: Codable {
    let itemsTotal, shippingFee, discountTotal, walletCreditUsed: Double?
    let couponDiscount, deliveryCharge, grandTotal: Double?
    let currency: String?
}

struct Payment12: Codable {
    let method, status: String?
}

struct RefundSummary12: Codable {
    let refundStatus: String?
}

struct Promotions12: Codable {
    let couponCode: String?
    let couponDiscount: Double?
}

struct OrderItem12: Codable {
    let priceSnapshot: PriceSnapshot12?
    let productSnapshot: ProductSnapshot12?
    let shiprocketTrackingStatus: ShiprocketTrackingStatus12?
    let productId, variantId: String?
    let quantity: Int?
    let itemStatus: String?
    let itemStatusTimestamps: [StatusHistory12]?
    let isReplacement: Bool?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case priceSnapshot, productSnapshot, shiprocketTrackingStatus, productId, variantId, quantity, itemStatus, itemStatusTimestamps, isReplacement
        case id = "_id"
    }
}

struct PriceSnapshot12: Codable {
    let mrp, sellingPrice, discountAmount: Double?
    let walletCreditUsed: Double?
    let deliveryCharge, couponDiscount, totalAmount: Double?
}

struct ProductSnapshot12: Codable {
    let productTitle, productImage, size, color: String?
}

struct Address12: Codable {
    let id: String?
    let name: String?
    let mobile: String?
    let alternateMobile: String?
    let houseNumber, area, city, state: String?
    let pinCode, country: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, mobile, alternateMobile, houseNumber, area, city, state, pinCode, country
    }
}

