//
//  FavoriteStores.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 18/2/23.
//

import Foundation

class FavoriteStoresManager: ObservableObject {
    private var stores: Set<String>
    private let saveKey = "FavoriteStores"
    
    init() {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: Set<String>.self, key: saveKey) {
            stores = retrievedCodableObject
        } else {
            stores = []
        }
    }
    
    func contains(_ store: Store?) -> Bool {
        guard let store = store else { return false }
        return stores.contains(store.storeID)
    }
    
    func add(_ store: Store?) {
        guard let store = store else { return }
        objectWillChange.send()
        stores.insert(store.storeID)
        save()
    }
    
    func remove(_ store: Store?) {
        guard let store = store else { return }
        objectWillChange.send()
        stores.remove(store.storeID)
        save()
    }
    
    func save() {
        UserDefaults.standard.setCodableObject(stores, forKey: saveKey)
    }
}
