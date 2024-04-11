//
//  GifphyService.swift
//  ios-gif-search
//
//  Created by 동준 on 4/4/24.
//

import Foundation

final class GiphyService: GiphyOperation {
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    func searchGif(type: GifType, query: String, offset: Int, completion: @escaping ((Result<GifBundle, NetworkError>) -> Void)) {
        let request = GifSearchRequest(type: type, query: query, offset: offset)
        apiProvider.request(request) { result in
            let response = result.map { $0.toGifBunddle() }
            completion(response)
        }
    }
    
    func fetchTrendingGif(type: GifType, offset: Int, completion: @escaping ((Result<GifBundle, NetworkError>) -> Void)) {
        let request = GifTrendingRequest(type: type, offset: offset)
        apiProvider.request(request) { result in
            let response = result.map { $0.toTrendingGifBunddle() }
            completion(response)
        }
    }
}
