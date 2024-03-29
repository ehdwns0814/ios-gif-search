//
//  GifNetwork.swift
//  ios-gif-search
//
//  Created by 동준 on 3/6/24.
//

import Foundation
import UIKit

final class GifService {
    let apiKey: String? = Secrets.APIKey
    
    func fetchGifs(searchType: String, searchMenu: String, searchTerm: String?, completion: @escaping (_ response: GifArray?, _ error: Error?) -> Void) {
        var url: URL?
        if let searchTerm = searchTerm {
            url = urlBuilder(type: searchType, menu: searchMenu, searchTerm: searchTerm)
        } else {
            url = urlBuilder(type: searchType, menu: searchMenu)
        }
        
        guard let requestURl = url else {
            completion(nil, Error.urlError)
            return
        }
        print(requestURl)
        
        var request = URLRequest(url: requestURl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object, nil)
                }
            }
        }.resume()
    }
    
    func urlBuilder(type: String, menu: String, searchTerm: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/v1/\(type)/" + (menu)
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "limit", value: "15")
        ]
        
        if let searchTerm = searchTerm {
            queryItems.append(URLQueryItem(name: "q", value: searchTerm))
        }
        components.queryItems = queryItems
        return components.url
    }
    
    func configure(gif: Gif, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: gif.giftURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
