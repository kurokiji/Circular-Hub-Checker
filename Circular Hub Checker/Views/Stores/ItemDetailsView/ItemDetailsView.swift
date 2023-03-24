//
//  ItemDetailsView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 21/1/23.
//

import SwiftUI

struct ItemDetailsView: View {
    @Environment(\.openURL) var openURL
    var listItem: Item
    @State var itemDetail: ItemDetail?
    let viewModel: ItemDetailsViewModel = ItemDetailsViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                if let item = itemDetail {
                    ZStack {
                        ImagesCarousselView(proxy: proxy, item: item)
                        PriceOverlayView(listItem: listItem, item: item)
                    }
                    .frame(height: proxy.size.width)
                    ItemDescriptionView(item: item)
                    Spacer()
                    if let storeID = listItem.store?.storeID {
                        ReserveButton(storeID: storeID, listItem: listItem, viewModel: viewModel)
                    }
                }
            }
        }
        .onAppear() {
            viewModel.fetchItemDetails(itemID: listItem.id) { response in
                itemDetail = response
            } error: { error in
                print(error)
            }
        }
    }
}

//struct ItemDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailsView(listItem: ItemsMock.item, itemDetail: ItemsMock.itemDetail)
//    }
//}
