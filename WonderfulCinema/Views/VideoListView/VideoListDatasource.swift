//
//  VideoListDatasource.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import Combine
import Alamofire

class VideoListDatasource: ObservableObject {
    @Published var videos: [Video] = []
    @Published var error: Error?
    let getVideosPS = PassthroughSubject<Void, Never>()
    let movieAPI: MovieInformation
    private var cancelBag = Set<AnyCancellable>()
    
    init(movieID id: Int, movieAPI: MovieInformation) {
        self.movieAPI = movieAPI
        getVideosPS
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .map {
                movieAPI.getVideos(of: id)
            }.flatMap {
                $0
            }.receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.error = error
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                guard let videos = result.results else {
                    return
                }
                self?.videos = videos
            }.store(in: &cancelBag)
        
        getVideosPS.send(())
    }
}
