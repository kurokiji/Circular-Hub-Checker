//
//  ContentView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import SwiftUI
import AlertToast

struct StoreView: View {
    @EnvironmentObject var favoriteStores: FavoriteStoresManager
    @StateObject var viewModel: StoreViewModelImpl
    
    @State private var searchText = ""
    
    let noItemsMessage: String = "No se han encontrado resultados para tu búsqueda"
    let allItemsMessage: String = "Todos los artículos"
    let newItemsMessage: String = "Artículos nuevos"
    let downloadingMessage: String = "Descargando"
    let errorMessage: String = "Error"
    let rechargeMessage: String = "Toca para recargar"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.items.isEmpty
                    && !viewModel.isLoading
                    && !viewModel.errorDownloading {
                        NoItemsView(description: noItemsMessage)
                        .padding(.top, 10)
                } else if !viewModel.newItems.isEmpty {
                    Text(newItemsMessage)
                        .font(.title)
                        .bold()
                        .padding(10)
                    ItemsGridView(items: viewModel.newItems, store: viewModel.store)
                    Text(allItemsMessage)
                        .font(.title)
                        .bold()
                        .padding(10)
                }
                
                ItemsGridView(items: viewModel.items, store: viewModel.store)
            }
            .searchable(text: $viewModel.searchTerm)
            .onChange(of: viewModel.searchTerm) { newSearchTerm in
                viewModel.searchItems(by: newSearchTerm)
            }
        }
        .onAppear() {
            viewModel.getItemsIfNecesary()
        }
        .toast(isPresenting: $viewModel.isLoading) {
            AlertToast(type: .loading, title: downloadingMessage, subTitle: nil)
        }
        .toast(isPresenting: $viewModel.errorDownloading, duration: .infinity, tapToDismiss: true, alert: {
            AlertToast(type: .error(.red), title: errorMessage, subTitle: rechargeMessage)
        }, onTap: {
            viewModel.getItemsIfNecesary()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.isLoading && !viewModel.errorDownloading {
                    SortItemsMenuView(viewModel: viewModel)
                } else {
                    ProgressView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(viewModel: StoreViewModelImpl(store: ItemsMock.stores[0]))
    }
}
