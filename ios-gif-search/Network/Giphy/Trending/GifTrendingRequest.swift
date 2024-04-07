//
//  GifTrendingRequest.swift
//  ios-gif-search
//
//  Created by 동준 on 4/4/24.
//

import Foundation

struct GifTrendingRequest: GiphyAPIRequest {
    typealias APIResponse = GifTrendingResponse

    let type: GifType
    let method: HTTPMethod = .get
    var path: String {
        switch type {
        case .gif:
            return "gifs/trending"
        case .sticker:
            return "stickers/trending"
        }
    }
    
    let headers: [String : String]? = nil
    let limit: Int = 10
    let offset: Int
    
    var parameters: [String : String] {
        [
            "api_key": Secrets.APIKey,
            "limit": String(limit),
            "offset": String(offset)
        ]
    }
}
