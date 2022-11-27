//
//  ApiLogger.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/13.
//

import Foundation
import Alamofire

final class ApiLogger: EventMonitor {
    
    let queue = DispatchQueue (label: "Oauth_alamofire_ApiLogger")
    
    //Event called when any type of Request is resumed.
    func requestDidResume (_ request: Request) {
//        print ("Resuming: \(request)")
    }
    // Event called whenever a DataRequest has parsed a response.
    func request<Value> (_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
//        debugPrint ("Finished: \(response)")
    }
}
