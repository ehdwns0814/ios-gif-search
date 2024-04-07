//
//  GifTrendingResponseDTO+Extension.swift
//  ios-gif-search
//
//  Created by 동준 on 4/6/24.
//

import Foundation

extension GifTrendingResponse {
    func toTrendingGifBunddle() -> GifBundle {
        let offset = pagination.offset
        let target = min(pagination.totalCount, 4999)
        return GifBundle(gifs: gifs.compactMap{ $0.toTrendingGif() }
        )
    }
}

extension TrendingGifResponse {
    func toTrendingGif() -> Gif? {
        guard let type = GifType(rawValue: self.type) else { return nil }
        
        return Gif(
            type: type,
            identifier: identifier,
            user: user?.toTrendingUser(),
            mediaResource: images.toMediaResource(),
            title: title)
    }
}

extension TrendingUserResponse {
    func toTrendingUser() -> User {
        return User(
            name: username,
            profileURL: profileURL,
            displayName: displayName)
    }
}

extension TrendingImageResponse {
    func toMediaResource() -> MediaResource {
        return MediaResource(imageURL: fixedWidth.url)
    }
}

