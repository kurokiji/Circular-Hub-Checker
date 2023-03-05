//
//  NoNetworkConnectionView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import SwiftUI

struct NoNetworkConnectionView: View {
    var body: some View {
        VStack(alignment: .center) {
            SwiftUI.Image(systemName: "wifi")
                .font(.largeTitle)
                .padding(.bottom, 5)
            Text("Sin internet")
                .font(.title)
                .bold()
            Text("Necesitas estar conectado a internet para poder utilizar esta aplicación")
                .multilineTextAlignment(.center)
                .font(.caption)
        }
        .frame(width: 200)
    }
}

struct NoNetworkConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkConnectionView()
    }
}
