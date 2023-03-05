//
//  StoresViewModel.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 21/1/23.
//

import Foundation

class StoresViewModel {
    
    init() {}
    
    func fetchStores(completionSuccess: @escaping (StoreResponse) -> Void, completionError: @escaping (Error) -> Void) {
        var urlComponentes = URLComponents()
        urlComponentes.scheme = "https"
        urlComponentes.host = "web-api.ikea.com"
        urlComponentes.path = "/circular/circular-asis/api/public/stores/es"
        guard let url = urlComponentes.url else { return }
        let request = URLRequest(url: url)
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        urlSession.dataTask(with: request) { data, urlResponse, responseError in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(StoreResponse.self, from: data)
                    completionSuccess(result)
                } catch {
                    completionError(NetworkError.errorDecodingData)
                }
            } else if let _ = responseError {
                completionError(NetworkError.responseError)
            }
        }.resume()
    }
    
    func addToFavorites(_ store: Store?, favoriteStores: FavoriteStoresManager) {
        if favoriteStores.contains(store) {
            favoriteStores.remove(store)
        } else {
            favoriteStores.add(store)
        }
    }
}
