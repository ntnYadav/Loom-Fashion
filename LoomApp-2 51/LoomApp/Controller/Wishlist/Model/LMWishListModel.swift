//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//
// MARK: - ReviewResponse
import Foundation

struct WishlistToCartResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [String]?
}

struct WishlistItem1: Codable {
    let productId: String?
    let variantId: String?
    let color: String?
    let quantity: Int?

}

struct WishlistItem: Codable {
    let productId: String?
    let variantId: String?
    let quantity: Int?
}

struct WishlistResponse9: Codable {
    let success: Bool?
    let message: String?
    let products: [WishlistProduct9]?
}

struct WishlistProduct9: Codable {
    let id: String?
    let title: String?
    let slug: String?
    let brand: String?
    let subcategoryId: String?
    let tags: [String]?
    let images: [ProductImage9]?
    let lowestMRP: Double?
    let lowestSellingPrice: Double?
    let finalDiscountPercent: Double?
    let variantThumbnail: VariantThumbnail9?
    let colorDetails: ColorDetails9?
    let subcategory: Subcategory9?
    let wishlistItemId: String?
    let addedAt: String?
    let sizeVariants: [SizeVariant9]?
    let requestedVariantId: String?

    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, slug, brand, subcategoryId, tags, images
        case lowestMRP, lowestSellingPrice, finalDiscountPercent
        case variantThumbnail, colorDetails, subcategory
        case wishlistItemId, addedAt, sizeVariants, requestedVariantId
    }
}

struct ProductImage9: Codable {
    let url: String?
    let order: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct VariantThumbnail9: Codable {
    let variantId: String?
    let color: String?
    let image: String?
}

struct ColorDetails9: Codable {
    let color: String?
    let sizes: [VariantSize9]?
}

struct VariantSize9: Codable {
    let variantId: String?
    let size: String?
    let price: VariantPrice9?
    let images: [String]?
    let stock: VariantStock9?
}

struct VariantPrice9: Codable {
    let mrp: Double?
    let sellingPrice: Double?
    let discountPercents: Double?
}

struct VariantStock9: Codable {
    let status: String?
    let available: Int?
    let message: String?
}

struct Subcategory9: Codable {
    let name: String?
}

struct SizeVariant9: Codable {
    // Structure is empty in provided JSON
    // You can define fields here if known
}



import Foundation

struct RemoveWishlistResponse: Codable {
    let success: Bool?
    let message: String?
    let data: RemovedWishlistData?
}

struct RemovedWishlistData: Codable {
    let id: String?
    let userId: String?
    let products: [RemovedWishlistProduct]?
    let createdAt: String?
    let updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case products
        case createdAt
        case updatedAt
        case v = "__v"
    }
}

struct RemovedWishlistProduct: Codable {
    let productId: String?
    let color: String?
    let variantId: String?
    let id: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case productId
        case color
        case variantId
        case id = "_id"
        case createdAt
        case updatedAt
    }
}
