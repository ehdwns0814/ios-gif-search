//
//  GifSearchResponseDTO+Extension.swift
//  ios-gif-search
//
//  Created by 동준 on 4/5/24.
//

import Foundation

extension GifSearchResponse {
    func toGifBunddle() -> GifBundle {
        let offset = pagination.offset
        let target = min(pagination.totalCount, 4999)
        let isNextPage = offset < target
        return GifBundle(gifs: gifs.compactMap{ $0.toSearchedGif() }
        )
    }
}

extension SearchedGifResponse {
    func toSearchedGif() -> Gif? {
        guard let type = GifType(rawValue: self.type) else { return nil }
        return Gif(
            type: type,
            identifier: identifier,
            user: user?.toSearchedUser(),
            mediaResource: images.toMediaResource(),
            title: title
        )
    }
}

extension UserResponse {
    func toSearchedUser() -> User {
        return User(
            name: username,
            profileURL: profileURL,
            displayName: displayName
        )
    }
}

extension ImageResponse {
    func toMediaResource() -> MediaResource {
        return MediaResource(imageURL: fixedWidth.url)
    }
}

