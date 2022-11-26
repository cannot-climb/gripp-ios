//
//  LeaderboardViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/18.
//

import Foundation
import Alamofire
import Combine


class LeaderboardViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    var topBoard: [User] = []
    var defaultBoard: [User] = []
    
    
    @Published var podiums: [Podium] = Array(repeating: Podium(username: "", level: "", rank: ""), count: 3)
    @Published var combinedBoard: [User] = []
    
    func loadLeaderboard(){
        UserApiService.fetchLeaderBoard(username: getUserName() ?? "")
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("LVM completion \(completion)")
            }
            receiveValue: { (received: LeaderResponse) in
                if(received.defaultBoard == nil || received.topBoard == nil){
                    print("LVM fail")
                }
                else{
                    self.topBoard = received.topBoard!
                    self.defaultBoard = received.defaultBoard!
                    
                    switch self.topBoard.count {
                    case 0:
                        self.podiums = Array(repeating: Podium(username: "", level: "", rank: ""), count: 3)
                    case 1:
                        let t0 = self.topBoard[0]
                        self.podiums = [Podium(username: t0.username!, level: "V\(t0.tier!)", rank: "1위")] + Array(repeating: Podium(username: "", level: "", rank: ""), count: 2)
                    case 2:
                        let t0 = self.topBoard[0]
                        let t1 = self.topBoard[1]
                        self.podiums = [Podium(username: t0.username!, level: "V\(t0.tier!)", rank: "1위"), Podium(username: t1.username!, level: "V\(t1.tier!)", rank: "2위"), Podium(username: "", level: "", rank: "")]
                    case 3:
                        let t0 = self.topBoard[0]
                        let t1 = self.topBoard[1]
                        let t2 = self.topBoard[2]
                        self.podiums = [Podium(username: t0.username!, level: "V\(t0.tier!)", rank: "1위"), Podium(username: t1.username!, level: "V\(t1.tier!)", rank: "2위"), Podium(username: t2.username!, level: "V\(t2.tier!)", rank: "3위") ]
                    default:
                        let t0 = self.topBoard[0]
                        let t1 = self.topBoard[1]
                        let t2 = self.topBoard[2]
                        self.podiums = [Podium(username: t0.username!, level: "V\(t0.tier!)", rank: "1위"), Podium(username: t1.username!, level: "V\(t1.tier!)", rank: "2위"), Podium(username: t2.username!, level: "V\(t2.tier!)", rank: "3위") ]
                        self.combinedBoard = self.topBoard[3..<self.topBoard.count] + self.defaultBoard
                    }
                }
            }.store(in: &subscription)
    }
}

struct Podium :Equatable{
    var username: String
    var level: String
    var rank: String
}
