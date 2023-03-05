//
//  Store.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import Foundation

typealias StoreResponse = [Store]

struct Store: Codable, Identifiable, Hashable {
    let id: Int
    let storeID, name: String
    let email: String?
    let timezone: Timezone
    let openHour, closeHour, reservedHours: Int
    let items: [Item]?
    let countryCode: CountryCode
    var newItems: [Item]?
    var oldItems: [Item]?

    enum CodingKeys: String, CodingKey {
        case id
        case storeID = "store_id"
        case name, email, timezone
        case openHour = "open_hour"
        case closeHour = "close_hour"
        case reservedHours = "reserved_hours"
        case items
        case countryCode = "country_code"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum CountryCode: String, Codable {
    case es = "es"
}

enum Timezone: String, Codable {
    case europeMadrid = "Europe/Madrid"
}
