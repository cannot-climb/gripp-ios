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
    var articleId: Int?
    var title: String?
    var description: String?
    var level: Int?
    var angle: Int?
    var viewCount: Int?
    var favoriteCount: Int?
    var registerDateTime: String?
    var favorite: Bool?
    
    init(user: String?, video: String?, articleId: Int?, title: String?, description: String?, level: Int?, angle: Int?, viewCount: Int?, favoriteCount: Int?, registerDateTime: String?, favorite: Bool?) {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(User.self, from: user!.data(using: .utf8)!)
            self.user = data
        } catch {
            print("error:\(error)")
        }
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Video.self, from: video!.data(using: .utf8)!)
            self.video = data
        } catch {
            print("error:\(error)")
        }
        
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


struct ArticleListResponse: Codable{
    var id: UUID = UUID()
    var articles: [Article]
    var nextPageToken: String
}
