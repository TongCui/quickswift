//
//  AlamofireExtensions.swift
//  QuickSwift
//
//  Created by tcui on 29/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Alamofire

public extension Alamofire.Request {
    public static func serializeResponseModel<T: Codable>(
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> Alamofire.Result<T> {
            guard error == nil else { return .failure(error!) }

            guard let validData = data, validData.count > 0 else {
                return .failure(Alamofire.AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }

            do {
                let model = try T(fromData: validData)
                return .success(model)
            } catch {
                return .failure(Alamofire.AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
    }
}

public extension Alamofire.DataRequest {

    public static func modelResponseSerializer<T: Codable>()
        -> Alamofire.DataResponseSerializer<T> {
            return Alamofire.DataResponseSerializer { _, response, data, error in
                return Alamofire.Request.serializeResponseModel(response: response, data: data, error: error) as Result<T>
            }
    }

    @discardableResult
    public func responseModel<T: Codable>(
        queue: DispatchQueue? = nil,
        type: T.Type,
        completionHandler: @escaping (Alamofire.DataResponse<T>) -> Void)
        -> Self {
            return response(
                queue: queue,
                responseSerializer: Alamofire.DataRequest.modelResponseSerializer(),
                completionHandler: completionHandler
            )
    }
}
