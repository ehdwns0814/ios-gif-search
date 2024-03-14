//
//  GifsViewModel.swift
//  ios-gif-search
//
//  Created by 동준 on 3/10/24.
//

import Foundation

struct GifListViewModel {
    let gifs: [Gif]
}

extension GifListViewModel {
    var numberOfItemsInSection: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return gifs.count
    }
    
    func gifAtIndex(_ index: Int) -> GifViewModel {
       let gif = gifs[index]
        return GifViewModel(gif)
    }
}

struct GifViewModel {
    private let gif: Gif
}

extension GifViewModel {
    init(_ gif: Gif) {
        self.gif = gif
    }
}

