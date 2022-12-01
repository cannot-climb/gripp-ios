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
    
    var fetchUserSuccess = PassthroughSubject<(), Never>()
    var loadVideoListSuccess = PassthroughSubject<(), Never>()
//
//    @Published var userInfo: User? = nil
    
    @Published var username = ""
    @Published var userArticleCount = ""
    @Published var userArticleCertifiedCount = ""
    @Published var userSuccessRate = ""
    @Published var userTier = ""
    @Published var userScore = ""
    @Published var userRank = ""
    @Published var userPercentile = ""
    
    @Published var noMoreData = false
    @Published var articles: [ArticleResponse] = []
    @Published var nextPageToken = ""
    var currPageToken = ""
    
    func logout(){
        UserDefaultsManager.shared.clearAll()
    }
    
    func refresh(){
        self.nextPageToken = ""
        self.currPageToken = ""
        self.noMoreData = false
        loadUserInfo()
        refreshVideoList()
    }
    
    func loadUserInfo(){
//        print("GVM loadUserInfo()")
        
        UserApiService.fetchUserInfo(username: self.username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("GVM completion \(completion)")
            }
            receiveValue: { (received: User) in
//                self.userInfo = received
//                self.fetchUserSuccess.send()
                
                self.userArticleCount = received.articleCount == nil ? "..." : String(received.articleCount!)
                self.userArticleCertifiedCount = received.articleCertifiedCount == nil ? " ..." : String(received.articleCertifiedCount!)
                self.userSuccessRate = String(format: "%.0f", Double(received.articleCertifiedCount ?? 0) / Double((received.articleCount == 0 ? 1 : received.articleCount) ?? 100)*100)
                self.userPercentile = String(100 - (received.percentile ?? 0))
                self.userScore = received.score == nil ? "..." : String(received.score!)
                self.userTier = received.tier == nil ? "..." : String(received.tier!)
                self.userRank = received.rank == nil ? "..." : String(received.rank!)
                
            }.store(in: &subscription)
    }
    
    func loadVideoList(){
//        print("HVM loadVideoList()")
        
        if((currPageToken != "" && nextPageToken == "") || (currPageToken == nextPageToken)){
            noMoreData = true
            print("no more videos")
        }
        else if(nextPageToken != ""){
            print("normal")
            UserApiService.loadArticles(username: self.username, pageToken: self.nextPageToken)
                .sink{
                    (completion: Subscribers.Completion<AFError>) in
    //                print("HVM completion \(completion)")
                }
                receiveValue: { (received: ArticleListResponse) in
                    self.loadVideoListSuccess.send()
                    self.currPageToken = self.nextPageToken
                    self.nextPageToken = received.nextPageToken
                    self.noMoreData = true
                    if(self.nextPageToken != self.currPageToken){
                        self.articles.append(contentsOf: received.articles)
                    }
                }.store(in: &subscription)
        }
    }
    
    func refreshVideoList(){
//        print("HVM loadVideoList()")
        UserApiService.loadArticles(username: self.username, pageToken: self.nextPageToken)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("HVM completion \(completion)")
            }
            receiveValue: { (received: ArticleListResponse) in
                self.loadVideoListSuccess.send()
                self.currPageToken = self.nextPageToken
                self.nextPageToken = received.nextPageToken
                
                self.articles = received.articles
            
            }.store(in: &subscription)
        
        
    }
}
