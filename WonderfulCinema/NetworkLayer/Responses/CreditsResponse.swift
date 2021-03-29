//
//  CreditsResponse.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation

// MARK: - CreditsResponse
struct CreditsResponse: Decodable {
    let id: Int?
    let cast: [Cast]?
}

