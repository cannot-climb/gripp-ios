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
        print("AuthApiService register()")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(username: username, password: password))
            .publishDecodable(type: User.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func login(username: String, password: String) -> AnyPublisher<Token, AFError>{
        print("AuthApiService login()")
        
        return ApiClient.shared.session
            .request(AuthRouter.login(username: username, password: password))
            .publishDecodable(type: Token.self)
            .value()
            .eraseToAnyPublisher()
    }
}
