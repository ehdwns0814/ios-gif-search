//
//  GifTrendingRequest.swift
//  ios-gif-search
//
//  Created by 동준 on 4/4/24.
//

import Foundation

struct GifTrendingResponse: Decodable {
    let gifs: [TrendingGifResponse]
    let pagination: TrendingPagination
    
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
        case pagination
    }
}

struct TrendingGifResponse: Decodable {
    let type: String
    let identifier: String
    let username: String
    let title: String
    let images: TrendingImageResponse
    let user: TrendingUserResponse?
    let source: String?
    
    
    enum CodingKeys: String, CodingKey {
        case type
        case identifier = "id"
        case username
        case title
        case images
        case user
        case source = "source_tld"
    }
}

struct TrendingPagination: Decodable {
    let offset: Int
    let totalCount: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case offset
        case totalCount = "total_count"
        case count
    }
}

struct TrendingImageResponse: Decodable {
    let fixedWidth: StaticWidthGifResponse
    
    enum CodingKeys: String, CodingKey {
        case fixedWidth = "fixed_width"
    }
}

struct TrendingUserResponse: Decodable {
    let avatarURL: String
    let bannerURL: String
    let profileURL: String
    let username: String
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
    }
}

struct StaticWidthGifResponse: Decodable {
    let height: String
    let width: String
    let size: String
    let url: String
    let mp4Size: String
    let mp4: String
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case size
        case url
        case mp4Size = "mp4_size"
        case mp4
    }
}
