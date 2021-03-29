//
//  Cast.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation

// MARK: - Cast
struct Cast: Decodable, Identifiable {
    let id = UUID()
    
    let adult: Bool?
    let gender, uuid: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case adult, gender
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}
