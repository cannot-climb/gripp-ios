//
//  UserModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var username: String?
    var tier: Int?
    var score: Float?
    var rank: Int?
    var percentile: Int?
    var articleCount: Int?
    var articleCertifiedCount: Int?
    var registerDateTime: String?
    
    init(username: String?, tier: Int?, score: Float?, rank: Int?, percentile: Int?, articleCount: Int?, articleCertifiedCount: Int?, registerDateTime: String?) {
        self.username = username
        self.tier = tier
        self.score = score
        self.rank = rank
        self.percentile = percentile
        self.articleCount = articleCount
        self.articleCertifiedCount = articleCertifiedCount
        self.registerDateTime = registerDateTime
    }
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case tier = "tier"
        case score = "score"
        case rank = "rank"
        case percentile = "percentile"
        case articleCount = "articleCount"
        case articleCertifiedCount = "articleCertifiedCount"
        case registerDateTime = "registerDateTime"
    }
}
