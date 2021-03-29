//
//  APIResponse.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 23/03/2021.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let id: Int?
    let results: T?
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
    
    let success: Bool?
    let status_code: Int?
    let status_message: String?
}
