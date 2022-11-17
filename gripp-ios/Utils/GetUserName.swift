//
//  GetUserName.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation

func getUserName() -> String?{
    return UserDefaultsManager.shared.getTokens().username
}
