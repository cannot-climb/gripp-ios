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
        var request = URLRequest(url: url)
        request.method = method
        if request.method == .get{
            request.httpBody = try URLEncoding.default.encode(request, with: parameters).httpBody
        }
        else if request.method == .post{
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        else if request.method == .patch{
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        return request
    }
    
    case postArticle(videoId: String, title: String, description: String, level: Int, angle: Int)
    case fetchArticleInfo(articleId: String)
    case deleteArticle(articleId: String)
    case likeArticle(articleId: String, favorite: Bool)
    case searchArticle(filters: [Dictionary<String, Any>], pageToken: String)
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
    
    var parameters: Parameters{
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
            params["favorite"] = NSNumber(value: favorite)
            return params
        case let .searchArticle(filters, pageToken):
            var params = Parameters()
            params["filters"] = filters
            params["order"] = "NEW"
            params["pageToken"] = pageToken
//            print(params)
            return params
        case .fetchUserInfo:
            return Parameters()
        case .fetchLeaderBoard:
            return Parameters()
        }
        
        
    }
    
}

