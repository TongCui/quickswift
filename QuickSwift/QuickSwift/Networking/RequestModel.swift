//
//  RequestModel.swift
//  QuickSwift
//
//  Created by tcui on 10/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseHandler {
    case none
    case data
    case string
    case json
    case plist
}

enum RequestUrls: URLRequestConvertible {
    case createUser(parameters: Parameters)
    case readUser(username: String)
    case updateUser(username: String, parameters: Parameters)
    case destroyUser(username: String)
    
    static let baseURLString = "https://example.com"
    
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .readUser:
            return .get
        case .updateUser:
            return .put
        case .destroyUser:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case .readUser(let username):
            return "/users/\(username)"
        case .updateUser(let username, _):
            return "/users/\(username)"
        case .destroyUser(let username):
            return "/users/\(username)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try RequestUrls.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .updateUser(_, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}


struct RequestModel {
    var method: HTTPMethod = .get
    var path: String
    var host: String
}

protocol RequestModeling {
    associatedtype Model
    var method: HTTPMethod { get }
    var path: String { get }
    var host: String { get }
    var responseHandler: ResponseHandler { get }
}


struct TestNetworking {
    func testGet() {
        
    }
}
