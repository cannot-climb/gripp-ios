//
//  TokenModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/16.
//

import Foundation

struct Token: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var username: String?
    var accessToken: String?
    var refreshToken: String?
    
    init(username: String?, accessToken: String?, refreshToken: String?) {
        self.username = username
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
