//
//  Secrets.swift
//  ios-gif-search
//
//  Created by 동준 on 3/14/24.
//

import Foundation

enum Secrets {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let string = infoDictionary["API_KEY"] as? String else { fatalError("not exists in plist") }
        return string
    }()
}
