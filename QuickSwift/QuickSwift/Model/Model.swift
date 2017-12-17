//
//  Model.swift
//  QuickSwift
//
//  Created by tcui on 21/11/2017.
//

import Foundation

public enum ModelError: Error {
    public struct Context {
        public let debugDescription: String
        public let underlyingError: Error?

        public init(debugDescription: String, underlyingError: Error? = nil) {
            self.debugDescription = debugDescription
            self.underlyingError = underlyingError
        }
    }

    case fileSaveFailed(Any, Context)
    case fileLoadFailed(String, Context)

    public var userInfo: [String: Any]? {
        let context: Context
        switch self {
        case .fileSaveFailed(_, let c): context = c
        case .fileLoadFailed(_, let c): context = c
        }

        var userInfo: [String: Any] = [
            "NSDebugDescription": context.debugDescription
        ]

        if let underlyingError = context.underlyingError {
            userInfo["NSUnderlyingError"] = underlyingError
        }
        return userInfo
    }

}

public protocol Identifiable {
    var id: String { get set }
}

public protocol FileIdentifiable {
    var fileName: String { get }
}
