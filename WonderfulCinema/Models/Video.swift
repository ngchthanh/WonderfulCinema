//
//  Video.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation

// MARK: - Video
struct Video: Decodable, Identifiable {
    let id = UUID()
    
    let uuid: String
    let iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
