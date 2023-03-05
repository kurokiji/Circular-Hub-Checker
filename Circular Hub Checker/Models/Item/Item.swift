//
//  Item.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import Foundation

struct Item: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title, description: String
    let price: Double
    let heroImage: String
    let articlesPrice: Double
    let currency: String
    let priority: Int?
    var store: Store?
    var new: Bool?
    var state: ItemState?
}

extension Item {
    func getFormattedPrice(price: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.currencyCode = currency
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: price as NSNumber) {
            return formattedTipAmount
        } else {
            return nil
        }
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
