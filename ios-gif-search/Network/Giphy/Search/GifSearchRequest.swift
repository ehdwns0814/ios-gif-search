//
//  SearchRequest.swift
//  ios-gif-search
//
//  Created by 동준 on 4/2/24.
//

import Foundation

struct GifSearchRequest: GiphyAPIRequest {
    typealias APIResponse = GifSearchResponse
    
    let type: GifType
    let method: HTTPMethod = .get
    var path: String {
        switch type {
        case .gif:
            return "gifs/search"
        case .sticker:
            return "stickers/trending"
        }
    }
    
    let headers: [String : String]? = nil
    let query: String
    let limit: Int = 15
    let offset: Int

    var parameters: [String : String] {
        [
            "api_key": Secrets.APIKey,
            "q": query,
            "limit": String(limit),
            "offset": String(offset)
        ]
    }
}
