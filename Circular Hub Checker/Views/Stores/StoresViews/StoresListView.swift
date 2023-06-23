//
//  StoresView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 21/1/23.
//

import SwiftUI
import AlertToast

struct StoresListView: View {
    var viewModel = StoresViewModel()
    @State var stores: [Store]
    @EnvironmentObject var favoriteStores: FavoriteStoresManager
    
    @State var isLoading: Bool = true
    @State var errorDownloading: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stores) { store in
                    NavigationLink {
                        StoreView(viewModel: StoreViewModelImpl(store: store))
                            .navigationTitle(Text(store.name))
                    } label: {
                        HStack {
                            //                            Button {
                            //                                viewModel.addToFavorites(store, favoriteStores: favoriteStores)
                            //                            } label: {
                            //                                Label("Icon Only", systemImage: favoriteStores.contains(store) ? "heart.fill" : "heart")
                            //                                    .font(.title2)
                            //                                    .labelStyle(.iconOnly)
                            //                            }
                            //                            .buttonStyle(.borderless)
                            //                            .padding(.vertical, 7)
                            //                            .padding(.trailing, 5)
                            Text(store.name)
                                .font(.title3)
                            Spacer()
                            //                            if favoriteStores.contains(store) {
                            //                                Text("3")
                            //                                    .foregroundColor(.white)
                            //                                    .background {
                            //                                        Circle()
                            //                                            .foregroundColor(.gray)
                            //                                            .frame(width: 25, height: 25)
                            //                                    }
                            //                                    .padding(.horizontal, 10)
                            //                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Tiendas"))
        }
        .onAppear() {
            getStores()
        }
        .toast(isPresenting: $isLoading) {
            AlertToast(type: .loading, title: "Descargando", subTitle: nil)
        }
        .toast(isPresenting: $errorDownloading, duration: .infinity, tapToDismiss: true, alert: {
            AlertToast(type: .error(.red), title: "Error", subTitle: "Toca para recargar")
        }, onTap: {
            getStores()
        }, completion: {
            isLoading = true
            errorDownloading = false
        })
    }
    
    func getStores() {
        viewModel.fetchStores { response in
            stores = response
            isLoading = false
        } completionError: { error in
            isLoading = false
            errorDownloading = true
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresListView(stores: ItemsMock.stores)
    }
}
