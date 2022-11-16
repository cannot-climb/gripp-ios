//
//  VideoModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation

struct Video: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var videoId: String?
    var streamingUrl: String?
    var streamingLength: Int?
    var streamingAspectRatio: Float?
    var thumbnailUrl: String?
    var status: String?
    
    init(videoId: String?, streamingUrl: String?, streamingLength: Int?, streamingAspectRatio: Float?, thumbnailUrl: String?, status: String?) {
        self.videoId = videoId
        self.streamingUrl = streamingUrl
        self.streamingLength = streamingLength
        self.streamingAspectRatio = streamingAspectRatio
        self.thumbnailUrl = thumbnailUrl
        self.status = status
    }
    
    enum CodingKeys: String, CodingKey {
        case videoId = "videoId"
        case streamingUrl = "streamingUrl"
        case streamingLength = "streamingLength"
        case streamingAspectRatio = "streamingAspectRatio"
        case thumbnailUrl = "thumbnailUrl"
        case status = "status"
    }
}
