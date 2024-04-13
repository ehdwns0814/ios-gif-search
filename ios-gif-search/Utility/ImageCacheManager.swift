//
//  CacheManager.swift
//  ios-gif-search
//
//  Created by 동준 on 4/12/24.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() { }
}

