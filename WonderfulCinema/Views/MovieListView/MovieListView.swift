//
//  MovieListView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListDatasource
    
    var body: some View {
        GeometryReader { geo in
            let width = viewModel.datasourceType == .trending ? geo.size.width * 6/7 : geo.size.width * 1/3
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(0..<viewModel.movies.count, id: \.self) { index in
                            switch viewModel.datasourceType {
                            case .trending:
                                PosterView(url: viewModel.movies[index].posterPath)
                                    .frame(width: width, height: 200)
                                    .id(index)
                                    .onAppear {
                                        viewModel.loadMoreIfNeedPS.send(index)
                                    }.onTapGesture {
                                        viewModel.selectedMovie = viewModel.movies[index]
                                    }
                            default:
                                MovieView(title: viewModel.movies[index].title ?? "", url: viewModel.movies[index].posterPath)
                                    .frame(width: width)
                                    .id(index)
                                    .onAppear {
                                        viewModel.loadMoreIfNeedPS.send(index)
                                    }.onTapGesture {
                                        viewModel.selectedMovie = viewModel.movies[index]
                                    }
                            }
                        }
                    }
                }
                .onReceive(viewModel.$hasFinishedRefreshing, perform: { value in
                    if value == true {
                        withAnimation { 
                            scrollView.scrollTo(0, anchor: .top)
                        }
                    }
                })
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListDatasource(datasourceType: .trending, movieAPI: MovieAPI()))
    }
}
