//
//  FavoriteItemCellView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 1/3/23.
//

import SwiftUI

struct FavoriteItemCellView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let item: Item
    
    var body: some View {
        HStack {
            ZStack {
                AsyncImage(
                    url: URL(string: item.heroImage),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 60, maxHeight: 60)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 13))
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .lineLimit(1)
                if let store = item.store {
                    Text(store.name)
                        .lineLimit(1)
                        .font(.subheadline)
                }
                Group {
                    if item.state == .published {
                        Text(item.getFormattedPrice(price: item.price) ?? "0")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    } else {
                        Text("AGOTADO")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                .padding(10)
                .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10.0))
            }
            .padding( 10)
        }
    }
}

struct FavoriteItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItemCellView(item: ItemsMock.item)
    }
}
