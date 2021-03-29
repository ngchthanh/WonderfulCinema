//
//  MovieView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import SwiftUI
import Kingfisher

struct MovieView: View {
    let title: String
    let url: String?
    var body: some View {
        GeometryReader { geo in
            VStack {
                PlaceholderView().overlay(
                    KFImage.url(Helper.getImageUrl(with: url))
                        .placeholder {
                            LoadingView()
                        }
                        .cancelOnDisappear(true)
                        .resizable()
                        .fade(duration: 0.3)
                )
                .frame(width: geo.size.width, height: geo.size.width * 3/2)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                .background(
                    RoundedRectangle(cornerRadius: 6).inset(by: 8).offset(y: 8)
                        .shadow(color: Color.black.opacity(0.7), radius: 12, x: 0.0, y: 12)
                )
                .padding(.vertical, 10)
                HStack(alignment: .top) {
                    Spacer()
                    Text(title)
                        .font(.custom(AppFont.helvetica, size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(AppColor.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Image(.ic_moredetails)
                }
            }.padding(.leading, 16)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(title: "test", url: nil)
    }
}
