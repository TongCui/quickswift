//
//  RequestModel.swift
//  QuickSwift
//
//  Created by tcui on 10/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseType {
    case none
    case data
    case string
    case json
    case plist
}

enum EncodingType {
    case queryString
    case body
    case jsonBody
}

enum URLScheme {
    case http
    case https
}

protocol RequestFactory: URLRequestConvertible {
    var host: String {get}
    func toRequestModel() -> RequestModel
}

extension RequestFactory {
    func asURLRequest() throws -> URLRequest {
        return try toRequestModel().toURLRequest()
    }
}

struct RequestModel {
    var method: HTTPMethod
    var scheme: URLScheme
    var path: String
    var host: String
    var params: Parameters = [:]
    var encodingType: EncodingType = .queryString

    init(_ method: HTTPMethod = .get, _ scheme: URLScheme = .https, _ host: String, _ path: String) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
    }

    init(_ method: HTTPMethod = .get, _ scheme: URLScheme = .https, _ host: String, _ path: String, _ params: Parameters, _ encodingType: EncodingType = .queryString) {
        self.method = method
        self.scheme = scheme
        self.host = host
        self.path = path
        self.params = params
        self.encodingType = encodingType
    }

    func toURLRequest() throws -> URLRequest {
        let url = try host.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try parameterEncoding().encode(urlRequest, with: params)
    }

    func parameterEncoding() -> ParameterEncoding {
        switch encodingType {
        case .queryString:          return URLEncoding.queryString
        case .body:                 return URLEncoding.httpBody
        case .jsonBody:             return JSONEncoding.default
        }
    }
}

extension Request {
    static func serializeResponseModel<T: Codable>(
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

extension DataRequest {

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
