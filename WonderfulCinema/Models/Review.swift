//
//  Review.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation

// MARK: - Review
struct Review: Decodable, Identifiable, Hashable {
    let id = UUID()
    let uuid: String?
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case uuid = "id"
        case updatedAt = "updated_at"
        case url
    }
    
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Decodable {
    let name, username, avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
