//
//  ItemView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import SwiftUI

struct ItemCellView: View {
    @Environment(\.colorScheme) var colorScheme
    let item: Item
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(
                    url: URL(string: item.heroImage),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .frame(minWidth: 180, minHeight: 180)
                .clipShape(RoundedRectangle(cornerRadius: 13))
                
                VStack {
                    if let new = item.new, new {
                        NewTagView()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text(item.getFormattedPrice(price: item.price) ?? "0")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(10)
                            .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10.0))
                    }
                    .padding(10)
                }
            }
            Text(item.title)
                .font(.subheadline)
                .frame(height: 15)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
    }
}

struct ItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCellView(item: ItemsMock.items[0])
            .frame(width: 200, height: 200)
    }
}


