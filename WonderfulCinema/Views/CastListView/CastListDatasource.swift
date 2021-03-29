//
//  CastListDatasource.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import Combine
import Alamofire

class CastListDatasource: ObservableObject {
    let movieAPI: MovieInformation
    @Published private(set) var casts: [Cast] = []
    @Published var error: Error?
    
    let getCreditsPS = PassthroughSubject<Int, AFError>()
    private var cancelBag = Set<AnyCancellable>()
    
    init(movieID id: Int?, movieAPI: MovieInformation) {
        self.movieAPI = movieAPI
        getCreditsPS.map {
            movieAPI.getCredits(movieID: $0)
        }
        .flatMap {
            $0
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] (completion) in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] (resutl) in
            self?.casts = resutl.cast ?? []
        }
        .store(in: &cancelBag)
        
        guard let id = id else { return }
        getCreditsPS.send(id)
    }
}
