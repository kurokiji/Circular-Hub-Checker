//
//  FavoriteItems.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 18/2/23.
//

import SwiftUI

struct FavoriteItemsGridView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var favoriteItemsManager: FavoriteItemsManager
    var viewModel: FavoriteItemsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.favoriteItemsManager.items.isEmpty {
                    GeometryReader { geometry in
                        NoItemsView(image: "Appreciation-rafiki", description: "Añade algún favorito desde cualquiera de las tiendas")
                            .frame(width: geometry.size.width / 1.2, height: geometry.size.height / 1.6)
                            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY - 20)
                    }
                } else {
                    List {
                        ForEach(favoriteItemsManager.items) { item in
                            Group {
                                if item.state == .published {
                                    NavigationLink(destination: {
                                        ItemDetailsView(listItem: item)
                                            .navigationTitle(item.title)
                                    }, label: {
                                        FavoriteItemCellView(item: item)
                                    })
                                } else {
                                    FavoriteItemCellView(item: item)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive, action: { viewModel.onDelete(item: item) } ) {
                                    Label("Eliminar", systemImage: "heart.slash.fill")
                                        .labelStyle(.iconOnly)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Favoritos"))
        }
        .onAppear() {
            viewModel.checkFavorites()
        }
    }
}

struct FavoriteItems_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItemsGridView(viewModel: FavoriteItemsViewModel(favoriteItemsManager: FavoriteItemsManager()))
    }
}
