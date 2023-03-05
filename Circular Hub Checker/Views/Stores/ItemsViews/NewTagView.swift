//
//  NewTagView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 5/3/23.
//

import SwiftUI

struct NewTagView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Text("NEW")
                .font(.system(size: 12))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(7)
                .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10.0))
            Spacer()
        }
        .padding(5)
    }
}

struct NewTagView_Previews: PreviewProvider {
    static var previews: some View {
        NewTagView()
    }
}
