//
//  AuthRouter.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/15.
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible{
    func asURLRequest ( ) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        print(url)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
    
    case postArticle(videoId: String, title: String, description: String, level: Int, angle: Int)
    case fetchArticleInfo(articleId: Int)
    case deleteArticle(articleId: Int)
    case likeArticle(articleId: Int, favorite: Bool)
    case searchArticle(filter: Dictionary<String, Dictionary<String, String>>, pageToken: String)
    case fetchUserInfo(username: String)
    case fetchLeaderBoard(username: String)
//    case uploadVideo
//    case editArticle
    
    var baseURL: URL{
        return URL(string: Config.baseURL)!
    }
    var endPoint:String{
        switch self{
        case .postArticle:
            return "articles"
        case let .fetchArticleInfo(articleId):
            return "articles/\(articleId)"
        case let .deleteArticle(articleId):
            return "articles/\(articleId)"
        case let .likeArticle(articleId, _):
            return "articles/\(articleId)/reaction"
        case .searchArticle:
            return "articles/search"
        case let .fetchUserInfo(username):
            return "users/\(username)"
        case let .fetchLeaderBoard(username):
            return "users/\(username)/leaderboard"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postArticle:
            return .post
        case .fetchArticleInfo:
            return .get
        case .deleteArticle:
            return .delete
        case .likeArticle:
            return .patch
        case .searchArticle:
            return .post
        case .fetchUserInfo:
            return .get
        case .fetchLeaderBoard:
            return .get
        }
    }
    
    var paramters: Parameters{
        switch self{
        case let .postArticle(videoId, title, description, level, angle):
            var params = Parameters()
            params["videoId"] = videoId
            params["title"] = title
            params["description"] = description
            params["level"] = level
            params["angle"] = angle
            return params
        case .fetchArticleInfo:
            return Parameters()
        case .deleteArticle:
            return Parameters()
        case let .likeArticle(_, favorite):
            var params = Parameters()
            params["favorite"] = favorite
            return params
        case let .searchArticle(filter, pageToken):
            var params = Parameters()
            params["filter"] = filter
            params["pageToken"] = pageToken
            return params
        case .fetchUserInfo:
            return Parameters()
        case .fetchLeaderBoard:
            return Parameters()
        }
        
        
    }
    
}
