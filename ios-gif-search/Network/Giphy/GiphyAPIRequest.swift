//
//  GifAPIRequest.swift
//  ios-gif-search
//
//  Created by 동준 on 4/3/24.
//

import Foundation

protocol GiphyAPIRequest: APIRequestable { }

extension GiphyAPIRequest {
    var baseURL: URL? {
        return URL(string: "https://api.giphy.com/v1/")
    }
}
