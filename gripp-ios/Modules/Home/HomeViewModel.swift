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
    
    @Published var titleUserName = ""
    @Published var titleUserInfoString = ""
    @Published var selectedDifficulties = [true, true, true, true]
    
    
    func loadTitleInfo(){
        print("HVM loadUserInfo()")
        guard let username = getUserName() else{
            print("GVM failed - username empty")
            return
        }
        self.titleUserName = username
        UserApiService.fetchUserInfo(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("GVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                self.fetchUserSuccess.send()
                self.titleUserInfoString = "V\(String(received.tier ?? -1)), 상위 \(String(received.percentile ?? -1))%"
            }.store(in: &subscription)
    }
    
    func loadVideoList(){
        
    }
    
    func refreshVideoList(){
        
    }
    
    func loadMoreVideoList(more: String){
        
    }
}
