//
//  PostModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var user: User?
    var video: Video?
    var articleId: String?
    var title: String?
    var description: String?
    var level: Int?
    var angle: Int?
    var viewCount: Int?
    var favoriteCount: Int?
    var registerDateTime: String?
    var favorite: Bool?
    
    init(user: User?, video: Video?, articleId: String?, title: String?, description: String?, level: Int?, angle: Int?, viewCount: Int?, favoriteCount: Int?, registerDateTime: String?, favorite: Bool?) {
        self.user = user
        self.video = video
        
        self.articleId = articleId
        self.title = title
        self.description = description
        self.level = level
        self.angle = angle
        self.viewCount = viewCount
        self.favoriteCount = favoriteCount
        self.registerDateTime = registerDateTime
        self.favorite = favorite
    }

    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case video = "video"
        case articleId = "articleId"
        case title = "title"
        case description = "description"
        case level = "level"
        case angle = "angle"
        case viewCount = "viewCount"
        case favoriteCount = "favoriteCount"
        case registerDateTime = "registerDateTime"
        case favorite = "favorite"
    }
}


struct ArticleResponse: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var username: String?
    var video: Video?
    var articleId: String?
    var title: String?
    var description: String?
    var level: Int?
    var angle: Int?
    var viewCount: Int?
    var favoriteCount: Int?
    var registerDateTime: String?
    
    init(username: String?, video: Video?, articleId: String?, title: String?, description: String?, level: Int?, angle: Int?, viewCount: Int?, favoriteCount: Int?, registerDateTime: String?) {
        
        self.username = username
        self.video = video
        
        self.articleId = articleId
        self.title = title
        self.description = description
        self.level = level
        self.angle = angle
        self.viewCount = viewCount
        self.favoriteCount = favoriteCount
        self.registerDateTime = registerDateTime
    }

    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case video = "video"
        case articleId = "articleId"
        case title = "title"
        case description = "description"
        case level = "level"
        case angle = "angle"
        case viewCount = "viewCount"
        case favoriteCount = "favoriteCount"
        case registerDateTime = "registerDateTime"
    }
}


struct ArticleListResponse: Codable{
    var id: UUID = UUID()
    var articles: [ArticleResponse]
    var nextPageToken: String
}
