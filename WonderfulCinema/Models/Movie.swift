//
//  Movie.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage, originalTitle, overview: String?
    let releaseDate: Date?
    let posterPath: String?
    let popularity: Double?
    let title: String?
    let video: Bool?
    let voteAverage, voteCount: Double?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
