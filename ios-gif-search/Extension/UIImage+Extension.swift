//
//  UIImage.swift
//  ios-gif-search
//
//  Created by 동준 on 3/31/24.
//

import UIKit
import ImageIO

extension UIImage {
    static func animatedGIF(with url: URL, completion: @escaping (UIImage?) -> Void) {
            let session = URLSession(configuration: .default)
            
            let downloadTask = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil,
                      let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                let animatedImage = UIImage.animatedImage(with: source)
                DispatchQueue.main.async {
                    completion(animatedImage)
                }
            }
            
            downloadTask.resume()
        }
        
        // Helper method to create an animated UIImage from CGImageSource
        private static func animatedImage(with source: CGImageSource) -> UIImage? {
            let count = CGImageSourceGetCount(source)
            var images = [UIImage]()
            var duration = 0.0
            
            for i in 0..<count {
                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: image))
                    duration += 0.1 // Assuming each frame has a 0.1 second delay
                }
            }
            
            return UIImage.animatedImage(with: images, duration: duration)
        }
    
    static func frameDuration(at index: Int, in source: CGImageSource) -> TimeInterval {
        let defaultFrameDuration = 0.1
        
        guard let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? Dictionary<String, Any>,
              let gifProperties = cfFrameProperties[kCGImagePropertyGIFDictionary as String] as? Dictionary<String, Any> else {
            return defaultFrameDuration
        }
        
        var frameDuration: TimeInterval = defaultFrameDuration
        
        if let unclampedDelayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? TimeInterval,
           unclampedDelayTime > 0 {
            frameDuration = unclampedDelayTime
        } else if let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval,
                  delayTime > 0 {
            frameDuration = delayTime
        }
        
        return frameDuration
    }
}
