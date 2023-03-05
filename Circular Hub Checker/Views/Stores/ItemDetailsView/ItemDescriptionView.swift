//
//  ItemDescriptionView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct ItemDescriptionView: View {
    let item: ItemDetail
    var body: some View {
        Group {
            Text(item.title)
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .padding(.top, 5)
            Text(item.description)
                .font(.body)
                .padding(.horizontal, 20)
        }
    }
}
