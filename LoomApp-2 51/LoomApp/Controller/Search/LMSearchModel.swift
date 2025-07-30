//
//  LoginModel.swift
//  TouringHealth
//
//  Created by chetu on 20/10/22.
//

import Foundation

// MARK: - LoginBody

//struct ProductListResponse: Codable {
//    let success: Bool?
//    let message: String?
//    let data: ProductListDataSearch?
//}
//
//struct ProductListDataSearch: Codable {
//    let totalCount: Int?
//    let totalPages: Int?
//    let currentPage: Int?
//    let pageSize: Int?
//    let products: [ProductSearch]?
//}
//import Foundation

struct ProductListResponse: Codable {
    var success: Bool?
    var message: String?
    var data: ProductListDataSearch?
}

struct ProductListDataSearch: Codable {
    var totalCount: Int?
    var totalPages: Int?
    var currentPage: Int?
    var pageSize: Int?
    var products: [Productsearch]?
}

struct Productsearch: Codable {
    var _id: String?
    var title: String?
    var slug: String?
    var description: String?
    var basePrice: Double?
    var gif: ProductGIF?
    var averageRating: Double?
    var reviewCount: Int?
    var images: [ProductImage]?
    var colorPreview: [String]?
    var totalColorCount: Int?
    var lowestSellingPrice: Double?
    let discountType: String?
    var lowestMRP: Double?
    var finalDiscountPercent: Double?
    var variantThumbnail: VariantThumbnailsearch?
    var isWishlisted: Bool?
    var category: ProductCategory?
    var subcategory: ProductSubcategory?
}

struct ProductGIF: Codable {
    var url: String?
    var order: Int?
    var _id: String?
}

struct ProductImage1: Codable {
    var url: String?
    var order: Int?
    var _id: String?
}

struct VariantThumbnailsearch: Codable {
    var variantId: String?
    var color: String?
    var image: String?
}

struct ProductCategory: Codable {
    var _id: String?
    var name: String?
}

struct ProductSubcategory: Codable {
    var _id: String?
    var name: String?
}
