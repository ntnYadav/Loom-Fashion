
//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//
// MARK: - ReviewResponse
import Foundation

import Foundation

struct WalletPointsResponse: Codable {
    var success: Bool?
    var message: String?
    var data: WalletPointsData?
}

struct WalletPointsData: Codable {
    var walletBalance: Double?
    var pointsBalance: Int?
    var pointValue: Double?
    var history: [WalletPointsHistory]?
}

struct WalletPointsHistory: Codable {
    var type: String? // "wallet" or "points"
    
    // Wallet-specific
    var amount: Double?
    
    // Points-specific
    var points: Int?
    var orderId: String?
    
    // Shared
    var txnType: String? // "earn", "redeem", "credit", "debit"
    var description: String?
    var createdAt: String?
}
