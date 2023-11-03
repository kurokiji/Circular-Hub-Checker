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
    @State var errorDownloading: Bool = false
    @State var isLoading: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.newItems.count > 0 {
                    Text("Nuevos")
                        .font(.title)
                        .bold()
                        .padding(10)
                    ItemsGridView(items: viewModel.newItems, store: viewModel.store)
                    Text("Todos")
                        .font(.title)
                        .bold()
                        .padding(10)
                }
                ItemsGridView(items: viewModel.items, store: viewModel.store)
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newSearchTerm in
                viewModel.searchItems(by: newSearchTerm)
            }
        }
        .overlay {
            if viewModel.items.isEmpty && !isLoading && !errorDownloading {
                    NoItemsView(description: "No se han encontrado resultados para tu búsqueda")
                    .padding(.top, 10)
            }
        }
        .onAppear() {
            getItems()
        }
        .toast(isPresenting: $isLoading) {
            AlertToast(type: .loading, title: "Descargando", subTitle: nil)
        }
        .toast(isPresenting: $errorDownloading, duration: .infinity, tapToDismiss: true, alert: {
            AlertToast(type: .error(.red), title: "Error", subTitle: "Toca para recargar")
        }, onTap: {
            getItems()
        }, completion: {
            isLoading = true
            errorDownloading = false
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !isLoading && !errorDownloading {
                    SortItemsMenuView(viewModel: viewModel)
                } else {
                    ProgressView()
                }
            }
        }
    }
    
    func getItems() {
        if viewModel.itemsBackUp.isEmpty {
            isLoading = true
            viewModel.getItems {
                isLoading = false
            } completonError: {
                isLoading = false
                errorDownloading = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(viewModel: StoreViewModelImpl(store: ItemsMock.stores[0]))
    }
}
