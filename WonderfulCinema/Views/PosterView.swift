//
//  PosterView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 24/03/2021.
//

import SwiftUI
import Kingfisher

struct PosterView: View {
    let url: String?
    var body: some View {
        PlaceholderView().overlay(
            KFImage.url(Helper.getImageUrl(with: url))
                .placeholder {
                    LoadingView()
                }
                .resizable()
                .fade(duration: 0.3)
                .cancelOnDisappear(true)
                .aspectRatio(contentMode: .fill)
        )
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 6).inset(by: 8).offset(y: 8)
                .shadow(color: AppColor.shadow, radius: 8, x: 0.0, y: 8)
        )
        .padding([.leading, .top])
        .padding(.bottom, 44)
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(url: nil)
    }
}
