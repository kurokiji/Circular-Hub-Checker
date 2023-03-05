//
//  SortItemsMenuView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 5/3/23.
//

import SwiftUI

struct SortItemsMenuView: View {
    var viewModel: StoreViewModelImpl
    var body: some View {
        Menu {
            Menu("Precio") {
                Button("Ascendente") {
                    viewModel.sortItems(by: \.price, using: <)
                }
                Button("Descendente") {
                    viewModel.sortItems(by: \.price, using: >)
                }
            }
            Menu("Nombre") {
                Button("Ascendente") {
                    viewModel.sortItems(by: \.title, using: <)
                }
                Button("Descendente") {
                    viewModel.sortItems(by: \.title, using: >)
                }
            }
            Menu("Fecha") {
                Button("Nuevos primero") {
                    viewModel.sortItems(by: \.id, using: >)
                }
                Button("Antiguos primero") {
                    viewModel.sortItems(by: \.id, using: <)
                }
            }
            
        } label: {
            Text("\(viewModel.items.count + viewModel.newItems.count) items").font(.headline)
        }
    }
}


struct SortItemsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortItemsMenuView(viewModel: StoreViewModelImpl(store: Store(id: 32, storeID: "023", name: "", email: nil, timezone: .europeMadrid, openHour: 0, closeHour: 0, reservedHours: 0, items: nil, countryCode: .es)))
    }
}
