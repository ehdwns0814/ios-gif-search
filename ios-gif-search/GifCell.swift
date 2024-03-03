//
//  GifCell.swift
//  ios-gif-search
//
//  Created by 동준 on 3/2/24.
//

import UIKit

class GifCell: UICollectionViewCell {
    
    static let identifier = "GifCell"
    lazy var image: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        view.backgroundColor = .systemPink
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
