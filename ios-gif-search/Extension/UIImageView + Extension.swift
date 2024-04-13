//
//  UIImageView + Extension.swift
//  ios-gif-search
//
//  Created by 동준 on 4/13/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            
            let cachedKey = NSString(string: url)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                self.image = cachedImage
                return
            }
            
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, result, error) in
                
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
