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
        
        UserApiService.loadArticles(minLevel:0,maxLevel:19, pageToken: "")
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("HVM completion \(completion)")
            }
            receiveValue: { (received: ArticleListResponse) in
                print("Next Page Token : " + received.nextPageToken)
                self.loadVideoListSuccess.send()
                self.nextPageToken = received.nextPageToken
                self.articles = received.articles
            }.store(in: &subscription)
    }
    
    func refreshVideoList(){
        
    }
    
    func loadMoreVideoList(more: String){
        
    }
}
