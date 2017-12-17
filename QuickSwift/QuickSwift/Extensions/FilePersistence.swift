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
    static func load(from fileName: String, in directory: FileManager.SearchPathDirectory) throws -> Self
}

public protocol UniqueFilePersistence: FilePersistence {
    static var fileName: String { get }
    static var fileDirectory: FileManager.SearchPathDirectory { get }
}

public extension FilePersistence where Self : Codable {
    public func save(to fileName: String, in directory: FileManager.SearchPathDirectory = .documentDirectory) throws {
        try FileManager.save(self, intoFile: fileName, in: directory)
    }

    public static func load(from fileName: String, in directory: FileManager.SearchPathDirectory = .documentDirectory) throws -> Self {
        return try FileManager.load(fromFile: fileName, in: directory)
    }

}

public extension UniqueFilePersistence where Self: Codable {
    public func save() throws {
        try FileManager.save(self, intoFile: Self.fileName, in: Self.fileDirectory)
    }

    public static func load() throws -> Self {
        return try FileManager.load(fromFile: Self.fileName, in: Self.fileDirectory)
    }
}
