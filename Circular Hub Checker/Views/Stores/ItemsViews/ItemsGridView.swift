//
//  ItemsGridView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct ItemsGridView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let gridItem = [GridItem(.flexible(minimum: 20), spacing: 7),
                    GridItem(.flexible(minimum: 20), spacing: 7)]
    var items: [Item]
    var store: Store
    
    var body: some View {
        LazyVGrid(columns: gridItem) {
            ForEach(items) { item in
                NavigationLink(destination: {
                    ItemDetailsView(listItem: item)
                        .navigationTitle(item.title)
                }, label: {
                    ItemCellView(item: item)
                })
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .padding(.horizontal, 5)
    }
}

struct ItemsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsGridView(items: ItemsMock.items, store: ItemsMock.stores[0])
    }
}

