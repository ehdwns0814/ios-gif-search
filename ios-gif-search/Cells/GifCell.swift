//
//  GifCell.swift
//  ios-gif-search
//
//  Created by 동준 on 3/2/24.
//

import UIKit

final class GifCell: UICollectionViewCell {
    
    static let identifier = "GifCell"
    
    private var imageView: UIImageView!
    
    func configure(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print(error?.localizedDescription)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print(error?.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    UIImage.animatedGIF(with: url) { image in
                        self.imageView.image = image
                    }
                }
            }
        }.resume()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
