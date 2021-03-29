//
//  DetailMovieScene.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct DetailMovieScene: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: DetailsMovieViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            AppColor.background.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 16) {
                    HeaderMovieView(kinds: $viewModel.genres, averageRating: $viewModel.rating, releaseDate: $viewModel.releaseDate, backdropPath: $viewModel.backdropPath, posterPath: $viewModel.posterPath) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    DesciptionView(isReadMore: $viewModel.isReadmore, title: $viewModel.title, description: $viewModel.overview)
                        .padding(.horizontal)
                    favoriteButton
                        .frame(height: 50)
                        .padding()
                    Group {
                        HeaderView {
                            Text("Your Rate").bold()
                                .font(.custom(AppFont.helvetica, size: 18))
                                .foregroundColor(AppColor.title)
                        } rightContent: {}
                        .padding()
                        .background(AppColor.headerBackground)
                        HStack {
                            Spacer()
                            yourRateView.padding()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                    }
                    Group {
                        HeaderView {
                            Text("Series Cast").bold()
                                .font(.custom(AppFont.helvetica, size: 18))
                                .foregroundColor(AppColor.title)
                        } rightContent: {}
                        .padding()
                        .background(AppColor.headerBackground)
                        CastListView(viewModel: viewModel.castListDatasource)
                    }
                    Group {
                        HeaderView {
                            Text("Video").bold()
                                .font(.custom(AppFont.helvetica, size: 18))
                                .foregroundColor(AppColor.title)
                        } rightContent: {}
                        .padding()
                        .background(AppColor.headerBackground)
                        VideoListView(viewModel: viewModel.videoListDatasource)
                    }
                    Group {
                        HeaderView {
                            Text("Comments").bold()
                                .font(.custom(AppFont.helvetica, size: 18))
                                .foregroundColor(AppColor.title)
                        } rightContent: {
                            Image(.ic_loadmore)
                        }
                        .padding()
                        .background(AppColor.headerBackground)
                        ReviewListView(viewModel: viewModel.reviewListDatasoure)
                            .frame(maxHeight: 400)
                    }
                    Group {
                        HeaderView {
                            Text("Recomendations").bold()
                                .font(.custom(AppFont.helvetica, size: 18))
                                .foregroundColor(AppColor.title)
                        } rightContent: {
                            Image(.ic_loadmore)
                        }
                        .padding()
                        .background(AppColor.headerBackground)
                        MovieListView(viewModel: viewModel.recommendationDatasource)
                            .frame(height: 260)
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
    
    var favoriteButton: some View {
        return HStack {
            Button(action: {
                //
            }, label: {
                HStack(spacing: 26) {
                    Image(.ic_add)
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                    Text("Favorite").bold()
                        .font(.custom(AppFont.helvetica, size: 16))
                        .foregroundColor(.white)
                    HStack {
                        Divider()
                        Image(.ic_triangle_down)
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(AppColor.blueless)
                )
            })
        }
        
    }
    
    var yourRateView: some View {
        return VStack(alignment: .center, spacing: 16) {
            RatingView(score: $viewModel.yourRating, isVertical: true, fontSize: 22) {
                Image(.ic_star_big).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28, alignment: .center)
            }
            .frame(maxHeight: 64, alignment: .center)
            Button {} label: {
                Text("WRITE A COMMENT").bold()
                    .font(.custom(AppFont.helvetica, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(
                        AppColor.blue.cornerRadius(6, antialiased: true)
                    )
            }
        }
    }
}

struct ContentOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct DetailMovieScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieScene(viewModel: DetailsMovieViewModel(movieID: 23, movieAPI: MovieAPI()))
    }
}
