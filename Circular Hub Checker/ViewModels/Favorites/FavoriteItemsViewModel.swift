//
//  FavoriteItemsViewModel.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 1/3/23.
//

import Foundation

class FavoriteItemsViewModel {
    var favoriteItemsManager: FavoriteItemsManager
    let downloadGroup = DispatchGroup()
    
    init(favoriteItemsManager: FavoriteItemsManager) {
        self.favoriteItemsManager = favoriteItemsManager
    }
    
    func checkFavorites() {
        for (index, item) in favoriteItemsManager.items.enumerated() {
            checkAvailability(for: item, index: index)
        }
    }
    
    func checkAvailability(for item: Item, index: Int) {
        fetchItemDetails(itemID: item.id) { [weak self] itemState in
            DispatchQueue.main.async {
                self?.favoriteItemsManager.items[index].state = itemState
            }
        } completionError: { error in
            print(error)
        }
        downloadGroup.notify(queue: .main) {
            self.favoriteItemsManager.save()
            self.favoriteItemsManager.objectWillChange.send()
        }
    }
    
    func fetchItemDetails(itemID: Int, completionSuccess: @escaping (ItemState) -> Void, completionError: @escaping (Error) -> Void) {
        var urlComponentes = URLComponents()
        urlComponentes.scheme = "https"
        urlComponentes.host = "web-api.ikea.com"
        urlComponentes.path = "/circular/circular-asis/api/public/offer/es/es/\(itemID)"
        
        guard let url = urlComponentes.url else { return }
        
        let request = URLRequest(url: url)
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        downloadGroup.enter()
        urlSession.dataTask(with: request) { [weak self] data, urlResponse, responseError in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ItemDetailResponse.self, from: data)
                    completionSuccess(result.state)
                } catch {
                    completionError(NetworkError.errorDecodingData)
                }
                self?.downloadGroup.leave()
            } else if let _ = responseError {
                completionError(NetworkError.responseError)
                self?.downloadGroup.leave()
            }
        }.resume()
    }
    
    func onDelete(item itemToDelete: Item) {
        favoriteItemsManager.items.removeAll { item in
            itemToDelete.id == item.id
        }
        favoriteItemsManager.save()
    }
}
