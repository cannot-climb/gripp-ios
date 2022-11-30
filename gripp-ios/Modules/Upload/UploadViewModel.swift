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
    
    @Published var progressPercentile = 0.0
    @Published var uploadingNow = false
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    func postArticle(videoId: String, title: String, description: String, difficulty: Int, angle: Int){
        UserApiService.postArticle(videoId: videoId, title: title, description: description, level: difficulty, angle: angle)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
            } receiveValue: { (received: Article) in
                if(received.articleId == nil){
                    self.uploadingNow = false
                    self.progressPercentile = 0
                }
                else{
                    print("upload final success!")
                    self.shouldDismissView = true
                    self.uploadingNow = false
                    self.progressPercentile = 0
                }
            }.store(in: &subscription)
    }
    
    func uploadVideo(videoUrl: URL, filename: String, title: String, description:String, difficulty: Int, angle: Int) {
        uploadingNow = true
        self.progressPercentile = 0
        AuthApiService.tokenRefresh(username: getUserName()!)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                //                print("UVM completion \(completion)")
            } receiveValue: { (received: Token) in
                if(received.refreshToken == nil){
                    self.uploadingNow = false
                    print(received)
                    self.progressPercentile = 0
                }
                else{
                    AF.upload(multipartFormData: { (multipartFormData) in
                        multipartFormData.append(videoUrl, withName: "file", fileName: filename, mimeType: "video/mp4")
                    }, to: Config.baseURL+"videos", headers: [
                        .contentType("multipart/form-data"),
                        .accept("application/json"),
                        .authorization(bearerToken: UserDefaultsManager.shared.getTokens().accessToken!)
                    ])
                    .uploadProgress{ progress in
                        self.progressPercentile = progress.fractionCompleted
                    }
                    .response { response in
                        switch response.result{
                        case .success:
                            print("success!!")
                            do{
                                let data = try JSONDecoder().decode(Video.self, from: response.data!)
                                self.postArticle(videoId: data.videoId!, title: title, description: description, difficulty: difficulty, angle: angle)
                            }
                            catch{
                                self.uploadingNow = false
                                print(response.result)
                                self.progressPercentile = 0
                            }
                        case .failure:
                            self.uploadingNow = false
                            print(response.result)
                            self.progressPercentile = 0
                        }
                    }
                }
            }.store(in: &subscription)
    }
}
