//
//  MediaMetadata.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
import RealmSwift

class MediaMetadata: Object, Codable {
    @Persisted var url: String?
    @Persisted var format: String?
    @Persisted var height: Int?
    @Persisted var width: Int?
}
