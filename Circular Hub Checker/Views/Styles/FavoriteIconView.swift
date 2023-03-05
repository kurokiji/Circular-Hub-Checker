//
//  FavoriteIconView.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 3/3/23.
//

import SwiftUI

public struct FavoriteIconView: View {
    @EnvironmentObject var favoriteItems: FavoriteItemsManager
    var listItem: Item
    
    var isLiked: Bool {
        return favoriteItems.contains(listItem)
    }
    
    public var body: some View {
            Button {
                favoriteItems.addOrRemove(listItem)
            } label: {
                ZStack{
                    SwiftUI.Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(isLiked ? .title : .title2)
                        .foregroundColor(Color(isLiked ? .systemPink : .systemGray))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: isLiked)
                    
                    Circle()
                        .strokeBorder(lineWidth: isLiked ? 0 : 35)
                        .animation(.easeInOut(duration: 0.5).delay(0.1),value: isLiked)
                        .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.yellow))
                        .hueRotation(.degrees(isLiked ? 300 : 200))
                        .scaleEffect(isLiked ? 1.3 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isLiked)
                    
                    SwiftUI.Image("splash")
                        .opacity(isLiked ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5).delay(0.25), value: isLiked)
                        .scaleEffect(isLiked ? 1.5 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isLiked)
                    
                    SwiftUI.Image("splash")
                        .rotationEffect(.degrees(90))
                        .opacity(isLiked ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5).delay(0.2), value: isLiked)
                        .scaleEffect(isLiked ? 1.5 : 0)
                        .animation(.easeOut(duration: 0.5), value: isLiked)
                }
            }
    }
}

struct LikeTweetView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteIconView(listItem: Item(id: 23, title: "", description: "", price: 34, heroImage: "", articlesPrice: 23, currency: "", priority: nil))
            .preferredColorScheme(.light)
    }
}
