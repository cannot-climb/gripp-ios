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
    
    func postArticle(videoId: String, title: String, description: String, difficulty: Int, angle: Int){
        UserApiService.postArticle(videoId: videoId, title: title, description: description, level: difficulty, angle: angle)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
            } receiveValue: { (received: Article) in
                if(received.articleId == nil){
                }
                else{
                    print("upload final success!")
                }
            }.store(in: &subscription)
    }
    
    func uploadVideo(videoUrl: URL, filename: String, title: String, description:String, difficulty: Int, angle: Int) {
        
        AuthApiService.tokenRefresh(username: getUserName()!)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                //                print("UVM completion \(completion)")
            } receiveValue: { (received: Token) in
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
            //        .uploadProgress{ progress in
            //            print(progress)
            //        }
                    .response { response in
                        switch response.result{
                        case .success:
                            print("success!!")
                            do{
                                let data = try JSONDecoder().decode(Video.self, from: response.data!)
                                self.postArticle(videoId: data.videoId!, title: title, description: description, difficulty: difficulty, angle: angle)
                            }
                            catch{
                                
                            }
                        case .failure:
                            print("fail!!")
                            print(response)
                        }
                    }
                }
            }.store(in: &subscription)
    }
}
