//
//  LMProductDetail.swift
//  LoomApp
//
//  Created by Flucent tech on 13/05/25.
//

import Foundation

// MARK: - Root Response
struct ProductDetailResponse: Codable {
    let success: Bool?
    let message: String?
    let data: ProductDataDetail?
}

// MARK: - Product Data
struct ProductDataDetail: Codable {
    let productId: String?
    let defaultVariantId: String?
    let title: String?
    let description: String?
    let formatedDescription: String?
    let basePrice: Double?
    let discount: Double?
    let thumbnailImage: String?
    let sizeChart: String?
    let dimensions: Dimensions?
    let weightInKg: Double?
    let specs: ProductSpecs?
    var colors: [ColorVariant]?
    var ColorVariantfilter: ColorVariant?
    var sizestemp: [String]?
    var sizeArrayTemp: [String]?
    var variants: [SizeVariant]? = []
    var variantsColor: [ColorVariant]? = []
    let reviewCount: Int?
    let averageRating: Double?
    let similarProducts: [SimilarProductdata]?

    
}


struct SimilarProductdata: Codable {
    let _id: String?
    let title: String?
    let slug: String?
    let description: String?
    let gif: GifData?
    let averageRating: Double?
    let reviewCount: Int?
    let lowestSellingPrice: Double?
    let lowestMRP: Double?
    let finalDiscountPercent: Double?
    let discountType: String?
    let discountValue: Double?
    let totalColorCount: Int?
    let variantThumbnail: VariantThumbnail?
    var isWishlisted: Bool?
    let colorPreview: [String]?

}

struct GifData: Codable {
    let url: String?
    let order: Int?
    let _id: String?
}




// MARK: - Product Specs
struct ProductSpecs: Codable {
    let collar: String?
    let fit: String?
    let material: String?
    let pattern: String?
    let occassion: String?
    let sleeves: String?
    let fade: String?
    let distress: String?
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let lengthCm: Double?
    let widthCm: Double?
    let heightCm: Double?
}

// MARK: - Color Variant
struct ColorVariant: Codable {
    let value: String?
    let image: String?
    var sizes: [SizeVariant]?
}

// MARK: - Size Variant
struct SizeVariant: Codable {
    let variantId: String?
    let size: String?
    var price: PriceDetail?
    var stock: StockDetail?
    var images: [String]?
    var isWishlisted: Bool?

}

// MARK: - Price Detail
struct PriceDetail: Codable {
    let mrp: Double?
    let sellingPrice: Double?
    let discountPercents: Double?
    let discountType: String?
    let discountValue: Double?
}

// MARK: - Stock Detail
struct StockDetail: Codable {
    let status: String?
    let available: Int?
    let message: String?
}



// MARK: - SizeVariant Detail
struct SizeVariant11: Codable {
    let variantId: String?
    let size: String?
    let price: PriceDetail?
    let stock: StockDetail?
    let images: [String]?
}
// MARK: - Product Detail Response and request



// MARK: - Cart Response and request
struct cartParameter: Codable {
    let productId: String?
    let variantId: String?
    let quantity: Int?
}


struct AddToCartResponse: Codable {
    let success: Bool?
    let message: String?
    let data: CartData?
}

struct CartData: Codable {
    let cart: Cart?
}

struct Cart: Codable {
    let userId: String?
    let items: [CartItem]?
    let couponDiscount: Double?
    let abandoned: Bool?
    let lastActiveAt: String?
    let createdAt: String?
    let updatedAt: String?
    let id: String?
}

struct CartItem: Codable {
    let productId: String?
    let variantId: String?
    let quantity: Int?
    let priceSnapshot: PriceSnapshot?
    let inventoryStatus: String?
    let remindersSent: Int?
    let couponUsed: Bool?
    let lastCheckedAt: String?
    let addedAt: String?
}

struct PriceSnapshot: Codable {
    let basePrice: Double?
    let sellingPrice: Double?
    let source: String?
}



// MARK: - GeocodeResponse Response and request


//struct GeocodeResponse: Codable {
//    let results: [GeocodeResult]
//    let status: String
//}
//
//struct GeocodeResult: Codable {
//    let address_components: [AddressComponent]
//    let formatted_address: String
//    let postcode_localities: [String]
//}
//
//struct AddressComponent: Codable {
//    let long_name: String
//    let short_name: String
//    let types: [String]
//}


struct GeocodeResponse: Codable {
    let success: Bool?
    let message: String?
    let data: ResponseDataGoogle?
}

struct ResponseDataGoogle: Codable {
    let results: [GeoResult]?
    let status: String?
}

struct GeoResult: Codable {
    let address_components: [AddressComponent]?
    let formatted_address: String?
    let geometry: Geometry?
    let place_id: String?
    let postcode_localities: [String]?
    let types: [String]?

    // Optional initializer for custom parsing if needed
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        address_components = try c.decodeIfPresent([AddressComponent].self, forKey: .address_components)
        formatted_address    = try c.decodeIfPresent(String.self, forKey: .formatted_address)
        geometry             = try c.decodeIfPresent(Geometry.self, forKey: .geometry)
        place_id             = try c.decodeIfPresent(String.self, forKey: .place_id)
        postcode_localities  = try c.decodeIfPresent([String].self, forKey: .postcode_localities)
        types                = try c.decodeIfPresent([String].self, forKey: .types)
    }
}

struct AddressComponent: Codable {
    let long_name: String?
    let short_name: String?
    let types: [String]?
}

struct Geometry: Codable {
    let bounds: Boundary?
    let location: Coordinate?
    let location_type: String?
    let viewport: Boundary?
}

struct Boundary: Codable {
    let northeast: Coordinate?
    let southwest: Coordinate?
}

struct Coordinate: Codable {
    let lat: Double?
    let lng: Double?
}



///Review

struct ReviewResponse123: Codable {
    let success: Bool?
    let message: String?
    let data: ReviewData?
}

struct ReviewData: Codable {
    let reviews: [Review]?
    let customerImages: [String]?
    let totalPages: Int?
    let currentPage: Int?
    let totalReviews: Int?
}

struct Review: Codable {
    let id: String?
    let userId: String?
    let productId: String?
    let variantId: String?
    let orderId: String?
    let orderItemId: String?
    let rating: Double?
    let comment: String?
    let images: [String]?
    let createdAt: String?
    let updatedAt: String?
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case productId
        case variantId
        case orderId
        case orderItemId
        case rating
        case comment
        case images
        case createdAt
        case updatedAt
        case userName
    }
}



import Foundation

// MARK: - API Response
struct DeliveryEstimateResponse: Codable {
    let success: Bool?
    let message: String?
    let data: DeliveryEstimate?
}

// MARK: - Delivery Estimate
struct DeliveryEstimate: Codable {
    let courierName: String?
    let estimatedDeliveryDays: String?
    let expectedDeliveryDate: String?
    let shippingRate: Double?
    let courierRating: Double?

    enum CodingKeys: String, CodingKey {
        case courierName = "courier_name"
        case estimatedDeliveryDays = "estimated_delivery_days"
        case expectedDeliveryDate = "expected_delivery_date"
        case shippingRate = "shipping_rate"
        case courierRating = "courier_rating"
    }
}
