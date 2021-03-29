//
//  RatingView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct RatingView<Content: View>: View {
    @Binding var score: Double
    let content: Content
    let isVetical: Bool
    let color: Color = Color.yellow
    let fontSize: CGFloat
    var score5: Double {
        return score / 2
    }
    
    init(score: Binding<Double>, isVertical: Bool, fontSize: CGFloat = 18, @ViewBuilder content: () -> Content) {
        self._score = score
        self.isVetical = isVertical
        self.fontSize = fontSize
        self.content = content()
    }
    
    var body: some View {
        Group {
            if isVetical {
                VStack(spacing: 8) {
                    starsView
                    Text(String(format: "%.1f", score5))
                        .font(.custom(AppFont.helvetica, size: fontSize))
                        .bold()
                        .foregroundColor(score == 0 ? AppColor.placehold : color)
                }
            } else {
                HStack(spacing: 8) {
                    Text(String(format: "%.1f", score5))
                        .font(.custom(AppFont.helvetica, size: fontSize))
                        .bold()
                        .foregroundColor(score == 0 ? AppColor.placehold : color)
                    starsView
                    Spacer()
                }
            }
        }
    }
    
    private var starsView: some View {
        return HStack(spacing: 0) {
            ForEach(0...4, id: \.self) { index in
                GeometryReader { geo in
                    Button(action: {
                        score = Double(index + 1) * 2
                    }, label: {
                        AppColor.placehold
                            .overlay(
                                Rectangle()
                                    .foregroundColor(Double(index) <= score5.rounded() ? color : AppColor.placehold)
                                    .offset(x: calculateOffset(width: geo.size.width, score: score5, index: Double(index)))
                            )
                            .mask(
                                content
                            )
                    }).id(index)
                }
            }
        }
    }
    
    private func calculateOffset(width: CGFloat, score: Double, index: Double) -> CGFloat {
        var ratioOffset: Double = -1
        if score - index > 0 && score - index < 1 {
            ratioOffset = -1 + (score - index)
        } else if score > index {
            ratioOffset = 0
        }
        return width * CGFloat(ratioOffset)
    }
}
