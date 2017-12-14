//
//  FilePersistence.swift
//  QuickSwift
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol FilePersistence {
    func save(to fileName: String, in directory: FileManager.SearchPathDirectory) throws
    init(load fileName: String, in directory: FileManager.SearchPathDirectory) throws
    init(load fileName: String) throws
}

public extension FilePersistence where Self : Codable {
    public func save(to fileName: String, in directory: FileManager.SearchPathDirectory = .documentDirectory) throws {
        try FileManager.save(self, intoFile: fileName, in: directory)
    }

    public init(load fileName: String, in directory: FileManager.SearchPathDirectory = .documentDirectory) throws {
        self = try FileManager.load(fromFile: fileName, in: directory)
    }

    public init(load fileName: String) throws {
        self = try FileManager.load(fromFile: fileName, in: .documentDirectory)
    }
}
