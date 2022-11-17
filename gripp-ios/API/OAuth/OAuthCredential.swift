//
//  OAuthCredential.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation
import Alamofire

struct OAuthCredential : AuthenticationCredential{
    let accessToken : String
    let refreshToken : String
    var requiresRefresh = false
}
