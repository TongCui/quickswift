//
//  Model.swift
//  QuickSwift
//
//  Created by tcui on 21/11/2017.
//

import Foundation

public class AnnieModel {
    var age : Int
    var name : String
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    func greeting() -> String {
        return "Hello \(name) with age \(age)"
    }
}
