//
//  GifCell.swift
//  ios-gif-search
//
//  Created by 동준 on 3/2/24.
//

import UIKit

class GifCell: UICollectionViewCell {
    
    static let identifier = "GifCell"
    
    lazy var gifView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        return view
    }()
    
    func configure(_ image: UIImage) {
        gifView.image  = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
