//
//  ItemsCheck.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 6/2/23.
//

import Foundation

class ItemsChecker {
    var store: Store
    var items: [Item]
    private var totalPages: Int = 0
    private var currentPage: Int = 0
    
    init(store: Store) {
        self.store = store
        self.items = []
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "web-api.ikea.com"
        components.path = "/circular/circular-asis/api/public/store/es/es/\(store.storeID)"
        components.queryItems = [
            URLQueryItem(name: "page", value: String(currentPage)),
            URLQueryItem(name: "size", value: "64")
        ]
        return components
    }
    
    var url: URL? {
        return urlComponents.url
    }
    
    fileprivate func getPagesQuantity(completionSuccess: @escaping () -> Void, completionError: @escaping (NetworkError) -> Void) {
        guard let url = url else {
            completionError(NetworkError.errorDecodingData)
            return
        }
        let request = URLRequest(url: url)
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        urlSession.dataTask(with: request) { responseData, urlResponse, responseError in
            if let data = responseData {
                do {
                    let result = try JSONDecoder().decode(ItemsResponse.self, from: data)
                    self.totalPages = result.totalPages
                    print("page \(self.currentPage) items \(self.items)")
                    completionSuccess()
                } catch {
                    completionError(NetworkError.responseError)
                }
            } else if let _ = responseError {
                completionError(NetworkError.responseError)
            }
        }.resume()
    }
    
    func getItems(completionSuccess: @escaping ((newItems: [Item], allItems: [Item])) -> Void, completionError: @escaping (Error) -> Void) {
        let downloadGroup = DispatchGroup()
        
        getPagesQuantity {
            for page in 0...self.totalPages - 1 {
                self.currentPage = page
                self.getPaginatedItems(group: downloadGroup) { items in
                    let itemsWithStore = items.map { item in
                        var newItem = item
                        newItem.store = self.store
                        return newItem
                    }
                    self.items.append(contentsOf: itemsWithStore)
                } completionError: { error in
                    completionError(NetworkError.responseError)
                }
            }
            downloadGroup.notify(queue: DispatchQueue.main) {
                let newItems = self.getNewItems(items: self.items)
                let oldItems = self.getOldItems(items: self.items)
                self.saveItems(self.items)
                completionSuccess((newItems: newItems, allItems: oldItems))
            }
        } completionError: { responseError in
            completionError(responseError)
        }
    }
    
    fileprivate func getPaginatedItems(group: DispatchGroup, completionSuccess: @escaping ([Item]) -> Void, completionError: @escaping (NetworkError) -> Void) {
        guard let url = url else {
            completionError(NetworkError.errorDecodingData)
            return
        }
        let request = URLRequest(url: url)
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        group.enter()
        urlSession.dataTask(with: request) { responseData, urlResponse, responseError in
            if let data = responseData {
                do {
                    let result = try JSONDecoder().decode(ItemsResponse.self, from: data)
                    group.leave()
                    completionSuccess(result.content)
                } catch {
                    group.leave()
                    completionError(NetworkError.responseError)
                }
            } else if let _ = responseError {
                group.leave()
                completionError(NetworkError.responseError)
            }
        }.resume()
    }
    
    func getNewItems(items: [Item]) -> [Item] {
        guard let savedItems = retrieveItems() else { return [] }
        var newItems = items.filter { !savedItems.contains($0) }
        for item in newItems.enumerated() {
            newItems[item.offset].new = true
        }
        return newItems
    }
    
    func getOldItems(items: [Item]) -> [Item] {
        guard let savedItems = retrieveItems() else { return items }
        return items.filter { savedItems.contains($0) }
    }
    
    
    fileprivate func saveItems(_ items: [Item]) {
        let key = "\(store.storeID)"
        UserDefaults.standard.setCodableObject(items, forKey: key)
    }
    
    fileprivate func retrieveItems() -> [Item]? {
        let key = "\(store.storeID)"
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: [Item].self, key: key) {
            return retrievedCodableObject
        } else {
            return nil
        }
    }
}
