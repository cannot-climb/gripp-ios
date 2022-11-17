//
//  UserApiService.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/16.
//

import Foundation
import Alamofire
import Combine

enum UserApiService{

    static func postArticle(videoId: String, title: String, description: String, level: Int, angle: Int) -> AnyPublisher<Article, AFError>{
        print("UAS postArticle()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.postArticle(videoId: videoId, title: title, description: description, level: level, angle: angle), interceptor: authInterceptor)
            .publishDecodable(type: Article.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func fetchArticleInfo(articleId: String) -> AnyPublisher<Article, AFError>{
        print("UAS fetchArticleInfo()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.fetchArticleInfo(articleId: articleId), interceptor: authInterceptor)
            .publishDecodable(type: Article.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func deleteArticle(articleId: String) -> AnyPublisher<Article, AFError>{
        print("UAS deleteArticle()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.deleteArticle(articleId: articleId), interceptor: authInterceptor)
            .publishDecodable(type: Article.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func likeArticle(articleId: String, favorite: Bool) -> AnyPublisher<Article, AFError>{
        print("UAS likeArticle()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.likeArticle(articleId: articleId, favorite: favorite), interceptor: authInterceptor)
            .publishDecodable(type: Article.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func loadArticles(minLevel: Int, maxLevel: Int, pageToken: String) -> AnyPublisher<ArticleListResponse, AFError>{
        print("UAS loadArticles()")
        
        let dict = [["type":"LEVEL", "minLevel":0, "maxLevel":19]]
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        let response = ApiClient.shared.session
            .request(UserRouter.searchArticle(filters: dict, pageToken: pageToken), interceptor: authInterceptor)
            .publishDecodable(type: ArticleListResponse.self)
            .value()
            .eraseToAnyPublisher()
        debugPrint(response)
        return response
    }
    static func fetchUserInfo(username: String) -> AnyPublisher<User, AFError>{
        print("UAS fetchUserInfo()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.fetchUserInfo(username: username), interceptor: authInterceptor)
            .publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func fetchLeaderBoard(username: String) -> AnyPublisher<LeaderboardListResponse, AFError>{
        print("UAS fetchLeaderBoard()")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken ?? "", refreshToken: storedTokenData.refreshToken ?? "")
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return ApiClient.shared.session
            .request(UserRouter.fetchLeaderBoard(username: username), interceptor: authInterceptor)
            .publishDecodable(type: LeaderboardListResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
