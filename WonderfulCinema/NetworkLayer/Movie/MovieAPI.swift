//
//  MovieAPI.swift
//  Networking
//
//  Created by Thanh Diqit on 3/26/21.
//

import Foundation
import Alamofire
import Combine

protocol MovieSorting {
    func getPopular(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
    func getTrending(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
    func getTopRated(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
    func getUpcoming(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
    func getRecommendations(of movieID: Int, page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
}

protocol MovieGenre {
    func getGenres() -> AnyPublisher<GenreResponse, AFError>
}

protocol MovieInformation {
    func getDetails(movieID id: Int) -> AnyPublisher<MovieDetails, AFError>
    func getCredits(movieID id: Int) -> AnyPublisher<CreditsResponse, AFError>
    func getVideos(of movieID: Int) -> AnyPublisher<APIResponse<[Video]>, AFError>
    func getReviews(of movieID: Int, page: Int) -> AnyPublisher<APIResponse<[Review]>, AFError>
    func getRecommendations(of movieID: Int, page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError>
}

struct MovieAPI: MovieSorting, MovieGenre, MovieInformation {
    func getGenres() -> AnyPublisher<GenreResponse, AFError> {
        return AF.request(MovieRouter.genres)
            .validateAPIError()
            .publishDecodable(type: GenreResponse.self, queue: .global(), decoder: JSONDecoder())
            .value()
    }
    
    func getPopular(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.popular(page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Movie]>.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
    
    func getTrending(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.trending(mediaType: .all, timeWindow: .week, page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Movie]>.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
    
    func getTopRated(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.topRated(page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Movie]>.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
    
    func getUpcoming(page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.topRated(page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Movie]>.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
    
    func getDetails(movieID id: Int) -> AnyPublisher<MovieDetails, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.details(id: id))
            .validateAPIError()
            .publishDecodable(type: MovieDetails.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
    
    func getCredits(movieID id: Int) -> AnyPublisher<CreditsResponse, AFError> {
        return AF.request(MovieRouter.credits(id: id))
            .validateAPIError()
            .publishDecodable(type: CreditsResponse.self, queue: .global(), decoder: JSONDecoder())
            .value()
    }
    
    func getVideos(of movieID: Int) -> AnyPublisher<APIResponse<[Video]>, AFError> {
        return AF.request(MovieRouter.videos(id: movieID))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Video]>.self, queue: .global(), decoder: JSONDecoder())
            .value()
    }
    
    func getReviews(of movieID: Int, page: Int) -> AnyPublisher<APIResponse<[Review]>, AFError> {
        return AF.request(MovieRouter.reviews(id: movieID, page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Review]>.self, queue: .global(), decoder: JSONDecoder())
            .value()
    }
    
    func getRecommendations(of movieID: Int, page: Int) -> AnyPublisher<APIResponse<[Movie]>, AFError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Helper.releaseDateFormatter)
        return AF.request(MovieRouter.recommendations(id: movieID, page: page))
            .validateAPIError()
            .publishDecodable(type: APIResponse<[Movie]>.self, queue: .global(), decoder: jsonDecoder)
            .value()
    }
}

extension DataRequest {
    func validateAPIError() -> Self {
        return validate { (_, _, data) -> ValidationResult in
            do {
                let apiError = try JSONDecoder().decode(APIError.self, from: data!)
                return .failure(apiError)
            } catch {
                return .success(Void())
            }
        }
    }
}
