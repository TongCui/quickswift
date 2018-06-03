//
//  RequestModel.swift
//  QuickSwift
//
//  Created by tcui on 10/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation
import Alamofire

public enum ResponseType {
    case none
    case data
    case string
    case json
    case plist
}

public enum EncodingType {
    case queryString
    case body
    case jsonBody
}

public enum URLScheme {
    case http
    case https
}

public protocol RequestModelConvertible {
    var host: String {get}
    func toRequestModel() -> RequestModel
}

open class TTLManager {
    private struct TTLInfo {
        let ttl: TimeInterval
        let updateDate: Date
        let result: Any?

        init(ttl: TimeInterval, result: Any?) {
            self.ttl = ttl
            self.updateDate = Date()
            self.result = result
        }
    }

    public static let shared = TTLManager()
    private var ttlInfos: [String: TTLInfo]

    private init() {
        ttlInfos = [:]
    }

    public func isAlive(_ key: String) -> Bool {
        guard let ttlInfo = ttlInfos[key] else {
            return false
        }

        return Date().timeIntervalSince(ttlInfo.updateDate) <= ttlInfo.ttl
    }

    public func checkin(_ key: String, ttl: TimeInterval, result: Any?) {
        ttlInfos[key] = TTLInfo(ttl: ttl, result: result)
    }

    public func lastResult<T>(_ key: String) -> T? {
        guard let ttlInfo = ttlInfos[key], let result = ttlInfo.result as? T else {
            return nil
        }

        return result
    }
}

public extension RequestModelConvertible {
    public var alamofire: DataRequest {
        return Alamofire.request(toRequestModel())
    }
}

public struct RequestModel: URLRequestConvertible {

    public var method: HTTPMethod
    public var scheme: URLScheme
    public var path: String
    public var host: String
    public var params: Parameters = [:]
    public var encodingType: EncodingType = .queryString

    public init(_ method: HTTPMethod = .get, _ scheme: URLScheme = .https, _ host: String, _ path: String) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
    }

    public init(_ method: HTTPMethod = .get, _ scheme: URLScheme = .https, _ host: String, _ path: String, _ params: Parameters, _ encodingType: EncodingType = .queryString) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
        self.params = params
        self.encodingType = encodingType
    }

    public func parameterEncoding() -> ParameterEncoding {
        switch encodingType {
        case .queryString:          return URLEncoding.queryString
        case .body:                 return URLEncoding.httpBody
        case .jsonBody:             return JSONEncoding.default
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try host.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try parameterEncoding().encode(urlRequest, with: params)
    }

}

public struct Networking {
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    public static func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    if let interface = interface, String(cString: interface.ifa_name) == "en0" {

                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
}
