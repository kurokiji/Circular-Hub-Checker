//
//  FavoriteItemButton.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 18/2/23.
//

import SwiftUI

struct FavoriteItemButton: View {
    @EnvironmentObject var favoriteItems: FavoriteItemsManager
    var listItem: Item
    var body: some View {
        Spacer()
        Button {
            favoriteItems.addOrRemove(listItem)
        } label: {
            Label("Icon Only", systemImage: favoriteItems.contains(listItem) ? "heart.fill" : "heart")
                .foregroundColor(.pink)
                .font(.title)
                .labelStyle(.iconOnly)
        }
        .buttonStyle(.borderless)
        .padding(.horizontal, 10)
    }
}
