//
//  WebService.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire

class WebService {
    func getPost(completion: @escaping ([Post]) -> ()) {
        let api = Config.baseURL+"/post"
        AF.request(api, method: .get)
            .responseDecodable(of: [Post].self) { (response) in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([Post].self, from: data)
                        completion(data)
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
    }
    func getUser(completion: @escaping (User) -> ()) {
        let api = Config.baseURL+"/post"
        AF.request(api, method: .get)
            .responseDecodable(of: User.self) { (response) in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(User.self, from: data)
                        completion(data)
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
    }
    func getVideo(completion: @escaping (Video) -> ()) {
        let api = Config.baseURL+"/post"
        AF.request(api, method: .get)
            .responseDecodable(of: Video.self) { (response) in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(Video.self, from: data)
                        completion(data)
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
    }
}
