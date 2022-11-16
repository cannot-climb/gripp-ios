//
//  LoginViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/16.
//

import Foundation
import Alamofire
import Combine

class LoginViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    var registrationSuccess = PassthroughSubject<(), Never>()
    var loginSuccess = PassthroughSubject<(), Never>()
    
    @Published var loggedInUser: User? = nil
    @Published var loginToken: Token? = nil
    
    func register(username: String, password: String){
        print("LVM register()")
        AuthApiService.register(username: username, password: password)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("LVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                if(received.username == nil){
                    print("LVM registration fail")
                }
                else{
                    self.loggedInUser = received
                    self.registrationSuccess.send()
                }
            }.store(in: &subscription)
    }
    
    func login(username: String, password: String){
        print("LVM login()")
        AuthApiService.login(username: username, password: password)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("LVM completion \(completion)")
            }
            receiveValue: { (received: Token) in
                if(received.accessToken == nil || received.refreshToken == nil){
                    print("LVM login fail")
                }
                else{
                    self.loginToken = received
                    self.loginSuccess.send()
                }
            }.store(in: &subscription)
    }
}
