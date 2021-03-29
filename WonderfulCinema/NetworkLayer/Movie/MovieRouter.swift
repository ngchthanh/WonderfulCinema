//
//  MovieRouter.swift
//  Networking
//
//  Created by Thanh Diqit on 3/26/21.
//

import Foundation
import Alamofire

enum MovieRouter: APIConfiguration {
    case genres
    case popular(page: Int)
    case trending(mediaType: MediaType, timeWindow: TimeWindow, page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case details(id: Int)
    case recommendations(id: Int, page: Int)
    case reviews(id: Int, page: Int)
    case videos(id: Int)
    case credits(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: HTTPMethod {
        switch self {
        case .popular, .trending, .topRated, .upcoming, .genres, .details, .recommendations, .reviews, .videos, .credits:
            return .get
        }
    }
    
    var parameters: Parameters {
        var params: Parameters = [
            "api_key": "a7b3c9975791294647265c71224a88ad",
            "language": "en-US"
        ]
        switch self {
        case .popular(let page):
            params["page"] = page
        case .trending(_, _, let page):
            params["page"] = page
        case .topRated(let page):
            params["page"] = page
        case .upcoming(let page):
            params["page"] = page
        case .genres:
            break
        case .details:
            break
        case .recommendations(let id, let page):
            params["page"] = page
            params["movie_id"] = id
        case .reviews(let id, let page):
            params["page"] = page
            params["movie_id"] = id
        case .videos(let id):
            params["movie_id"] = id
        case .credits(let id):
            params["movie_id"] = id
        }
        return params
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .trending(let mediaType, let timeWindow, _):
            return "trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .genres:
            return "genre/movie/list"
        case .details(let id):
            return "movie/\(id)"
        case .recommendations(let id, _):
            return "movie/\(id)/recommendations"
        case .reviews(let id, _):
            return "movie/\(id)/reviews"
        case .videos(let id):
            return "movie/\(id)/videos"
        case .credits(let id):
            return "movie/\(id)/credits"
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding())
    }
    
    var token: [String : String] {
        return [:]
    }
}
