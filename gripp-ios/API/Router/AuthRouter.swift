//
//  AuthRouter.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire

//회원 가입, 로그인, 로그아웃(토큰 파기), 토큰 갱신
enum AuthRouter: URLRequestConvertible{
    func asURLRequest ( ) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        print(url)
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = try JSONEncoding.default.encode(request, with: paramters).httpBody
        return request
    }
    
    case register(username: String, password: String)
    case login(username: String, password: String) //username이 URL의 일부 : https://gripp.dev.njw.kr/auth/accounts/aim5/tokens
    case tokenRefresh(username: String)
    
    var baseURL: URL{
        return URL(string: Config.baseURL)!
    }
    var endPoint:String{
        switch self{
        case .register:
            return "auth/accounts/"
        case let .login(username, _):
            return "auth/accounts/" + username + "/tokens"
        case let .tokenRefresh(username):
            return "auth/accounts/" + username + "/tokens"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .register:
            return .post
        case .login:
            return .post
        case .tokenRefresh:
            return .post
        }
    }
    
    var paramters: Parameters{
        switch self{
        case let .register(username, password):
            var params = Parameters()
            params["username"] = username
            params["password"] = password
            return params
            
        case let .login(username, password):
            var params = Parameters()
            params["username"] = username
            params["password"] = password
            return params
            
        case let .tokenRefresh(username):
            var params = Parameters()
            params["username"] = username
            return params
        }
        
        
    }
    
}
