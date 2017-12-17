//
//  AnnieModel.swift
//  QuickSwift
//
//  Created by tcui on 12/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation
import Alamofire

public class AnnieModel {

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
