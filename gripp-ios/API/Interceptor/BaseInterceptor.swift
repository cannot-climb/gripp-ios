//
//  BaseInterceptor.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
}
