//
//  GiphyService.swift
//  ios-gif-search
//
//  Created by 동준 on 4/3/24.
//

import Foundation

protocol GiphyOperation {
    func searchGif(
        type: GifType,
        query: String,
        offset: Int,
        completion: @escaping ((Result<GifBundle, NetworkError>) -> Void)
    )
    
    func fetchTrendingGif(
        type: GifType,
        offset: Int,
        completion: @escaping ((Result<GifBundle, NetworkError>) -> Void)
    )
}
