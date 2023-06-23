//
//  ItemDetailsViewModel.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 21/1/23.
//

import Foundation
import SwiftUI

class ItemDetailsViewModel {
    init() {}
    
    func fetchItemDetails(itemID: Int, completion: @escaping (ItemDetailResponse) -> Void, error: @escaping (Error) -> Void) {
        var urlComponentes = URLComponents()
        urlComponentes.scheme = "https"
        urlComponentes.host = "web-api.ikea.com"
        urlComponentes.path = "/circular/circular-asis/api/public/offer/es/es/\(itemID)"
        
        guard let url = urlComponentes.url else { return }
        
        let request = URLRequest(url: url)
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        urlSession.dataTask(with: request) { data, urlResponse, responseError in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ItemDetailResponse.self, from: data)
                    completion(result)
                } catch {
                    print("JSON String: \(String(data: data, encoding: .utf8))")
                }
            } else if let responseError = responseError {
                error(responseError)
            }
        }.resume()
    }
    
    func openReservePageInSafari(item: Item, storeID: String) {
        if let url = URL(string: "https://www.ikea.com/es/es/customer-service/services/buy-back/tienda-de-segunda-mano-ikea-pub8ed94ff0#\(storeID)/\(item.id)") {
            print("ARTICLE", url)
            UIApplication.shared.open(url)
        }
    }
}
