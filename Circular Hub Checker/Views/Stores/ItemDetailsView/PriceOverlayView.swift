//
//  PriceOverlayView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct PriceOverlayView: View {
    @Environment(\.colorScheme) var colorScheme
    let listItem: Item
    let item: ItemDetail
    var body: some View {
        VStack {
            Spacer()
            HStack {
                HStack {
                    Text(listItem.getFormattedPrice(price: listItem.articlesPrice) ?? "Sin precio")
                        .font(.system(size: 20))
                        .strikethrough()
                        .padding(.trailing, 10)
                    Text(listItem.getFormattedPrice(price: item.price) ?? "Sin precio")
                        .font(.system(size: 25))
                        .bold()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10.0))
                Spacer()
                FavoriteIconView(listItem: listItem)
            }
        }
        .padding(10)
    }
}
