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
    
    @Published var shouldAlert = false
    @Published var alertMessage = ""
    @Published var userNameAvailable = true
    
    func checkUser(username: String){
        self.userNameAvailable = false
        AuthApiService.lookup(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("LVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                if(received.username == nil){
                    self.userNameAvailable = true
                }
                else{
                    self.userNameAvailable = false
                }
            }.store(in: &subscription)
    }
    
    func register(username: String, password: String){
//        print("LVM register()")
        AuthApiService.register(username: username, password: password)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("LVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                if(received.username == nil){
                    self.alertMessage = "가입에 실패했습니다."
                    self.shouldAlert = true
//                    print("LVM registration fail")
                }
                else{
                    self.loggedInUser = received
                    self.registrationSuccess.send()
                }
            }.store(in: &subscription)
    }
    
    func login(username: String, password: String){
//        print("LVM login()")
        AuthApiService.login(username: username, password: password)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("LVM completion \(completion)")
            }
            receiveValue: { (received: Token) in
                if(received.accessToken == nil || received.refreshToken == nil){
                    self.alertMessage = "로그인에 실패했습니다."
                    self.shouldAlert = true
//                    print("LVM login fail")
                }
                else{
                    self.loginToken = received
                    self.loginSuccess.send()
                }
            }.store(in: &subscription)
    }
    
    func validityId(_ id: String) -> Bool{
        let result = id.range(of: #"\w{2,15}$"#,
                         options: .regularExpression) != nil
        return result
    }
    
    func validityPw(_ pw: String) -> Bool{
        let regexResult = pw.range(of: #"[\w\"!#$%&'()*+,-./:;<=>?@\[\]^_`{|}~\\]{8,64}"#,
                         options: .regularExpression) != nil
        let charResult = pw.range(of: #"[a-z,A-Z]+"#,
                         options: .regularExpression) != nil
        let intResult = pw.range(of: #"[0-9]+"#,
                                options: .regularExpression) != nil
        return regexResult && charResult && intResult
    }
}
