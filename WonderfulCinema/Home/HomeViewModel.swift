//
//  HomeViewModel.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private lazy var cancelBag = Set<AnyCancellable>()
    @Published var genreDatasource = GenreListDatasource(movieAPI: MovieAPI())
    @Published var popularDatasource = MovieListDatasource(datasourceType: .popular, movieAPI: MovieAPI())
    @Published var trendingDatasource = MovieListDatasource(datasourceType: .trending, movieAPI: MovieAPI())
    @Published var topRatedDatasource = MovieListDatasource(datasourceType: .topRated, movieAPI: MovieAPI())
    @Published var upcomingDatasource = MovieListDatasource(datasourceType: .upcoming, movieAPI: MovieAPI())
    
    @Published var selectedMovie: Movie?
    @Published var isNavigateToDetail: Bool = false
    
    @Published var isRefreshing: Bool = false
    
    init() {
        popularDatasource.$selectedMovie.assign(to: &$selectedMovie)
        trendingDatasource.$selectedMovie.assign(to: &$selectedMovie)
        topRatedDatasource.$selectedMovie.assign(to: &$selectedMovie)
        upcomingDatasource.$selectedMovie.assign(to: &$selectedMovie)
        
        $selectedMovie.compactMap { $0 != nil }.assign(to: &$isNavigateToDetail)
        
        $isRefreshing.sink { [weak self] isRefreshing in
            guard isRefreshing else { return }
            self?.popularDatasource.page = 1
            self?.trendingDatasource.page = 1
            self?.topRatedDatasource.page = 1
            self?.upcomingDatasource.page = 1
            self?.genreDatasource.loadPS.send(())
        }.store(in: &cancelBag)
        
        Publishers.CombineLatest4(popularDatasource.$hasFinishedRefreshing, trendingDatasource.$hasFinishedRefreshing, topRatedDatasource.$hasFinishedRefreshing, upcomingDatasource.$hasFinishedRefreshing)
            .combineLatest(genreDatasource.$hasFinishedRefreshing)
            .compactMap {
                $0.0.0 == true
                    && $0.0.1 == true
                    && $0.0.2 == true
                    && $0.0.3 == true
                    && $0.1 == true
                    ? false : nil
            }.assign(to: &$isRefreshing)
    }
}
