//
//  PostGridItem.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/31.
//

import Foundation

struct PostGridItem: Codable, Hashable, Identifiable{
    var id: UUID = UUID()
    var thumbnailPath : String
    var processing : Bool
    var conquered : Bool
}
