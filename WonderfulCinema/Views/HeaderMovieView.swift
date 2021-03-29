//
//  HeaderMovieView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI
import Kingfisher

struct HeaderMovieView: View {
    @Binding var kinds: [String]
    @Binding var averageRating: Double
    @Binding var releaseDate: String
    @Binding var backdropPath: String
    @Binding var posterPath: String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    PlaceholderView()
                        .overlay(
                            KFImage.url(Helper.getImageUrl(with: $backdropPath.wrappedValue))
                                .fade(duration: 0.3)
                                .cancelOnDisappear(true)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        )
                        .frame(height: 220)
                        .clipped()
                    Button {} label: {
                        Image(.ic_play_blue)
                    }
                }
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading) {
                        RatingView(score: .constant(4.5), isVertical: false, fontSize: 18) {
                            Image(.ic_star_big).resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 14, height: 14, alignment: .center)
                        }
                        .frame(height: 32, alignment: .leading)
                        Text(releaseDate)
                            .font(.custom(AppFont.helvetica, size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(AppColor.primaryText)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 4) {
                                ForEach(kinds, id: \.self) {
                                    Text($0)
                                        .font(.custom(AppFont.helvetica, size: 12))
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(AppColor.blue)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        )
                                }
                            }
                        }
                    }
                    .padding(.leading, 120)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 16)
                }
            }
            HStack {
                VStack {
                    Spacer()
                    PlaceholderView().overlay(
                        KFImage.url(Helper.getImageUrl(with: $posterPath.wrappedValue))
                            .cancelOnDisappear(true)
                            .resizable()
                            .fade(duration: 0.3)
                            .aspectRatio(contentMode: .fill)
                    )
                    .frame(maxWidth: 120, maxHeight: 180)
                    .background(Color.blue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous).inset(by: 16)
                            .offset(y: 10.0)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 10)
                    )
                    .padding([.top, .leading, .trailing])
                }
                Spacer()
            }
            navigationBarView.padding(.top, 32)
        }
    }
    
    var navigationBarView: some View {
        return VStack {
            HStack {
                Button(action: {
                    action()
                }, label: {
                    Image(.ic_back)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .foregroundColor(.white)
                })
                .padding()
                Spacer()
            }
            Spacer()
        }
    }
}
