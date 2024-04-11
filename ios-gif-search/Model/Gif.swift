//
//  Gif.swift
//  ios-gif-search
//
//  Created by 동준 on 3/8/24.
//
import Foundation

struct Gif {
    let type: GifType
    let identifier: String
    let user: User?
    let mediaResource: MediaResource
    let title: String
}

struct GifBundle {
    var gifs: [Gif]
}
