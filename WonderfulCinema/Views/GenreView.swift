//
//  GenreView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct GenreView: View {
    let title: String
    let isOdd: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            let colors = [Color.red, Color.blue, Color.pink, Color.purple, Color.green, Color.orange]
            let random = colors.randomElement() ?? Color.blue
            LinearGradient(gradient: Gradient(colors: [random.lighter(by: 30), random]), startPoint: isOdd ? .bottomTrailing : .topLeading, endPoint: isOdd ? .topLeading : .bottomTrailing)
                .clipShape(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                )
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 4)
                )
            Text(title).font(.custom(AppFont.helvetica, size: 16))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }.padding(.bottom)
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(title: "Test", isOdd: false)
    }
}
