//
//  MovieListDatasource.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import Foundation
import Combine
import Alamofire

class MovieListDatasource: ObservableObject {
    enum DatasourceType: Equatable, CustomStringConvertible {
        case trending
        case popular
        case topRated
        case upcoming
        case recommendations(movieID: Int)
        
        var description: String {
            switch self {
            case .trending:
                return "TRENDING"
            case .popular:
                return "POPULAR"
            case .topRated:
                return "TOP RATED"
            case .upcoming:
                return "UPCOMING"
            case .recommendations:
                return "RECOMMENDATIONS"
            }
        }
    }
    
    let movieAPI: MovieSorting
    private lazy var cancelBag = Set<AnyCancellable>()
    let datasourceType: DatasourceType
    @Published var page: Int = 1
    @Published var movies: [Movie] = []
    @Published var selectedMovie: Movie?
    @Published private var totalPages: Int = 1
    @Published var error: Error?
    @Published var hasFinishedRefreshing: Bool = false
    
    let loadPS = PassthroughSubject<Int, Never>()
    let loadMoreIfNeedPS = PassthroughSubject<Int, Never>()
    
    init(datasourceType: DatasourceType, movieAPI: MovieSorting) {
        self.datasourceType = datasourceType
        self.movieAPI = movieAPI
        loadPS
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .map { page -> AnyPublisher<APIResponse<[Movie]>, AFError> in
                switch datasourceType {
                case .trending:
                    return movieAPI.getTrending(page: page)
                case .popular:
                    return movieAPI.getPopular(page: page)
                case .topRated:
                    return movieAPI.getTopRated(page: page)
                case .upcoming:
                    return movieAPI.getUpcoming(page: page)
                case .recommendations(let movieID):
                    return movieAPI.getRecommendations(of: movieID, page: page)
                }
            }
            .flatMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                if self?.page == 1 {
                    self?.hasFinishedRefreshing = true
                }
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.error = error
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (result) in
                guard let movies = result.results, let page = result.page else {
                    return
                }
                if page == 1 {
                    self?.movies = movies
                    self?.hasFinishedRefreshing = true
                } else {
                    self?.movies.append(contentsOf: movies)
                }
                if let totalPages = result.total_pages {
                    self?.totalPages = totalPages
                }
            })
            .store(in: &cancelBag)
        
        $page.subscribe(loadPS).store(in: &cancelBag)
        
        loadMoreIfNeedPS.sink { [weak self] index in
            guard let currentPage = self?.page, let totalPages = self?.totalPages,
                  currentPage < totalPages else {
                return
            }
            if let count = self?.movies.count, count - 3 == index {
                self?.page += 1
            }
        }.store(in: &cancelBag)
    }
}
