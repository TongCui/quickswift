//
//  Model.swift
//  QuickSwift
//
//  Created by tcui on 21/11/2017.
//

import Foundation

public protocol Identifiable {
    var id: String { get set }
}

public protocol FileIdentifiable {
    var fileName: String { get }
}
