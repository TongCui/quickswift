//
//  Requests.swift
//  Example
//
//  Created by tcui on 12/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Alamofire
import QuickSwift

enum Requests: RequestModelConvertible {
    var host: String { return "https://localhost" }
    
    case users
    case createUser
    case readUser(username: String)
    case updateUser(username: String, newname: String)
    case destroyUser(username: String)
    
    func toRequestModel() -> RequestModel {
        switch self {
        case .users:
            return RequestModel(.get, .http, host, "/users")
        case .createUser:
            return RequestModel(.get, .http, host, "/user/create")
        case .readUser(let username):
            return RequestModel(.get, .http, host, "/user/read", ["name": username])
        case .updateUser(let username, let newname):
            return RequestModel(.post, .http, host, "/user/update", ["old": username, "new": newname], .body)
        case .destroyUser(let username):
            return RequestModel(.post, .http, host, "/user/remove", ["name": username], .jsonBody)
        }
    }
}

struct Student: Codable {
    var name: String
    var age: Int
}

struct DefaultResponse<T: Codable> : Codable {
    var model: T?
    
    enum CodingKeys: String, CodingKey {
        case model = "data"
    }
}
