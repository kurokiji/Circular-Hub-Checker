//
//  Circular_Hub_CheckerApp.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import SwiftUI

@main
struct Circular_Hub_CheckerApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var favoriteItems = FavoriteItemsManager()
    @StateObject var favoriteStores = FavoriteStoresManager()
    var body: some Scene {
        WindowGroup {
            ZStack {
                if networkMonitor.isConnected {
                    TabView {
                        StoresListView(stores: [])
                            .environmentObject(favoriteStores)
                            .environmentObject(favoriteItems)
                            .tabItem {
                                Label("Tiendas", systemImage: "building.2.fill")
                            }
                        FavoriteItemsGridView(viewModel: FavoriteItemsViewModel(favoriteItemsManager: favoriteItems))
                            .environmentObject(favoriteItems)
                            .tabItem {
                                Label("Favoritos", systemImage: "heart.fill")
                            }
                    }
                   
                } else {
                    NoNetworkConnectionView()
                }
            }
            .onAppear() {
                networkMonitor.start()
            }
        }
    }
}
