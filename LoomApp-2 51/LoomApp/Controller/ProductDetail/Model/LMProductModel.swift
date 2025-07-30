//
//  ProductResponse.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation

import Foundation

struct ProductResponse: Codable {
    var success: Bool
    var message: String
    var data: productData?
}

struct productData: Codable {
    var totalCount: Int?
    var totalPages: Int?
    var currentPage: Int?
    var pageSize: Int?
    var products: [product]?
}

struct product: Codable {
    var id: String? = ""
    var title: String? = ""
    var slug: String? = ""
    var brand: String? = ""
    var description: String?
    var categoryId: String?
    var subcategoryId: String?
    var tags: [String]?
    var isActive: Bool?
    var basePrice: Double?
    var deliveryExcludedPins: [String]?
    var sizeChart: String?
    var averageRating: Double?
    var reviewCount: Int?
    var discount: Discount?
    var images: [productImage]?
    var images1: [Any]?
    let discountType: String?
    var finalDiscountPercent: Double?
    var category: Category?
    var subcategory: subcategory?
    var lowestMRP: Double?
    var lowestSellingPrice: Double?
    var lowestDiscountSource: String?
    var colorPreview: [String]?
    var totalColorCount: Int?
    var thumbnailImage: String?
    let gif: ProductGif?
    let variantThumbnail: VariantThumbnail1?
    var isWishlisted: Bool?

    
 
    
    enum CodingKeys: String, CodingKey {
        case title, slug, brand, description,thumbnailImage, gif,variantThumbnail
        case categoryId, subcategoryId, tags, isActive, basePrice
        case deliveryExcludedPins, sizeChart, averageRating, reviewCount
        case discount, images, category, subcategory, lowestMRP, colorPreview, totalColorCount
        case lowestSellingPrice, lowestDiscountSource, finalDiscountPercent, discountType
        case id = "_id"

    }
//    init(from decoder: Decoder) throws {
//           let container = try decoder.container(keyedBy: CodingKeys.self)
//
//           id = try container.decodeIfPresent(String.self, forKey: .id)
//           title = try container.decodeIfPresent(String.self, forKey: .title)
//           slug = try container.decodeIfPresent(String.self, forKey: .slug)
//           description = try container.decodeIfPresent(String.self, forKey: .description)
//           basePrice = try container.decodeIfPresent(Double.self, forKey: .basePrice)
//           averageRating = try container.decodeIfPresent(Double.self, forKey: .averageRating)
//           reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount)
//           images1 = try container.decodeIfPresent([ProductImage].self, forKey: .images)
//           lowestMRP = try container.decodeIfPresent(Double.self, forKey: .lowestMRP)
//           lowestSellingPrice = try container.decodeIfPresent(Double.self, forKey: .lowestSellingPrice)
//           lowestDiscountSource = try container.decodeIfPresent(String.self, forKey: .lowestDiscountSource)
//           finalDiscountPercent = try container.decodeIfPresent(Int.self, forKey: .finalDiscountPercent)
//           //totalColorCount = try container.decode(Int.self, forKey: .totalColorCount)
//           colorPreview = try container.decodeIfPresent([String].self, forKey: .colorPreview)
//        //   colorPreview = try container.decode([String].self, forKey: .colorPreview)
//       }
}
struct ProductGif: Codable {
    let url: String?
    let order: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct VariantThumbnail1: Codable {
    let variantId: String?
    let color: String?
    let image: String?
}

struct Discount: Codable {
    var percentage: Int?
    var isActive: Bool?
}

struct productImage: Codable {
    var url: String?
    var order: Int?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct Category: Codable {
    var name: String?
}

struct subcategory: Codable {
    var name: String?
}


///////////


struct ProductResponse1: Codable {
    let success: Bool
    let message: String
    let data: productData?
}

struct productData1: Codable {
    let totalCount: Int?
    let totalPages: Int?
    let currentPage: Int?
    let pageSize: Int?
    let products: [product1]?
}

struct product1: Codable {
    var id: String? = ""
    var title: String? = ""
    var slug: String? = ""
    var brand: String? = ""
    var description: String?
    var categoryId: String?
    var subcategoryId: String?
    var tags: [String]?
    var isActive: Bool?
    var basePrice: Double?
    var deliveryExcludedPins: [String]?
    var sizeChart: String?
    var averageRating: Double?
    var reviewCount: Int?
    var discount: Discount1?
    var images: [productImage1]?
    var images1: [Any]?

    var category: Category?
    var subcategory: subcategory1?
    var lowestMRP: Double?
    var lowestSellingPrice: Double?
    var lowestDiscountSource: String?
    var finalDiscountPercent: Int?
    var colorPreview: [String]?
    enum CodingKeys: String, CodingKey {
        case title, slug, brand, description
        case categoryId, subcategoryId, tags, isActive, basePrice
        case deliveryExcludedPins, sizeChart, averageRating, reviewCount
        case discount, images, category, subcategory, lowestMRP, colorPreview
        case lowestSellingPrice, lowestDiscountSource, finalDiscountPercent
        case id = "_id"

    }
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)

           id = try container.decodeIfPresent(String.self, forKey: .id)
           title = try container.decodeIfPresent(String.self, forKey: .title)
           slug = try container.decodeIfPresent(String.self, forKey: .slug)
           description = try container.decodeIfPresent(String.self, forKey: .description)
           basePrice = try container.decodeIfPresent(Double.self, forKey: .basePrice)
           averageRating = try container.decodeIfPresent(Double.self, forKey: .averageRating)
           reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount)
           images1 = try container.decodeIfPresent([ProductImage].self, forKey: .images)
           lowestMRP = try container.decodeIfPresent(Double.self, forKey: .lowestMRP)
           lowestSellingPrice = try container.decodeIfPresent(Double.self, forKey: .lowestSellingPrice)
           lowestDiscountSource = try container.decodeIfPresent(String.self, forKey: .lowestDiscountSource)
           finalDiscountPercent = try container.decodeIfPresent(Int.self, forKey: .finalDiscountPercent)
           //totalColorCount = try container.decode(Int.self, forKey: .totalColorCount)
           colorPreview = try container.decodeIfPresent([String].self, forKey: .colorPreview)
        //   colorPreview = try container.decode([String].self, forKey: .colorPreview)
       }
}

struct Discount1: Codable {
    let percentage: Int?
    let isActive: Bool?
}

struct productImage1: Codable {
    let url: String?
    let order: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct Category1: Codable {
    let name: String?
}

struct subcategory1: Codable {
    let name: String?
}




struct ProductListByTagResponse: Codable {
    let success: Bool?
    let message: String?
    let data: ProductListByTagData?
}

struct ProductListByTagData: Codable {
    let totalCount: Int?
    let totalPages: Int?
    let currentPage: Int?
    let pageSize: Int?
    let products: [ProductByTag]?
}

struct ProductByTag: Codable {
    let id: String?
    let title: String?
    let slug: String?
    let description: String?
    let basePrice: Double?
    let gif: GifMedia?
    let averageRating: Double?
    let reviewCount: Int?
    let images: [ImageItem]?
    let colorPreview: [String]?
    let totalColorCount: Int?
    let lowestSellingPrice: Double?
    let lowestMRP: Double?
    let finalDiscountPercent: Int?
    let variantThumbnail: VariantThumbnailtag?
    let isWishlisted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, slug, description, basePrice, gif, averageRating, reviewCount, images, colorPreview, totalColorCount, lowestSellingPrice, lowestMRP, finalDiscountPercent, variantThumbnail, isWishlisted
    }
}

struct GifMedia: Codable {
    let url: String?
    let order: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct ImageItem: Codable {
    let url: String?
    let order: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case url, order
        case id = "_id"
    }
}

struct VariantThumbnailtag: Codable {
    let variantId: String?
    let color: String?
    let image: String?
}
