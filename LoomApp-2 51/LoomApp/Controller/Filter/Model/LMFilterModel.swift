//
//  ProductResponse.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation




// MARK: - Root Response
struct SubcategoryResponse: Codable {
    let success: Bool?
    let message: String?
    let data: SubcategoryData?
}

// MARK: - Data Container
struct SubcategoryData: Codable {
    let total: Int?
    let page: Int?
    let pageSize: Int?
    let totalPages: Int?
    let results: [Subcategorydata]
}

// MARK: - Subcategory
struct Subcategorydata: Codable {
    let id: String?
    let name: String
    let slug: String?
    let categoryId: String?
    let isActive: Bool?
    let description: String?
    let image: String?
    let productCount: Int?
   // let isDeleted: Bool
    let createdAt: String?
    let updatedAt: String?
    let subCategoryDiscount: Discountdata?
    let tagDiscounts: [TagDiscount]?
    let attributes: [Attribute]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, slug, categoryId, isActive, description, image, productCount, createdAt, updatedAt
        case subCategoryDiscount, tagDiscounts, attributes
    }

    /// Helper to get attribute values by name
    func values(forAttribute name: String) -> [String] {
        attributes.first(where: { $0.name.lowercased() == name.lowercased() })?.values ?? []
    }

    /// Dictionary of all attributes and their values
    var attributeValuesDict: [String: [String]] {
        Dictionary(uniqueKeysWithValues: attributes.map { ($0.name, $0.values) })
    }
}

// MARK: - Discount
struct Discountdata: Codable {
    let percentage: Int?
    let isActive: Bool?
}

// MARK: - Tag Discount
struct TagDiscount: Codable {
    let tag: String?
    let percentage: Int?
    let isActive: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case tag, percentage, isActive
        case id = "_id"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let name: String
    let type: String
    let required: Bool
    let values: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name, type, required, values
        case id = "_id"
    }
}
