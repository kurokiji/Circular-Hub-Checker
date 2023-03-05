//
//  ReserveButton.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct ReserveButton: View {
    let storeID: String
    let listItem: Item
    let viewModel: ItemDetailsViewModel
    var body: some View {
        HStack {
            Spacer()
            Button {
                viewModel.openReservePageInSafari(item: listItem, storeID: storeID)
            } label: {
                Label("Reserva", systemImage: "safari")
            }
            .buttonStyle(GrowingButton())
            Spacer()
        }
    }
}
