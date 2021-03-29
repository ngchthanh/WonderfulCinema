//
//  ReviewListDatasource.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import Combine
import Alamofire

class ReviewListDatasource: ObservableObject {
    let movieAPI: MovieInformation
    private var cancelBag = Set<AnyCancellable>()
    @Published var reviews: [Review] = []
    @Published var page: Int = 1
    @Published private var totalPages: Int = 1
    @Published var error: Error?
    
    let loadMoreIfNeedPS = PassthroughSubject<Int, Never>()
    let getReviewsPS = PassthroughSubject<Int, Never>()
    
    init(movieID id: Int, movieAPI: MovieInformation) {
        self.movieAPI = movieAPI
        getReviewsPS
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .map {
                movieAPI.getReviews(of: id, page: $0)
            }
            .flatMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.error = error
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (result) in
                guard let reviews = result.results, let page = result.page else {
                    return
                }
                if page == 1 {
                    self?.reviews = reviews
                } else {
                    self?.reviews.append(contentsOf: reviews)
                }
                if let totalPages = result.total_pages {
                    self?.totalPages = totalPages
                }
            })
            .store(in: &cancelBag)
        
        $page.subscribe(getReviewsPS).store(in: &cancelBag)
        
        loadMoreIfNeedPS.sink { [weak self] index in
            guard let currentPage = self?.page, let totalPages = self?.totalPages,
                  currentPage < totalPages else {
                return
            }
            if let count = self?.reviews.count, count - 3 == index {
                self?.page += 1
            }
        }.store(in: &cancelBag)
    }
}
