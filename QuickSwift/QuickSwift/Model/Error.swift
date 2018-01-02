//
//  Error.swift
//  QuickSwift
//
//  Created by tcui on 2/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public enum DemoError: Error {
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
