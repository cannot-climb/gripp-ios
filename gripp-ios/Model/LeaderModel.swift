//
//  LeaderModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/18.
//

import Foundation

struct LeaderResponse: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var topBoard: [User]?
    var defaultBoard: [User]?
    
    init(topBoard: [User]?, defaultBoard: [User]?) {
        self.topBoard = topBoard
        self.defaultBoard = defaultBoard
    }

    
    enum CodingKeys: String, CodingKey {
        case topBoard = "topBoard"
        case defaultBoard = "defaultBoard"
    }
}
