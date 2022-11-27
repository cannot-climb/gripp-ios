//
//  ApiClient.swift
//  gripp-ios
//
//  https://www.youtube.com/watch?v=NKp3q1JTZu8
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire

final class ApiClient{
    static let shared = ApiClient()
    
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    var session: Session
    
    init(){
//        print("ApiClient init()")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
