//
//  GifNetwork.swift
//  ios-gif-search
//
//  Created by 동준 on 3/6/24.
//

import Foundation

class GifNetwork {
    let apiKey: String? = Secrets.apiKey
    var type: ApiType
    
    init(type: ApiType) {
        self.type = type
    }

    func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {
        guard let url = searchUrlBuilder(searchTerm: searchTerm, type: "gifs") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
        }.resume()
    }
    
    func searchUrlBuilder(searchTerm: String, type: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/v1/\(type)/search"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "limit", value: "15")
        ]
        return components.url!
    }
    
    func trendingUrlBuilder() -> URL {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/v1/gifs/trending"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "limit", value: "15")
        ]
        return components.url!
    }
}
