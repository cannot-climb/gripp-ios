//
//  UploadViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/29.
//

import Foundation
import Alamofire
import Combine


class UploadViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    var angle = ""
    var difficulty = ""
    var title = ""
    var description = ""
    
    //    var topBoard: [User] = []
    //    var defaultBoard: [User] = []
    //
    //
    //    @Published var podiums: [Podium] = Array(repeating: Podium(username: "", level: "", rank: ""), count: 3)
    //    @Published var combinedBoard: [User] = []
    //
    

    
    func uploadVideo(videoUrl: URL, filename: String) {
        AuthApiService.tokenRefresh(username: getUserName()!)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("UVM completion \(completion)")
            }
            receiveValue: { (received: Token) in
                if(received.refreshToken == nil){
//                    print("UVM login fail")
                }
                else{
                    AF.upload(multipartFormData: { (multipartFormData) in
                        multipartFormData.append(videoUrl, withName: "file", fileName: filename, mimeType: "video/mp4")
                    }, to: Config.baseURL+"videos", headers: [
                        .contentType("multipart/form-data"),
                        .accept("application/json"),
                        .authorization(bearerToken: UserDefaultsManager.shared.getTokens().accessToken!)
                    ])
                    .response { (response) in
                        switch response.result{
                        case .success:
                            print("success!!")
                            let json = String(data: response.data!, encoding: String.Encoding.utf8)
                            print(json)
                        case .failure:
                            print("fail!!")
                            print(response)
                    }
                }
            }
        }.store(in: &subscription)
    }
}
