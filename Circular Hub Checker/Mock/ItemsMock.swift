//
//  ItemsMock.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import Foundation

struct ItemsMock {
    static var items = [
        Item(id: 201483, title: "EFTERSMAK", description: "Horno microondas, negro", price: 349.2, heroImage: "https://www.ikea.com/es/es/images/products/eftersmak-horno-microondas-negro__0754882_pe748150_s4.jpg", articlesPrice: 599.0, currency: "EUR", priority: 22, new: false),
        Item(id: 205660, title: "BRASÖY", description: "Base cama4 patas, blanco, 105x190 cm. Pequeño defecto en tela inferior", price: 69.99, heroImage: "https://www.ikea.com/es/es/images/products/brasoy-base-cama-4-patas-blanco__0381636_pe556376_s4.jpg", articlesPrice: 99.99, currency: "EUR", priority: 21, new: true),
        Item(id: 212860, title: "UNDERLIG", description: "Colchón espuma cama júnior, blanco, 70x160 cm", price: 39.99, heroImage: "https://www.ikea.com/es/es/images/products/underlig-colchon-espuma-cama-junior-blanco__0748965_pe745355_s4.jpg", articlesPrice: 59.0, currency: "EUR", priority: 20, new: false),
        Item(id: 199521, title: "VALEVÅG", description: "Colchón de muelles ensacados, firme/azul claro, 90x190 cm se entrega enrrollado .", price: 119.0, heroImage: "https://www.ikea.com/es/es/images/products/valevag-colchon-muelles-ensacados-firme-azul-claro__1150856_pe884904_s4.jpg", articlesPrice: 169.0, currency: "EUR", priority: 20, new: true)
    ]
    
    static var stores = [
        Store(id: 23, storeID: "031", name: "Alcorcon", email: "asdasda", timezone: .europeMadrid, openHour: 22, closeHour: 22, reservedHours: 22, items: nil, countryCode: .es)
    ]
    
    static var item = Item(id: 23, title: "Prueba", description: "prueba", price: 234, heroImage: "https://www.ikea.com/es/es/images/products/valevag-colchon-muelles-ensacados-firme-azul-claro__1150856_pe884904_s4.jpg", articlesPrice: 234, currency: "EUR", priority: nil)
    
//    static var itemDetail = ItemDetail(id: 23, unitID: "2342134", countryCode: "ES", langCode: "ES", title: "SADIS", description: "Ninguna", price: 23, images: [], state: .published, tagID: "23", articles: [], uploads: [], itemTranslations: [])
}
