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
    case lookup(username: String)
    case login(username: String, password: String)
    case tokenRefresh(username: String, refreshToken: String)
    case tokenTrash(username: String, refreshToken: String)
    
    var baseURL: URL{
        return URL(string: Config.baseURL)!
    }
    var endPoint:String{
        switch self{
        case .register:
            return "auth/accounts/"
        case let .lookup(username):
            return "auth/accounts/" + username
        case let .login(username, _):
            return "auth/accounts/" + username + "/tokens"
        case let .tokenRefresh(username, _):
            return "auth/accounts/" + username + "/tokens"
        case let .tokenTrash(username, refreshToken):
            return "auth/accounts/" + username + "/tokens/" + refreshToken
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .register:
            return .post
        case .lookup:
            return .get
        case .login:
            return .post
        case .tokenRefresh:
            return .patch
        case .tokenTrash:
            return .delete
        }
    }
    
    var paramters: Parameters{
        switch self{
        case let .register(username, password):
            var params = Parameters()
            params["username"] = username
            params["password"] = password
            return params
            
        case .lookup(_):
            var params = Parameters()
            return params
            
        case let .login(_, password):
            var params = Parameters()
            params["password"] = password
            return params
            
        case let .tokenRefresh(_, refreshToken):
            var params = Parameters()
            params["refreshToken"] = refreshToken
            return params
            
        case let .tokenTrash(_, _):
            var params = Parameters()
            return params
        }
        
        
    }
    
}
