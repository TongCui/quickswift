//
//  FileManagerExtensions.swift
//  QuickSwift
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension FileManager {
    public static func directoryURL(for directory: SearchPathDirectory) -> URL {
        if let url = FileManager.default.urls(for: directory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Cound not find URL for specified directory!")
        }
    }

    public static func fileURL(fileName: String, in directory: SearchPathDirectory) -> URL {
        return directoryURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
    }

    public static func fileExists(fileName: String, in directory: SearchPathDirectory) -> Bool {
        let url = fileURL(fileName: fileName, in: directory)
        return FileManager.default.fileExists(atPath: url.path)
    }

    static func touch(fileName: String, in directory: SearchPathDirectory) throws {
        let url = fileURL(fileName: fileName, in: directory)
        return try touch(url: url)
    }

    public static func touch(url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            let directoryUrl = url.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        }
    }

    public static func clear(directory: SearchPathDirectory) throws {
        let url = directoryURL(for: directory)
        let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        try contents.forEach { (url) in
            try FileManager.default.removeItem(at: url)
        }
    }

    //  TODO: handle array int dictionary
    public static func save<T: Encodable>(_ object: T, intoFile fileName: String, in directory: SearchPathDirectory ) throws {
        let url = fileURL(fileName: fileName, in: directory)
        try touch(fileName: fileName, in: directory)
        let data = try object.toData()
        try data.write(to: url, options: Data.WritingOptions.atomic)
    }

    public static func load<T: Decodable>(fromFile fileName: String, in directory: SearchPathDirectory ) throws -> T {
        let url = fileURL(fileName: fileName, in: directory)

        guard fileExists(fileName: fileName, in: directory) else {
            fatalError("File at path \(url.path) does not exist!")
        }

        let data = try Data(contentsOf: url)
        let model = try T(fromData:data)
        return model
    }

    public static func remove(fileName: String, in directory: SearchPathDirectory ) throws {
        let url = fileURL(fileName: fileName, in: directory)

        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }

    public static func fileURLs(in directory: SearchPathDirectory ) -> [URL] {
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: directoryURL(for: directory), includingPropertiesForKeys: nil, options: [])
            return urls
        } catch {
            return []
        }
    }

    public static func files(in directory: SearchPathDirectory ) -> [String] {
        return fileURLs(in: directory).map { $0.lastPathComponent }
    }
}
