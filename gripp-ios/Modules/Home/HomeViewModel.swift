//
//  HomeViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/17.
//

import Foundation
import Alamofire
import Combine


class HomeViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    var fetchUserSuccess = PassthroughSubject<(), Never>()
    var loadVideoListSuccess = PassthroughSubject<(), Never>()
    
    @Published var titleUserName = ""
    @Published var titleUserInfoString = ""
    @Published var selectedDifficulties = [true, true, true, true]
    
    @Published var articles: [ArticleResponse] = []
    @Published var nextPageToken = ""
    @Published var noMoreData = false
    
    var currPageToken = ""
    
    @Published var minLevel = 0
    @Published var maxLevel = 19
    
    func refresh(){
        self.articles = []
        self.nextPageToken = ""
        self.currPageToken = ""
        self.noMoreData = false
        loadTitleInfo()
        loadVideoList()
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
                self.titleUserInfoString = "V\(String(received.tier ?? -1)), 상위 \(String(100 - (received.percentile ?? -1)))%"
            }.store(in: &subscription)
    }
    
    func loadVideoList(){
//        print("HVM loadVideoList()")
        
        print(currPageToken, nextPageToken)
        if(currPageToken == "" && nextPageToken == ""){
            print("brand new")
            UserApiService.loadArticles(minLevel:self.minLevel,maxLevel:self.maxLevel, pageToken: self.nextPageToken)
                .sink{
                    (completion: Subscribers.Completion<AFError>) in
    //                print("HVM completion \(completion)")
                }
                receiveValue: { (received: ArticleListResponse) in
                    self.loadVideoListSuccess.send()
                    self.currPageToken = self.nextPageToken
                    self.nextPageToken = received.nextPageToken
                    if(self.nextPageToken != self.currPageToken){
                        self.articles.append(contentsOf: received.articles)
                    }
                }.store(in: &subscription)
        }
        else if((currPageToken != "" && nextPageToken == "") || (currPageToken == nextPageToken)){
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
                    self.nextPageToken = received.nextPageToken
                    if(self.nextPageToken != self.currPageToken){
                        self.articles.append(contentsOf: received.articles)
                    }
                }.store(in: &subscription)
        }
        
        
    }
}
