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
}

public extension String {
    var language: String? {
        let tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.language], options: 0)
        tagger.string = self
        return tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil)?.rawValue
    }
}
