//
//  CustomEncoder.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/18.
//

import Foundation
import Alamofire

extension NSNumber {
fileprivate var isBool: Bool {
    return CFBooleanGetTypeID() == CFGetTypeID(self)
  }
}

struct CustomEncoding: ParameterEncoding {
fileprivate func escape(_ string: String) -> String {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowedCharacterSet = CharacterSet.urlQueryAllowed
//    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

    var escaped = string
//    if #available(iOS 8.3, *) {
//        escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
//    } else {
//        let batchSize = 50
//        var index = string.startIndex
//
//        while index != string.endIndex {
//            let startIndex = index
//            let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
//            let range = startIndex..<endIndex
//
//            let substring = string.substring(with: range)
//
//            escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
//
//            index = endIndex
//        }
//    }
    return escaped
}

fileprivate func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []

    if let dictionary = value as? [String: Any] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        for value in array {
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
        components.append((escape(key), escape("\(value)")))
    }

    return components
}

fileprivate func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    for key in parameters.keys.sorted(by: <) {
        let value = parameters[key]!
        components += queryComponents(fromKey: key, value: value)
    }
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var request: URLRequest = try urlRequest.asURLRequest()
    guard let parameters = parameters else { return request }
    guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
        // Handle the error
        return request
    }
    if request.urlRequest?.httpMethod == "GET" {
        mutableRequest.url = URL(string: (mutableRequest.url?.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))!)
    }

    if request.urlRequest?.httpMethod == "POST" {
        mutableRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
        if mutableRequest.httpBody != nil {
            let httpBody = NSString(data: mutableRequest.httpBody!, encoding: String.Encoding.utf8.rawValue)!
            mutableRequest.httpBody = httpBody.replacingOccurrences(of: "%5B%5D=", with: "=").data(using: String.Encoding.utf8)
        }
    }
    request = mutableRequest as URLRequest
    return request
  }
}
