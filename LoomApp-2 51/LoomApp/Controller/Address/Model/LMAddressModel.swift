//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//
// MARK: - ReviewResponse
struct ReviewResponse: Codable {
    let success: Bool
    let message: String
    let data: ReviewData1?
}

// MARK: - ReviewData
struct ReviewData1: Codable {
    let userId: String
    let productId: String
    let variantId: String
    let orderId: String
    let orderItemId: String
    let rating: Int
    let comment: String
    let images: [String]
    let id: String
    let createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case userId, productId, variantId, orderId, orderItemId, rating, comment, images
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}


struct ReviewRequest: Codable {
    let productId: String
    let rating: Int
    let comment: String
    let variantId: String
    let orderId: String
    let orderItemId: String
    let images: [String]
}


struct ImageUploadResponse: Codable {
    let success: Bool
    let message: String
    let images: [String]
}

struct deliveryPincodeReq12: Codable {
    let deliveryPincode: Int
    let weight: Float
    let height: Double
    let breadth: Double
    let length: Double
}


struct PincodeResponse: Codable {
    let Message: String
    let Status: String
    let PostOffice: [PostOfficeInfo]
}

struct PostOfficeInfo: Codable {
    let Name: String
    let District: String
    let Block: String
    let State: String
    let Country: String
    let Pincode: String
}

struct PostalLocation: Codable {
    let country: String
    let district: String
    let postalLocation: String
    let state: String
}

struct Address: Codable {
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    let isDefault: Bool  // typo? maybe you meant `isDefault`
}


struct AddAddressResponse: Codable {
    let success: Bool
    let message: String
    let data: AddressData
}

struct AddressData: Codable {
    let id: String
    let userId: UserID
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    let isDefault: Bool
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, name, mobile, pinCode, houseNumber, area, city, state, country, isDefault, createdAt, updatedAt
    }
}

struct UserID: Codable {
    let id: String
    let accesstoken: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accesstoken
    }
}



/////////Address List Model
struct Addresslist: Codable {
    let id: String
    let userId: String
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    let isDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, name, mobile, pinCode, houseNumber, area, city, state, country, isDefault
    }
}

//struct AddressResponseList: Codable {
//    let success: Bool
//    let message: String
//    let data: [Addresslist]
//}




struct AddressResponseList: Codable {
    let success: Bool
    let message: String
    let data: AddressDatalist?
}

struct AddressDatalist: Codable {
    let defaultAddress: Addresslisting?
    var otherAddresses: [Addresslisting]
}

struct Addresslisting: Codable {
    let id: String
    let userId: String
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    var isDefault: Bool
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case name
        case mobile
        case pinCode
        case houseNumber
        case area
        case city
        case state
        case country
        case isDefault
        case createdAt
        case updatedAt
    }
}
///Delete Struct
struct Addressdelete: Codable {
    let addressId: String
}


struct AddressDeleteResponse: Codable {
    let success: Bool
    let message: String
    let data: AddressDataDelete
}

struct AddressDataDelete: Codable {
    let _id: String
    let userId: String
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    let isDefault: Bool
    let createdAt: String
    let updatedAt: String
}
///////
///Edit
///import Foundation

struct EditAddressResponse: Codable {
    let success: Bool
    let message: String
    let data: EditAddress
}

struct EditAddress: Codable {
    let id: String
    let userId: String
    let name: String
    let mobile: String
    let pinCode: String
    let houseNumber: String
    let area: String
    let city: String
    let state: String
    let country: String
    let isDefault: Bool
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case name
        case mobile
        case pinCode
        case houseNumber
        case area
        case city
        case state
        case country
        case isDefault
        case createdAt
        case updatedAt
    }
}

