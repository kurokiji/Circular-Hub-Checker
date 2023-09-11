//
//  ItemsGridViewModel.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import Foundation

enum ItemFilterOrder {
    case ascendent
    case descendent
}

enum ItemFilterType {
    case price
    case name
    case date
}

protocol StoreViewModel: ObservableObject {
    var items: [Item] { get }
    var newItems: [Item] { get }
    var store: Store { get }
}

class StoreViewModelImpl: StoreViewModel {
    @Published var items: [Item]
    @Published var newItems: [Item]
    var itemsBackUp: [Item]
    var itemsChecker: ItemsChecker
    var store: Store
    
    var searchTerm: String
    
    init(store: Store) {
        self.itemsChecker = ItemsChecker(store: store)
        self.store = store
        items = []
        newItems = []
        itemsBackUp = []
        searchTerm = ""
    }
    
    func getItems(completionSuccess: @escaping ()-> Void, completonError: @escaping() -> Void) {
        itemsChecker.getItems { [weak self] newItems, allItems in
            self?.items = allItems
            self?.newItems = newItems
            self?.itemsBackUp = newItems + allItems
            completionSuccess()
        } completionError: { error in
            completonError()
        }
    }
    
    func sortItems<T: Comparable>(by keyPath: KeyPath<Item, T>, using comparator: (T, T) -> Bool = (<)) {
        items = items.sort(by: keyPath, using: comparator)
        newItems = []
    }
    
    func searchItems(with term: String) {
        if !newItems.isEmpty {
            items = itemsBackUp
            newItems.removeAll()
        }
        guard !term.isEmpty else {
            items = itemsBackUp
            return
        }
        items = itemsBackUp.filter { $0.title.localizedCaseInsensitiveContains(term) || $0.description.localizedStandardContains(term) }
    }
}

extension Sequence {
    func sort<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
