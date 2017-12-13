//
//  AnnieModel.swift
//  QuickSwift
//
//  Created by tcui on 12/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

import Alamofire

public struct Company : Codable {
    let name: String
    let amount: Int
}

public class AnnieModel : FilePersistence, Codable, CustomStringConvertible, CustomCodable {
    
    
    public static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.dateDecodingStrategy = .secondsSince1970
        }
    }
    
    public static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .secondsSince1970
        }
    }
    
    public var description: String {
        return (try? self.toJSON()) ?? ""
    }
    
    public var age: Int
    public var name: String
    public var company = Company(name: "appAnnie", amount: 100)
    public var today = Date()
    
    public static var fileUrl: URL = {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("a.txt");
        return url
    }()
    
    public init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    public func save() throws {
        
    }
    
    public required convenience init(from fileUrl: URL) throws {
        self.init(age: 12, name: "ok")
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

