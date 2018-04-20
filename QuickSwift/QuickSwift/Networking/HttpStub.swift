//
//  HttpStub.swift
//  QuickSwift
//
//  Created by tcui on 12/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Alamofire
import OHHTTPStubs

public extension OHHTTPStubs {
    static func defaultResponseHeader() -> [String: String] {
        return ["Content-Type":"application/json"]
    }
}

func stub(request: RequestFactory, localFile: String) {
    let request = request.toRequestModel()
    let path = request.path

    stub(condition: isPath(path)) { _ in
        let stubPath = OHPathForFileInBundle(localFile, Bundle.main)
        return fixture(filePath: stubPath!, headers: OHHTTPStubs.defaultResponseHeader())
    }
}
