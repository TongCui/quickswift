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

public protocol RequestFactory: URLRequestConvertible {
    var host: String {get}
    func toRequestModel() -> RequestModel
}

public extension RequestFactory {
    public func asURLRequest() throws -> URLRequest {
        return try toRequestModel().toURLRequest()
    }
}

public struct RequestModel {
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

    public func toURLRequest() throws -> URLRequest {
        let url = try host.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try parameterEncoding().encode(urlRequest, with: params)
    }

    public func parameterEncoding() -> ParameterEncoding {
        switch encodingType {
        case .queryString:          return URLEncoding.queryString
        case .body:                 return URLEncoding.httpBody
        case .jsonBody:             return JSONEncoding.default
        }
    }

}

public extension Request {
    public static func serializeResponseModel<T: Codable>(
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> Result<T> {
            guard error == nil else { return .failure(error!) }

            guard let validData = data, validData.count > 0 else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }

            do {
                let model = try T(fromData: validData)
                return .success(model)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
    }
}

public extension DataRequest {

    public static func modelResponseSerializer<T: Codable>()
        -> DataResponseSerializer<T> {
            return DataResponseSerializer { _, response, data, error in
                return Request.serializeResponseModel(response: response, data: data, error: error) as Result<T>
            }
    }

    @discardableResult
    public func responseModel<T: Codable>(
        queue: DispatchQueue? = nil,
        type: T.Type,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
            return response(
                queue: queue,
                responseSerializer: DataRequest.modelResponseSerializer(),
                completionHandler: completionHandler
            )
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
