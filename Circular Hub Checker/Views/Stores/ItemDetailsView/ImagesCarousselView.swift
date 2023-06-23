//
//  ImagesCarousselView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct ImagesCarousselView: View {
    let proxy: GeometryProxy
    let item: ItemDetail
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(proxy.size.width))],
                      content: {
                ForEach(item.images) { image in
                    AsyncImage(
                        url: URL(string: image.url),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: proxy.size.width, minHeight: proxy.size.width)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(minWidth: proxy.size.width, minHeight: proxy.size.width)
                        }
                    )
                }
            })
        }
    }
    func dale(url: String) {
        print(url)
    }
}
