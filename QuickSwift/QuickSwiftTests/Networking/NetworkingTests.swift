//
//  NetworkingTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
import Alamofire
import OHHTTPStubs
@testable import QuickSwift

class NetworkingTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAlamofireAndStub() {
        stub(condition: isPath("/teststub")) { _ in
            let stubPath = OHPathForFile("stub.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        let expect = expectation(description: "Waiting for response")
        Alamofire.request("http://localhost/teststub")
            .responseString { (response) in
                let content = String(file: "stub.json", bundle: Bundle.test)!
                XCTAssertEqual(response.result.value, content)
                expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testRequestModel() {
        var request: DataRequest

        request = Alamofire.request(Requests.createUser)
        XCTAssertEqual(request.request?.url?.absoluteString, "https://localhost/user/create")

        request = Alamofire.request(Requests.readUser(username: "a"))
        XCTAssertEqual(request.request?.url?.absoluteString, "https://localhost/user/read?name=a")

        request = Alamofire.request(Requests.updateUser(username: "a", newname: "b"))
        XCTAssertEqual(request.request?.url?.absoluteString, "https://localhost/user/update")
        XCTAssertEqual(try! request.request!.httpBody!.toUtf8S(), "new=b&old=a")

        request = Alamofire.request(Requests.destroyUser(username: "a"))
        XCTAssertEqual(request.request?.url?.absoluteString, "https://localhost/user/remove")
        XCTAssertEqual(try! request.request!.httpBody!.toUtf8S(), "{\"name\":\"a\"}")

    }

    func testResponseModel() {
        stub(condition: isPath("/persons")) { _ in
            let stubPath = OHPathForFile("stub-persons.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        let expect = expectation(description: "Waiting for response")
        Alamofire.request("http://localhost/persons")
            .responseModel(type: DefaultResponse<[Person]>.self) { (response) in
                let persons = response.result.value!.model!

                XCTAssertEqual(persons.count, 2)
                XCTAssertEqual(persons[0].name, "name1")
                XCTAssertEqual(persons[1].name, "name2")

                expect.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
