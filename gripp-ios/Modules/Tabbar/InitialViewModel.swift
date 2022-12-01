//
//  DefaultViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/12/01.
//

import Foundation
import Alamofire
import Combine

class InitialViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    var subscription2 = Set<AnyCancellable>()
    @Published var initialLoadFinished = false
    
    func initialize(_ homeVM: HomeViewModel, _ viewRouter: ViewRouter){
//        print("HVM loadUserInfo()")
        guard let username = getUserName() else{
//            print("HVM failed - username empty")
            return
        }
        homeVM.titleUserName = username
        UserApiService.fetchUserInfo(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("HVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                homeVM.fetchUserSuccess.send()
                homeVM.titleUserInfoString = "V\(String(received.tier ?? -1)), 상위 \(String(100 - (received.percentile ?? -1)))%"
                UserApiService.loadArticles(minLevel:0,maxLevel:19, pageToken: "")
                    .sink{
                        (completion: Subscribers.Completion<AFError>) in
        //                print("HVM completion \(completion)")
                    }
                    receiveValue: { (received: ArticleListResponse) in
                        homeVM.loadVideoListSuccess.send()
                        homeVM.currPageToken = homeVM.nextPageToken
                        homeVM.nextPageToken = received.nextPageToken
                        homeVM.articles = received.articles
                        viewRouter.apply(page: .home)
                    }.store(in: &self.subscription2)
            }.store(in: &subscription)
        
    }
}
