//
//  LMAddressModel.swift
//  LoomApp
//
//  Created by Flucent tech on 30/04/25.
//

import Foundation

struct GuestMergeResponse: Codable {
    let success: Bool
    let message: String
    let cartCount: Int
    let wishlistCount: Int
}
struct wishlist: Codable {
    let productId: String?
    let color: String?
    let variantId:String?
}


struct ApiResponse: Codable {
    let success: Bool?
    let message: String?
    let data: ResponseData?
}

struct ResponseData: Codable {
    var subcategories: [Subcategory]
    var subcategories1: [Subcategory]?
    var subcategoriesFinal: [Subcategory]?

    var products: [Product]
    let totalCount: Int?
    let totalPages: Int?
    let currentPage: Int?
    let pageSize: Int?
}

struct Subcategory: Codable {
    let _id: String?
    let name: String
    let image: String?
    let sequence: Int

    
    init(_id: String, name: String, image: String, sequence: Int) {
        self._id = _id
        self.name = name
        self.image = image
        self.sequence = sequence
    }
}

struct Product: Codable {
    var id: String?
    var title: String?
    var slug: String?
    var brand: String?
    var subcategoryId: String?
    var tags: [String]?
    let thumbnailImage: String?
    let discountType: String?
    var finalDiscountPercent: Double?

    let variantThumbnail: VariantThumbnail?
    var images: [ProductImage]?
    var lowestMRP: Double?
    var lowestSellingPrice: Double?
    var subcategory: SubcategoryInfo
    var colorPreview: [String]?
    var totalColorCount: Double?
    var isWishlisted: Bool?

    
    
    enum CodingKeys: String, CodingKey {
           case id = "_id"
           case title, slug, brand, subcategoryId, tags
           case thumbnailImage, images, lowestMRP, lowestSellingPrice, finalDiscountPercent
           case variantThumbnail, totalColorCount, colorPreview, subcategory, isWishlisted, discountType
        
       }

}

struct ProductImage: Codable {
    let url: String?
    let order: Int?
    let id: String?
    enum CodingKeys: String, CodingKey {
           case url, order
           case id = "_id"
       }
}
// MARK: - Variant Thumbnail
struct VariantThumbnail: Codable {
    let variantId: String?
    let color: String?
    let image: String?
}
struct SubcategoryInfo: Codable {
    let name: String?
}





struct ProductResponsetag: Codable {
    let success: Bool?
    let message: String?
    let data: ProductData?
}

struct ProductData: Codable {
    let totalCount: Int?
    let totalPages: Int?
    let currentPage: Int?
    let pageSize: Int?
    let products: [product]?
}

//struct product: Codable {
//    let id: String
//    let title: String
//    let slug: String
//    let description: String
//    let tags: [String]
//    let isActive: Bool
//    let averageRating: Int
//    let reviewCount: Int
//    let images: [ProductImagetag]
//    let lowestMRP: Double
//    let lowestSellingPrice: Double
//    let lowestDiscountSource: String
//    let finalDiscountPercent: Int
//    let colorPreview: [String]
//    let totalColorCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case title, slug, description, tags, isActive, averageRating, reviewCount, images, lowestMRP, lowestSellingPrice, lowestDiscountSource, finalDiscountPercent, colorPreview, totalColorCount
//    }
//}
//
//struct ProductImagetag: Codable {
//    let url: String
//    let order: Int
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case url, order
//        case id = "_id"
//    }
//}
//struct BannerResponse: Codable {
//    let success: Bool
//    let message: String
//    let banners: [Banner]
//}
//
//struct Banner: Codable {
//    let id: String
//    let title: String
//    let image: String
//    let status: String
//    let createdAt: String
//    let updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case title, image, status, createdAt, updatedAt
//    }
//}
//struct Banner: Decodable {
//    let id: String?
//    let title: String?
//    let webImage: String?
//    let mobileImage: String?
//    let status: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case title, webImage, mobileImage, status
//    }
//}
//
//struct BannerResponse: Decodable {
//    let success: Bool?
//    let message: String?
//    let banners: [Banner]?
//}
struct BannerResponse: Codable {
    let success: Bool?
    let message: String?
    let banners: [Banner]?
}

struct Banner: Codable {
    let id: String?
    let title: String?
    let webImage: String?
    let mobileImage: String?
    let webVideo: String?
    let mobileVideo: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case webImage
        case mobileImage
        case webVideo
        case mobileVideo
        case status
        case createdAt
        case updatedAt
    }
}

//{"success":true,"isWishlisted":true,"totalCount":2,"message":"Product added to wishlist successfully"}


//struct WishlistResponse: Codable {
//    let success: Bool?
//    let message: Int?
//    let data: WishlistDataWrapper?
//}

struct WishlistResponse: Codable {
    let success: Bool
    let isWishlisted: Bool?
    let totalCount: Int?
    let message: String?
}


struct WishlistDataWrapper: Codable {
    let message: String?
    let data: WishlistData?
}

struct WishlistData: Codable {
    let userId: String?
    let products: [WishlistProduct]?
    let _id: String?
    let createdAt: String?
    let updatedAt: String?
    let __v: Int?
}

struct WishlistProduct: Codable {
    let productId: String?
    let color: String?
    let _id: String?
    let createdAt: String?
    let updatedAt: String?
}



