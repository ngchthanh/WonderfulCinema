//
//  LoadingView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            EmptyView()
                .aspectRatio(1, contentMode: .fit)
            GeometryReader { geometry in
                let width = geometry.size.width / 5
                let height = geometry.size.height / 5
                ForEach(0..<5) { index in
                    let scale = !isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5
                    let offset = geometry.size.width / 10 - geometry.size.height / 2
                    Group {
                        Circle().foregroundColor(Color.white)
                            .frame(width: width, height: height)
                            .scaleEffect(scale)
                            .offset(y: offset)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
                    .animation(
                        Animation.timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false)
                    )
                }
            }
            .frame(width: 44, height: 44, alignment: .center)
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}
