//
//  File.swift
//  QuickSwift
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct File {
    private let name: String
    private let url: URL

    public var content: String {
        let content = try? String(contentsOf: url, encoding: .utf8)
        return content ?? ""
    }

    public var lines: [String] {
        return content.components(separatedBy: .newlines)
    }

    public init?(name: String, bundle: Bundle = Bundle.main) {
        guard let url = bundle.url(forResource: name.fileName, withExtension: name.fileExtension) else { return nil }
        self.name = name
        self.url = url
    }

    public init(name: String, in directory: FileManager.SearchPathDirectory) {
        self.name = name
        self.url = FileManager.fileURL(fileName: name, in: directory)
        if !FileManager.fileExists(fileName: name, in: directory) {
            try? FileManager.touch(url: url)
        }
    }

    public func write(string: String) throws {
        try string.write(to: url, atomically: true, encoding: .utf8)
    }
}
