//
//  HomeViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation
import Alamofire
import Combine
import SwiftUI


class HomeViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    var fetchUserSuccess = PassthroughSubject<(), Never>()
    var loadVideoListSuccess = PassthroughSubject<(), Never>()
    
    @Published var titleUserName = ""
    @Published var tier = 0
    @Published var titleUserInfoString = ""
    @Published var tierColor: [Color] = [.black.opacity(0),.black.opacity(0),.black.opacity(0)]
    
    
    @Published var articles: [ArticleResponse] = []
    @Published var nextPageToken = ""
    @Published var noMoreData = false
    
    var currPageToken = ""
    
    @Published var minLevel = 0
    @Published var maxLevel = 19
    
    func refresh(){
        self.nextPageToken = ""
        self.currPageToken = ""
        self.noMoreData = false
        loadTitleInfo()
        refreshVideoList()
    }
    
    
    func loadTitleInfo(){
//        print("HVM loadUserInfo()")
        guard let username = getUserName() else{
//            print("HVM failed - username empty")
            return
        }
        self.titleUserName = username
        UserApiService.fetchUserInfo(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("HVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                self.fetchUserSuccess.send()
                self.tier = received.tier ?? 0
                self.titleUserInfoString = "상위 \(String(100 - (received.percentile ?? 0)))%, \(String(received.score ?? 0))점"
                self.tierColor = tierColorProvider(self.tier)
            }.store(in: &subscription)
    }
    func refreshVideoList(){
//        print("HVM loadVideoList()")
        

        UserApiService.loadArticles(minLevel:self.minLevel,maxLevel:self.maxLevel, pageToken: self.nextPageToken)
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
    
    func loadVideoList(){
//        print("HVM loadVideoList()")
        
        if((currPageToken != "" && nextPageToken == "") || (currPageToken == nextPageToken)){
            noMoreData = true
            print("no more videos")
        }
        else if(nextPageToken != ""){
            print("normal")
            UserApiService.loadArticles(minLevel:self.minLevel,maxLevel:self.maxLevel, pageToken: self.nextPageToken)
                .sink{
                    (completion: Subscribers.Completion<AFError>) in
    //                print("HVM completion \(completion)")
                }
                receiveValue: { (received: ArticleListResponse) in
                    self.loadVideoListSuccess.send()
                    self.currPageToken = self.nextPageToken
                    self.noMoreData = true
                    self.nextPageToken = received.nextPageToken
                    if(self.nextPageToken != self.currPageToken){
                        self.articles.append(contentsOf: received.articles)
                    }
                }.store(in: &subscription)
        }
        
        
    }
}
