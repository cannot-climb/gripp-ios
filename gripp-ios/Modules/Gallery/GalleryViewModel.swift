//
//  GalleryViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation
import Alamofire
import Combine


class GalleryViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
//    var fetchUserSuccess = PassthroughSubject<(), Never>()
//
//    @Published var userInfo: User? = nil
    
    @Published var userArticleCount = ""
    @Published var userArticleCertifiedCount = ""
    @Published var userSuccessRate = ""
    @Published var userTier = ""
    @Published var userScore = ""
    @Published var userRank = ""
    @Published var userPercentile = ""
    
    func logout(){
        UserDefaultsManager.shared.clearAll()
    }
    
    func loadUserInfo(){
        print("GVM loadUserInfo()")
        guard let username = getUserName() else{
            print("GVM failed - username empty")
            return
        }
        UserApiService.fetchUserInfo(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("GVM completion \(completion)")
            }
            receiveValue: { (received: User) in
//                self.userInfo = received
//                self.fetchUserSuccess.send()
                
                self.userArticleCount = String(received.articleCount ?? -2)
                self.userArticleCertifiedCount = String(received.articleCertifiedCount ?? -2)
                self.userSuccessRate = String(format: "%.0f", ceil(Double(received.articleCertifiedCount ?? 0) / Double(received.articleCount ?? 100)))
                self.userPercentile = String(received.percentile ?? -1)
                self.userScore = String(received.score ?? -1)
                self.userTier = String(received.tier ?? -1)
                self.userRank = String(received.rank ?? -1)
                
            }.store(in: &subscription)
    }
}
