//
//  Gif.swift
//  ios-gif-search
//
//  Created by 동준 on 3/8/24.
//
import Foundation

struct GifArray: Decodable {
    var gifs: [Gif]
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}

struct Gif: Decodable {
    var gifSources: GifImages
    enum CodingKeys: String, CodingKey {
        case gifSources = "images"
    }
    
    var gifURL: String {
        return gifSources.original.url
    }
}

struct GifImages: Decodable {
    var original: original
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}

struct original: Decodable {
    var url: String
}
