//
//  MediaData.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
import RealmSwift

class MediaData: Object, Codable {
    @Persisted var type: String?
    @Persisted var subtype: String?
    @Persisted var caption: String?
    @Persisted var copyright: String?
    @Persisted var approved_for_syndication: Int?
    @Persisted var mediaMetadata = List<MediaMetadata>()

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approved_for_syndication
        case mediaMetadata = "media-metadata"
    }
}
