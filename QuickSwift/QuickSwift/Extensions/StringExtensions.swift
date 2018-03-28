//
//  StringExtensions.swift
//  QuickSwift
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension String {
    var fileName: String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    var fileExtension: String? {
        let ext = URL(fileURLWithPath: self).pathExtension

        return ext.isEmpty ? nil : ext
    }
}

public extension String {
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func `repeat`(_ times: Int) -> String {
        return Array(repeating: self, count: times).joined(separator: "")
    }
}

public extension String {
    var language: String? {
        let tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.language], options: 0)
        tagger.string = self
        return tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil)?.rawValue
    }
}

/** Read File */

public extension String {

    init?(file: String, bundle: Bundle = Bundle.main) {
        guard let url = bundle.url(forResource: file.fileName, withExtension: file.fileExtension) else {
            return nil
        }

        do {
            try self.init(contentsOf: url, encoding: .utf8)
        } catch {
            return nil
        }
    }

    init?(file: String, in directory: FileManager.SearchPathDirectory) {
        guard FileManager.fileExists(fileName: file, in: directory) else {
            return nil
        }

        let url = FileManager.fileURL(fileName: file, in: directory)

        do {
            try self.init(contentsOf: url, encoding: .utf8)
        } catch {
            return nil
        }
    }

    func write(file: String, in directory: FileManager.SearchPathDirectory) throws {
        if !FileManager.fileExists(fileName: file, in: directory) {
            try FileManager.touch(fileName: file, in: directory)
        }
        let url = FileManager.fileURL(fileName: file, in: directory)
        try write(to: url, atomically: true, encoding: .utf8)
    }
}

public extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty {

            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}

public extension Array where Element == String {
    mutating func readLines(file: String, bundle: Bundle = Bundle.main) {
        if let content = String(file: file, bundle: bundle) {
            self = content.components(separatedBy: .newlines)
        }
    }

    mutating func readLines(file: String, in directory: FileManager.SearchPathDirectory) {
        if let content = String(file: file, in: directory) {
            self = content.components(separatedBy: .newlines)
        }
    }

    func write(file: String, in directory: FileManager.SearchPathDirectory) throws {
        try joined(separator: "\n").write(file: file, in: directory)
    }
}

// MARK: - UI
public extension String {
    func toStoryboard() -> UIStoryboard {
        return UIStoryboard(name: self, bundle: nil)
    }

    func toViewController(storyboard: String) -> UIViewController {
        return storyboard.toStoryboard().instantiateViewController(withIdentifier: self)
    }

    func toNib() -> UINib {
        return UINib(nibName: self, bundle: nil)
    }
}
