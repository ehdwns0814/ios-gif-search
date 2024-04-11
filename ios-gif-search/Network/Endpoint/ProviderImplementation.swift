//
//  ProviderImplementation.swift
//  ios-gif-search
//
//  Created by 동준 on 4/3/24.
//

import Foundation

final class ProviderImplementation: APIProvider {
    let session: URLSession = .shared

    func request<T: APIRequestable>(_ request: T, completion: @escaping (Result<T.APIResponse, NetworkError>) -> Void) {
        
        guard let urlRequest = request.getUrlRequest else { return }
        
        session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidStatus))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            guard let decoded = try?
                    decoder.decode(T.APIResponse.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            return completion(.success(decoded))
        }.resume()
    }
}
