//
//  AuthApiService.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire
import Combine

enum AuthApiService{
    static func register(username: String, password: String) -> AnyPublisher<User, AFError>{
//        print("AAS register()")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(username: username, password: password))
            .publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func lookup(username: String) -> AnyPublisher<User, AFError>{
//        print("AAS lookup()")
        
        return ApiClient.shared.session
            .request(AuthRouter.lookup(username: username))
            .publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func login(username: String, password: String) -> AnyPublisher<Token, AFError>{
//        print("AAS login()")
        
        return ApiClient.shared.session
            .request(AuthRouter.login(username: username, password: password))
            .publishDecodable(type: Token.self)
            .value()
            .map{received in
                UserDefaultsManager.shared.setTokens(username: username, accessToken: received.accessToken ?? "", refreshToken: received.refreshToken ?? "")
                return received
            }
            .eraseToAnyPublisher()
    }
    
    static func tokenRefresh(username: String) -> AnyPublisher<Token, AFError>{
//        print("AAS tokenRefresh()")
        
        return ApiClient.shared.session
            .request(AuthRouter.tokenRefresh(username: username))
            .publishDecodable(type: Token.self)
            .value()
            .map{received in
                UserDefaultsManager.shared.setTokens(username: username, accessToken: received.accessToken ?? "", refreshToken: received.refreshToken ?? "")
                return received
            }
            .eraseToAnyPublisher()
    }
    
    static func tokenTrash(username: String) -> AnyPublisher<User, AFError>{
//        print("AAS tokenTrash()")
        
        return ApiClient.shared.session
            .request(AuthRouter.tokenTrash(username: username))
            .publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
}
