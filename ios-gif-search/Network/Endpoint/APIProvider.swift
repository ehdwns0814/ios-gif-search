//
//  APIProvider.swift
//  ios-gif-search
//
//  Created by 동준 on 4/3/24.
//

import Foundation

protocol APIProvider {
    func request<T: APIRequestable>(_ requset: T, completion: @escaping (Result<T.APIResponse, NetworkError>) -> Void)
}
