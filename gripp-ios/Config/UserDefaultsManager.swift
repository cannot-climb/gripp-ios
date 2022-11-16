//
//  UserToken.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation

class UserDefaultsManager{
    enum Key: String, CaseIterable{
        case refreshToken, accessToken
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    func clearAll(){
        print("UDM clearAll()")
        Key.allCases.forEach{UserDefaults.standard.removeObject(forKey: $0.rawValue)}
    }
    
    func setTokens(accessToken: String, refreshToken: String){
        print("UDM setTokens()")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getTokens()->Token{
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return Token(accessToken: accessToken, refreshToken: refreshToken)
    }
}
