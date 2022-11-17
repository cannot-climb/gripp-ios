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
        print("HVM loadUserInfo()")
        guard let username = getUserName() else{
            print("HVM failed - username empty")
            return
        }
        self.titleUserName = username
        UserApiService.fetchUserInfo(username: username)
            .sink{
                (completion: Subscribers.Completion<AFError>) in
                print("HVM completion \(completion)")
            }
            receiveValue: { (received: User) in
                self.fetchUserSuccess.send()
                self.titleUserInfoString = "V\(String(received.tier ?? -1)), 상위 \(String(received.percentile ?? -1))%"
            }.store(in: &subscription)
    }
    
    func loadVideoList(){
        print("HVM loadVideoList()")
        
        self.articles = [
            ArticleResponse(username: "aaa", video: Video(videoId: "e21477a0-c7f4-4444-a5a5-7df7a95513e0", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/e21477a0-c7f4-4444-a5a5-7df7a95513e0/master.m3u8", streamingLength: 1218, streamingAspectRatio: 0.5638888888888889, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/e21477a0-c7f4-4444-a5a5-7df7a95513e0/thumbnail.png", status: "NO_CERTIFIED"), articleId: "29", title: "운영체제", description: "2강", level: 19, angle: 0, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-26 16:26:14"),
            ArticleResponse(username: "test", video: Video(videoId: "602b978c-b85d-40ab-9b79-4d492b5c1920", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/602b978c-b85d-40ab-9b79-4d492b5c1920/master.m3u8", streamingLength: 33, streamingAspectRatio: 1, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/602b978c-b85d-40ab-9b79-4d492b5c1920/thumbnail.png", status: "CERTIFIED"), articleId: "28", title: "Bell of the Wall", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 3, angle: 45, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:59:46"),
            ArticleResponse(username: "test", video: Video(videoId: "761c3d20-f322-4e36-8986-e8a021d7d3ca", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/761c3d20-f322-4e36-8986-e8a021d7d3ca/master.m3u8", streamingLength: 28, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/761c3d20-f322-4e36-8986-e8a021d7d3ca/thumbnail.png", status: "NO_CERTIFIED"), articleId: "27", title: "실패 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 2, angle: 20, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:28:44"),
            ArticleResponse(username: "test", video: Video(videoId: "c53735b4-7fed-45e6-b8af-8cb16256a181", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/c53735b4-7fed-45e6-b8af-8cb16256a181/master.m3u8", streamingLength: 35, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/c53735b4-7fed-45e6-b8af-8cb16256a181/thumbnail.png", status: "NO_CERTIFIED"), articleId: "26", title: "실패 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 10, angle: 10, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:28:17"),
            ArticleResponse(username: "test", video: Video(videoId: "f011af2d-866c-4062-b4e8-495a72ba8feb", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/f011af2d-866c-4062-b4e8-495a72ba8feb/master.m3u8", streamingLength: 9, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/f011af2d-866c-4062-b4e8-495a72ba8feb/thumbnail.png", status: "NO_CERTIFIED"), articleId: "25", title: "실패 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 0, angle: 0, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:27:49"),
            ArticleResponse(username: "test", video: Video(videoId: "d435218f-a1ef-4889-8d36-0ab48cf3545d", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/d435218f-a1ef-4889-8d36-0ab48cf3545d/master.m3u8", streamingLength: 36, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/d435218f-a1ef-4889-8d36-0ab48cf3545d/thumbnail.png", status: "CERTIFIED"), articleId: "24", title: "성공 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 19, angle: 90, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:27:24"),
            ArticleResponse(username: "test", video: Video(videoId: "a10ff49d-364a-481f-b47c-1d812eaca0c7", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/a10ff49d-364a-481f-b47c-1d812eaca0c7/master.m3u8", streamingLength: 28, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/a10ff49d-364a-481f-b47c-1d812eaca0c7/thumbnail.png", status: "CERTIFIED"), articleId: "23", title: "성공 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 3, angle: 45, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:26:51"),
            ArticleResponse(username: "test", video: Video(videoId: "629fb5f0-f0e3-4123-80c0-30bb45cc06f9", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/629fb5f0-f0e3-4123-80c0-30bb45cc06f9/master.m3u8", streamingLength: 29, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/629fb5f0-f0e3-4123-80c0-30bb45cc06f9/thumbnail.png", status: "CERTIFIED"), articleId: "22", title: "성공 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", level: 3, angle: 45, viewCount: 0, favoriteCount: 0, registerDateTime: "2022-10-19 02:26:19"),
            ArticleResponse(username: "njw1204", video: Video(videoId: "25e1041f-f302-4133-8d25-001aa2bc36f1", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/25e1041f-f302-4133-8d25-001aa2bc36f1/master.m3u8", streamingLength: 9, streamingAspectRatio: 1.7777777777777777, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/25e1041f-f302-4133-8d25-001aa2bc36f1/thumbnail.png", status: "NO_CERTIFIED"), articleId: "21", title: "Bottom of the Wall", description: "teste  테 테ㅐ ㅋ태ㅔㅋㅌ 처ㅐ ㅌ캨ㅌ츠ㅐㅌㅋ\n\n테스트", level: 3, angle: 50, viewCount: 19, favoriteCount: 0, registerDateTime: "2022-10-19 02:03:41"),
            ArticleResponse(username: "njw1204", video: Video(videoId: "9db3fa8c-cd6e-41d4-9583-a6b984a8285f", streamingUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/9db3fa8c-cd6e-41d4-9583-a6b984a8285f/master.m3u8", streamingLength: 33, streamingAspectRatio: 1, thumbnailUrl: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/9db3fa8c-cd6e-41d4-9583-a6b984a8285f/thumbnail.png", status: "CERTIFIED"), articleId: "20", title: "Top Of The Wall", description: "테스테스", level: 8, angle: 25, viewCount: 10, favoriteCount: 2, registerDateTime: "2022-10-19 02:01:35"),
            
        ]
        
        
        //testing
//        let headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Content-Type": "application/json",
//            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhaW02IiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTY2ODcwMDM1MiwiZXhwIjoxNjcxMjkyMzUyfQ.LndC7qp72mlWbIqN2ygfpy2cG9_PyXTRpelcKsq_AC0"
//        ]
//
//        var params = Parameters()
//        params["filters"] = [
//            "type": "LEVEL",
//            "minLevel": 0,
//            "maxLevel": 19
//          ]
//        params["pageToken"] = ""
//
//        AF.request(Config.baseURL+"articles/search", method: .post, parameters: ["filters":[
//            "type": "LEVEL",
//            "minLevel": 0,
//            "maxLevel": 19
//        ], "pageToken":""], encoding: CustomEncoding(), headers: headers).validate().responseJSON { response in
//            switch response.result {
//                case .success(let value):
//                    print(value)
//                case .failure(let error):
//                    print("oops")
//                    print(error)
//                }
//        }.cURLDescription { description in
//            print(description)
//        }
        //testing
        
//        UserApiService.loadArticles(minLevel:0,maxLevel:19, pageToken: "")
//            .sink{
//                (completion: Subscribers.Completion<AFError>) in
//                print("HVM completion \(completion)")
//            }
//            receiveValue: { (received: ArticleListResponse) in
//                self.loadVideoListSuccess.send()
//                self.nextPageToken = received.nextPageToken
//                self.articles = received.articles
//                print(self.articles)
//            }.store(in: &subscription)
    }
    
    func refreshVideoList(){
        
    }
    
    func loadMoreVideoList(more: String){
        
    }
}
