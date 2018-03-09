//
//  DataExtensions.swift
//  QuickSwift
//
//  Created by tcui on 9/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension Data {
    //  XOR
    func simpleEncrypted(offset: UInt8) -> Data {
        guard !self.isEmpty else {
            return self
        }

        let encrypted = self.reduce(into: [UInt8]()) { (result, byte) in
            result.append(byte ^ offset)
        }

        return Data(bytes: encrypted)
    }

    //  XOR
    func simpleDecrypted(offset: UInt8) -> Data {
        guard !self.isEmpty else {
            return self
        }
        return simpleEncrypted(offset: offset)
    }
}
