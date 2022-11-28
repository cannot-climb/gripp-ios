//
//  PlayerViewModel.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/18.
//

import Foundation
import Alamofire
import Combine


class PlayerViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    @Published var articleId = ""
    @Published var videoTitle = ""
    @Published var videoAngle = ""
    @Published var videoDate = ""
    @Published var videoUser = ""
    @Published var videoViewCount = "aaaa"
    @Published var videoUrl = ""
    @Published var videoDescription = ""
    @Published var videoFavoriteCount = ""
    @Published var videoLevel = ""
    @Published var videoUserInfoString = ""
    @Published var videoFavorite = false
    @Published var videoThumbnail = ""
    
    func setVideoThumbnail(url: String){
        self.videoThumbnail = url
    }
    
    func setVideoInfo(articleResponse: ArticleResponse){
        self.articleId = articleResponse.articleId!
        self.videoTitle = articleResponse.title!
        self.videoAngle = String(articleResponse.angle!)
        self.videoDate = articleResponse.registerDateTime!
        self.videoUser = articleResponse.username!
        self.videoViewCount = String(articleResponse.viewCount!)
        self.videoUrl = articleResponse.video!.streamingUrl!
        self.videoDescription = articleResponse.description!
        self.videoLevel = String(articleResponse.level!)
        
        UserApiService.fetchArticleInfo(articleId: articleResponse.articleId!)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("PVM completion \(completion)")
            }
            receiveValue: { (received: Article) in
                if(received.favorite == nil){
//                    print("PVM login fail")
                }
                else{
                    self.videoFavorite = received.favorite!
                    self.videoFavoriteCount = String(received.favoriteCount!)
                }
            }.store(in: &subscription)
    }
    
    func setVideoUrl(videoUrl: String){
        self.videoUrl = videoUrl
    }
    
    func toggleFavorite(){
        UserApiService.likeArticle(articleId: self.articleId, favorite: !self.videoFavorite)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("PVM completion \(completion)")
            }
            receiveValue: { (received: Article) in
                if(received.favorite == nil){
//                    print("PVM favorite fail")
                }
                else{
                    if(self.videoFavorite){
                        self.videoFavoriteCount = String(Int(self.videoFavoriteCount)! - 1)
                    }
                    else{
                        self.videoFavoriteCount = String(Int(self.videoFavoriteCount)! + 1)
                    }
                    self.videoFavorite.toggle()
                }
            }.store(in: &subscription)
    }
    
    func deleteVideo(){
        UserApiService.deleteArticle(articleId: self.articleId)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
//                print("PVM completion \(completion)")
            }
            receiveValue: { (received: Article) in
                self.articleId = received.articleId ?? ""
            }.store(in: &subscription)
    }
}
