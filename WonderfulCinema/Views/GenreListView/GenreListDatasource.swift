//
//  GenreListDatasource.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import Foundation
import Combine

class GenreListDatasource: ObservableObject {
    let movieAPI: MovieGenre
    private lazy var cancelBag = Set<AnyCancellable>()
    let loadPS = PassthroughSubject<Void, Never>()
    @Published private(set) var genres: [Genre] = []
    @Published var error: Error?
    @Published var hasFinishedRefreshing: Bool = false

    init(movieAPI: MovieGenre) {
        self.movieAPI = movieAPI
        loadPS.map {
            movieAPI.getGenres()
        }.flatMap {
            $0
        }.receive(on: DispatchQueue.main)
        .sink { [weak self] (completion) in
            self?.hasFinishedRefreshing = true
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] (response) in
            self?.hasFinishedRefreshing = true
            self?.genres = response.genres
        }.store(in: &cancelBag)
        
        loadPS.send(())
    }
}
