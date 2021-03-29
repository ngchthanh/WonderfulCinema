//
//  APIError.swift
//  Networking
//
//  Created by Thanh Diqit on 3/26/21.
//

import Foundation

struct APIError: Decodable, LocalizedError {
    let status_message: String
    let success: Bool
    let status_code: Int
    
    var errorDescription: String? {
        return status_message
    }
}
