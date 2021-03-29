//
//  Helper.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 24/03/2021.
//

import Foundation

struct Helper {
    static func getImageUrl(with path: String?) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(path ?? "")")
    }
    
    static func getThumbnailVideo(with path: String?) -> URL? {
        return URL(string: "https://i.ytimg.com/vi/\(path ?? "")/mqdefault.jpg")
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
