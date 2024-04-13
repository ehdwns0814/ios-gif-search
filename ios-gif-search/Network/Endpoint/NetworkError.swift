//
//  Error.swift
//  ios-gif-search
//
//  Created by 동준 on 3/27/24.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case invalidURL
    case invalidResponse
    case invalidStatus
    case invalidData
    case decodingError
}
