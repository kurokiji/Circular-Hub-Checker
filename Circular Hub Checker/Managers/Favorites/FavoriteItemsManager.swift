//
//  FavoriteItems.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 18/2/23.
//

import Foundation

class FavoriteItemsManager: ObservableObject {
    @Published var items: [Item]
    
    private var saveKey: String = "FavoriteItems"
    
    init() {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: [Item].self, key: saveKey) {
            items = retrievedCodableObject
        } else {
            items = []
        }
    }
    
    func contains(_ item: Item) -> Bool {
        return items.contains(item)
    }
    
    func addOrRemove(_ item: Item) {
        if items.contains(item) {
            guard let index = items.firstIndex(of: item) else { return }
            items.remove(at: index)
        } else {
            var itemToSave = item
            itemToSave.state = .published
            items.append(itemToSave)
        }
        save()
    }
    
    func save() {
        UserDefaults.standard.setCodableObject(items, forKey: saveKey)
    }
}
