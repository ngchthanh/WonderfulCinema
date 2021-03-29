//
//  HomeScene.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import SwiftUI

struct HomeScene: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    Color.white.ignoresSafeArea()
                    VStack(spacing: 0) {
                        navigationBarView
                        LegacyScrollView(isRefreshing: $viewModel.isRefreshing) {
                            VStack {
                                HeaderView {
                                    Text(MovieListDatasource.DatasourceType.trending.description)
                                        .foregroundColor(AppColor.title)
                                        .font(.custom(AppFont.helvetica, size: 20))
                                        .fontWeight(.bold)
                                } rightContent: {
                                    Image(.ic_loadmore)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                }
                                .padding(.horizontal)
                                MovieListView(viewModel: viewModel.trendingDatasource).frame(height: 170)
                                HeaderView {
                                    Text("GENRE")
                                        .foregroundColor(AppColor.title)
                                        .font(.custom(AppFont.helvetica, size: 20))
                                        .fontWeight(.bold)
                                } rightContent: {
                                    Image(.ic_loadmore)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                }
                                .padding(.horizontal)
                                GenreListView(viewModel: viewModel.genreDatasource).frame(height: 76)
                                HeaderView {
                                    Text(MovieListDatasource.DatasourceType.popular.description)
                                        .foregroundColor(AppColor.title)
                                        .font(.custom(AppFont.helvetica, size: 20))
                                        .fontWeight(.bold)
                                } rightContent: {
                                    Image(.ic_loadmore)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                }
                                .padding(.horizontal)
                                MovieListView(viewModel: viewModel.popularDatasource).frame(height: 260)
                                HeaderView {
                                    Text(MovieListDatasource.DatasourceType.topRated.description)
                                        .foregroundColor(AppColor.title)
                                        .font(.custom(AppFont.helvetica, size: 20))
                                        .fontWeight(.bold)
                                } rightContent: {
                                    Image(.ic_loadmore)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                }
                                .padding(.horizontal)
                                MovieListView(viewModel: viewModel.topRatedDatasource).frame(height: 260)
                                HeaderView {
                                    Text(MovieListDatasource.DatasourceType.upcoming.description)
                                        .foregroundColor(AppColor.title)
                                        .font(.custom(AppFont.helvetica, size: 20))
                                        .fontWeight(.bold)
                                } rightContent: {
                                    Image(.ic_loadmore)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                }
                                .padding(.horizontal)
                                MovieListView(viewModel: viewModel.upcomingDatasource).frame(height: 260)
                            }.background(
                                AppColor.background
                            )
                        }
                        .ignoresSafeArea(.all, edges: .bottom)
                        .zIndex(-1)
                    }
                    NavigationLink(destination: DetailMovieScene(viewModel: DetailsMovieViewModel(movieID: viewModel.selectedMovie?.id ?? 0, movieAPI: MovieAPI())), isActive: $viewModel.isNavigateToDetail) {
                        EmptyView()
                    }
                }
                .navigationBarHidden(true)
            }.ignoresSafeArea()
        }
    }
    
    private struct OffsetPreferenceKey: PreferenceKey {
      static var defaultValue: CGFloat = .zero
      static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }
    
    private var navigationBarView: some View {
        return HStack {
            Image(.ic_user).padding()
            Spacer()
            Image(.ic_logo).padding()
            Spacer()
            Image(.ic_search).padding()
        }
        .background(Color.white)
        .background(
            VStack {
                Spacer()
                Color.black.shadow(color: AppColor.shadow.opacity(0.5), radius: 6, x: 0.0, y: 8)
            }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScene(viewModel: HomeViewModel())
    }
}





