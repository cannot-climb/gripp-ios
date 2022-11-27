//
//  OAuthAuthenticator.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation
import Alamofire

class OAuthAuthenticator: Authenticator {
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
//        print("OAA didRequest()")
        switch response.statusCode{
        case 401: return true
        default: return false
        }
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        return true
    }
    
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }
    
    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
//        print("OAA refresh()")
        
        let request = session.request(AuthRouter.tokenRefresh(username:UserDefaultsManager.shared.getTokens().username ?? "-1"))
        
        request.responseDecodable(of: Token.self){ result in
            switch result.result{
            case .success(let value):
                UserDefaultsManager.shared.setTokens(accessToken: value.accessToken ?? "-1", refreshToken: value.refreshToken ?? "-1")
                let newCredential = OAuthCredential(accessToken: value.accessToken ?? "-1", refreshToken: value.refreshToken ?? "-1")
                completion(.success(newCredential))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
