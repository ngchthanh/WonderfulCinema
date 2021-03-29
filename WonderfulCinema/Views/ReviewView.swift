//
//  ReviewView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI
import Kingfisher

struct ReviewView: View {
    let name: String
    let comment: String
    let stars: Double
    let date: Date
    let url: String?
    
    var body: some View {
        HStack(alignment: .top) {
            PlaceholderView().overlay(
                KFImage(Helper.getImageUrl(with: url))
                    .resizable()
                    .fade(duration: 0.3)
                    .cancelOnDisappear(true)
                    .aspectRatio(contentMode: .fill)
            )
            .clipShape(Circle())
            .overlay(
                Circle().stroke(AppColor.placehold, lineWidth: 1)
            )
            .frame(width: 40, height: 40, alignment: .center)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.custom(AppFont.helvetica, size: 22))
                    .bold()
                    .foregroundColor(AppColor.title)
                Text(comment)
                    .font(.custom(AppFont.helvetica, size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(AppColor.primaryText)
                    .lineLimit(2)
                HStack {
                    RatingView(score: .constant(stars), isVertical: false, fontSize: 12) {
                        Image(.ic_star_small)
                    }
                    .frame(width: 160, height: 22)
                    .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .frame(alignment: .leading)
                Text(Helper.dateFormatter.string(from: date))
                    .font(.custom(AppFont.helvetica, size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(AppColor.placehold)
                Divider()
            }
        }
    }
}
