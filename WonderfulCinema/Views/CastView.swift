//
//  CastView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import SwiftUI
import Kingfisher

struct CastView: View {
    let url: String?
    let name: String?
    let character: String?
    
    var body: some View {
        VStack(alignment: .center) {
            PlaceholderView()
                .overlay(
                    KFImage.url(Helper.getImageUrl(with: url))
                        .resizable()
                        .fade(duration: 0.3)
                        .cancelOnDisappear(true)
                        .aspectRatio(contentMode: .fill)
                )
                .frame(width: 76, height: 102)
                .clipShape(
                    RoundedRectangle(cornerRadius: 3, style: .continuous)
                )
                .background(
                    RoundedRectangle(cornerRadius: 3, style: .continuous).inset(by: 3)
                        .offset(y: 3)
                        .shadow(color: AppColor.shadow, radius: 3, x: 0.0, y: 3)
                ).padding(.bottom, 8)
            VStack(alignment: .leading) {
                Text(name ?? "").font(.custom(AppFont.helvetica, size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(AppColor.title)
                    .lineLimit(1)
                Text(character ?? "").font(.custom(AppFont.helvetica, size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(AppColor.placehold)
                    .lineLimit(1)
            }
        }
    }
}

