//
//  APIRequestable.swift
//  ios-gif-search
//
//  Created by 동준 on 4/2/24.
//

import Foundation

protocol APIRequestable {
    associatedtype APIResponse: Decodable
    
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
    var parameters: [String: String] { get }
    var headers: [String: String]? { get }
}

extension APIRequestable {
    var url: URL? {
        
        guard let base = baseURL else { return nil}
        
        let fullPath = "\(base)\(path)"
                
        var urlComponents = URLComponents(string: fullPath)
        
        let urlQueryItems = self.parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        urlComponents?.queryItems = urlQueryItems
        
        return urlComponents?.url
    }
    
    var getUrlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        return urlRequest
    }
}
