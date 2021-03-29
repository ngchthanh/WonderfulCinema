//
//  PlaceholderView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
