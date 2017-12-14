//
//  FileManagerExtensions.swift
//  QuickSwift
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension FileManager {
    public static func directoryURL(for directory: SearchPathDirectory = .documentDirectory) -> URL {
        if let url = FileManager.default.urls(for: directory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Cound not find URL for specified directory!")
        }
    }

    public static func fileURL(fileName: String, in directory: SearchPathDirectory = .documentDirectory) -> URL {
        return directoryURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
    }

    public static func fileExists(fileName: String, in directory: SearchPathDirectory) -> Bool {
        let url = fileURL(fileName: fileName, in: directory)
        return FileManager.default.fileExists(atPath: url.path)
    }

    @discardableResult public static func touch(fileName: String, in directory: SearchPathDirectory = .documentDirectory) throws -> Bool {
        let url = fileURL(fileName: fileName, in: directory)
        return try touch(url: url)
    }

    @discardableResult public static func touch(url: URL) throws -> Bool {
        let exists = FileManager.default.fileExists(atPath: url.path)
        if !exists {
            let directoryUrl = url.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        }
        return exists
    }

    public static func clear(directory: SearchPathDirectory = .documentDirectory) throws {
        let url = directoryURL(for: directory)
        let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        try contents.forEach { (url) in
            try FileManager.default.removeItem(at: url)
        }
    }

    public static func save<T: Encodable>(_ object: T, intoFile fileName: String, in directory: SearchPathDirectory = .documentDirectory) throws {
        let url = fileURL(fileName: fileName, in: directory)
        let data = try object.toData()
        try touch(fileName: fileName, in: directory)
        try data.write(to: url, options: Data.WritingOptions.atomic)
    }

    public static func load<T: Decodable>(fromFile fileName: String, in directory: SearchPathDirectory = .documentDirectory) throws -> T {
        let url = fileURL(fileName: fileName, in: directory)

        guard fileExists(fileName: fileName, in: directory) else {
            fatalError("File at path \(url.path) does not exist!")
        }

        let data = try Data(contentsOf: url)
        let model = try T(fromData:data)
        return model
    }

    public static func remove(fileName: String, in directory: SearchPathDirectory = .documentDirectory) throws {
        let url = fileURL(fileName: fileName, in: directory)

        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }
}
