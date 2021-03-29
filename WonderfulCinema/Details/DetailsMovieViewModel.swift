//
//  DetailsMovieViewModel.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import Foundation
import Combine

class DetailsMovieViewModel: ObservableObject {
    typealias MovieInformationAndSorting = MovieInformation & MovieSorting
    let movieAPI: MovieInformationAndSorting
    private lazy var cancelBag = Set<AnyCancellable>()
    @Published private(set) var movieDetails: MovieDetails?
    @Published var releaseDate: String = ""
    @Published var backdropPath: String = ""
    @Published var posterPath: String = ""
    @Published var title: String = ""
    @Published var isReadmore: Bool = false
    @Published var overview: String = ""
    @Published var genres: [String] = []
    @Published var rating: Double = 0
    @Published var yourRating: Double = 0
    @Published var error: Error?
    
    @Published private(set) var castListDatasource: CastListDatasource
    @Published private(set) var videoListDatasource: VideoListDatasource
    @Published private(set) var reviewListDatasoure: ReviewListDatasource
    @Published private(set) var recommendationDatasource: MovieListDatasource
    
    let getDetailsPS = PassthroughSubject<Int, Never>()
    
    init(movieID id: Int, movieAPI: MovieInformationAndSorting) {
        self.movieAPI = movieAPI
        castListDatasource = CastListDatasource(movieID: id, movieAPI: movieAPI)
        videoListDatasource = VideoListDatasource(movieID: id, movieAPI: movieAPI)
        reviewListDatasoure = ReviewListDatasource(movieID: id, movieAPI: movieAPI)
        recommendationDatasource = MovieListDatasource(datasourceType: .recommendations(movieID: id), movieAPI: movieAPI)
        
        getDetailsPS.map {
            movieAPI.getDetails(movieID: $0)
        }
        .flatMap { $0 }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] (completion) in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] result in
            self?.movieDetails = result
        }.store(in: &cancelBag)
        
        $movieDetails.compactMap {
            Helper.dateFormatter.string(from: $0?.releaseDate ?? Date())
        }.assign(to: &$releaseDate)
        $movieDetails.compactMap {
            $0?.backdropPath
        }.assign(to: &$backdropPath)
        $movieDetails.compactMap {
            $0?.posterPath
        }.assign(to: &$posterPath)
        $movieDetails.compactMap {
            $0?.title
        }.assign(to: &$title)
        $movieDetails.compactMap {
            $0?.overview
        }.assign(to: &$overview)
        $movieDetails.compactMap {
            $0?.genres
        }.compactMap {
            $0.compactMap { $0.name }
        }.assign(to: &$genres)
        $movieDetails.compactMap {
            $0?.voteAverage
        }.assign(to: &$rating)
        getDetailsPS.send(id)
    }
}
