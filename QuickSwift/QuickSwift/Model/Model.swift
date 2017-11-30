//
//  Model.swift
//  QuickSwift
//
//  Created by tcui on 21/11/2017.
//

import Foundation
import Alamofire

public class AnnieModel {
    public var age : Int
    public var name : String
    
    public init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    public func greeting() -> String {
        return "Hello \(name) with age \(age)"
    }
    
    public func ping(completion: @escaping () -> Void) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            completion()
        }
    }
}
