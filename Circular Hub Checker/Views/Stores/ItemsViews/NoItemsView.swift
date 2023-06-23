//
//  NoFavoriteItemsView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 5/3/23.
//

import SwiftUI

struct NoItemsView: View {
    var image: String?
    var description: String
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if let image = image {
                SwiftUI.Image(image)
                    .resizable()
                    .scaledToFit()
            }
            Text(description)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding(20)
            Spacer()
        }
        .background(Material.ultraThin, in: RoundedRectangle(cornerRadius: 10.0))
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView(image: "Appreciation-rafiki", description: "Añade algún favorito desde cualquiera de las tiendas")
    }
}
