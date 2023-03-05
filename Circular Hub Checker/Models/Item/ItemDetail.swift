//
//  ItemDetail.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 21/1/23.
//

import Foundation

enum ItemState: String, Codable {
    case published = "PUBLISHED"
    case reserved = "RESERVED"
}

// MARK: - ItemDetailResponse
struct ItemDetailResponse: Codable {
    let id: Int
    let unitID, countryCode, langCode, title: String
    let description: String
    let price: Double
    let images: [Image]
    let state: ItemState
    let tagID: String
    let articles: [Article]
    let uploads: [Upload]
    let itemTranslations: [ItemTranslation]
    
    enum CodingKeys: String, CodingKey {
        case id
        case unitID = "unitId"
        case countryCode = "country_code"
        case langCode = "lang_code"
        case title, description, price, images, state
        case tagID = "tagId"
        case articles, uploads, itemTranslations
    }
}

// MARK: - Article
struct Article: Codable {
    let id: Int
    let langCode: String
    let title: String?
    let description: String
    let price: Double
    let qty: Int
    let articleID: String
    let iowsImages: String?
    let currencyCode: String
    let articleTranslations: [ArticleTranslation]
    
    enum CodingKeys: String, CodingKey {
        case id
        case langCode = "lang_code"
        case title, description, price, qty
        case articleID = "article_id"
        case iowsImages = "iows_images"
        case currencyCode = "currency_code"
        case articleTranslations
    }
}

// MARK: - ArticleTranslation
struct ArticleTranslation: Codable {
    let id, articleID: Int
    let title: String?
    let description: String
    let languageID: Int
    let byDefault: Bool
    let benefits, benefitSummary, designers, goodToKnows: String?
    let materials, careInstructions: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case articleID = "article_id"
        case title, description
        case languageID = "language_id"
        case byDefault = "by_default"
        case benefits
        case benefitSummary = "benefit_summary"
        case designers
        case goodToKnows = "good_to_knows"
        case materials
        case careInstructions = "care_instructions"
    }
}

// MARK: - Image
struct Image: Codable, Identifiable {
    let id: Int
    let url: String
    let displayOrder: Int
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case displayOrder = "display_order"
    }
}

// MARK: - ItemTranslation
struct ItemTranslation: Codable {
    let id, itemID: Int
    let title, description: String
    let languageID: Int
    let byDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case title, description
        case languageID = "language_id"
        case byDefault = "by_default"
    }
}

// MARK: - Upload
struct Upload: Codable {
    let id: Int
    let domain: String
    let container, countryCode, name: String
    let langCode: JSONNull?
    let notes: String
    let uploadedNotes: [UploadedNote]
    
    enum CodingKeys: String, CodingKey {
        case id, domain, container
        case countryCode = "country_code"
        case name
        case langCode = "lang_code"
        case notes, uploadedNotes
    }
}

// MARK: - UploadedNote
struct UploadedNote: Codable {
    let id, uploadID, languageID: Int
    let notes: String
    let byDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case uploadID = "upload_id"
        case languageID = "language_id"
        case notes
        case byDefault = "by_default"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

typealias ItemDetail = ItemDetailResponse
