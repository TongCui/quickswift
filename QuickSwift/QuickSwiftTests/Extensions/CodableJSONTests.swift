//
//  CodableJSONTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 14/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class CodableJSONTests: XCTestCase {

    func testDumpBasic() {
        XCTAssertEqual(try CodableJSON.dump(toString: [1, 2, 3]), "[1,2,3]")
        XCTAssertEqual(try CodableJSON.dump(toString: ["1", "2", "3"]), "[\"1\",\"2\",\"3\"]")
        XCTAssertEqual(try CodableJSON.dump(toString: [1:"100", 2:"200"]), "{\"1\":\"100\",\"2\":\"200\"}")
        XCTAssertEqual(try CodableJSON.dump(toString: ["1":"100", "2":"200"]), "{\"1\":\"100\",\"2\":\"200\"}")

        XCTAssertEqual(try CodableJSON.dump(toData: [1, 2, 3]), "[1,2,3]".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: ["1", "2", "3"]), "[\"1\",\"2\",\"3\"]".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: [1:"100", 2:"200"]), "{\"1\":\"100\",\"2\":\"200\"}".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: ["1":"100", "2":"200"]), "{\"1\":\"100\",\"2\":\"200\"}".toUtf8Data())
    }

    func testParseBasic() {
        XCTAssertEqual(try CodableJSON.parse(fromString: "[1,2,3]"), [1, 2, 3])
        XCTAssertEqual(try CodableJSON.parse(fromString: "[\"1\",\"2\",\"3\"]"), ["1", "2", "3"])
        XCTAssertEqual(try CodableJSON.parse(fromString: "{\"1\":\"100\",\"2\":\"200\"}"), [1:"100", 2:"200"])
        XCTAssertEqual(try CodableJSON.parse(fromString: "{\"1\":\"100\",\"2\":\"200\"}"), ["1":"100", "2":"200"])
    }

    func testDumpModel() {
        let codableModel = TestCodableModel()
        let dateModel = TestDateModel()
        let customCodableModel = TestCustomCodableModel()
        let codingKeysModel = TestCodingKeysModel()
        let complexModel = TestComplexModel()

        XCTAssertEqual(try CodableJSON.dump(toString: codableModel), "{\"intValue\":1,\"stringValue\":\"str\"}")
        XCTAssertEqual(try CodableJSON.dump(toString: dateModel) { encoder in encoder.dateEncodingStrategy = .secondsSince1970 }, "{\"dateValue\":0}")
        XCTAssertEqual(try CodableJSON.dump(toString: customCodableModel) { encoder in encoder.dateEncodingStrategy = .secondsSince1970 }, "{\"dateValue\":0}")
        XCTAssertEqual(try CodableJSON.dump(toString: codingKeysModel), "{\"int\":1,\"str\":\"str\"}")
        XCTAssertEqual(try CodableJSON.dump(toString: complexModel), "{\"doubleValue\":1.2,\"intArrayValue\":[1,2],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}")

        XCTAssertEqual(try CodableJSON.dump(toData: codableModel), "{\"intValue\":1,\"stringValue\":\"str\"}".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: dateModel) { encoder in encoder.dateEncodingStrategy = .secondsSince1970 }, "{\"dateValue\":0}".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: customCodableModel) { encoder in encoder.dateEncodingStrategy = .secondsSince1970 }, "{\"dateValue\":0}".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: codingKeysModel), "{\"int\":1,\"str\":\"str\"}".toUtf8Data())
        XCTAssertEqual(try CodableJSON.dump(toData: complexModel), "{\"doubleValue\":1.2,\"intArrayValue\":[1,2],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}".toUtf8Data())
    }

    func testParseModel() {
        var jsonString = ""

        jsonString = "{\"intValue\":100,\"stringValue\":\"str\"}"
        var codableModel: TestCodableModel = try! CodableJSON.parse(fromString: jsonString)
        XCTAssertEqual(codableModel.intValue, 100)
        codableModel = try! CodableJSON.parse(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(codableModel.intValue, 100)

        jsonString = "{\"dateValue\":0}"
        var dateModel: TestDateModel = try! CodableJSON.parse(fromString: jsonString) { decoder in decoder.dateDecodingStrategy = .secondsSince1970 }
        XCTAssertEqual(dateModel.dateValue, Date(timeIntervalSince1970: 0))
        dateModel = try! CodableJSON.parse(fromData: jsonString.toUtf8Data()) { decoder in decoder.dateDecodingStrategy = .secondsSince1970 }
        XCTAssertEqual(dateModel.dateValue, Date(timeIntervalSince1970: 0))

        jsonString = "{\"dateValue\":0}"
        var customCodableModel: TestCustomCodableModel = try! CodableJSON.parse(fromString: jsonString) { decoder in decoder.dateDecodingStrategy = .secondsSince1970 }
        XCTAssertEqual(customCodableModel.dateValue, Date(timeIntervalSince1970: 0))
        customCodableModel = try! CodableJSON.parse(fromData: jsonString.toUtf8Data()) { decoder in decoder.dateDecodingStrategy = .secondsSince1970 }
        XCTAssertEqual(customCodableModel.dateValue, Date(timeIntervalSince1970: 0))

        jsonString = "{\"int\":100,\"str\":\"str\"}"
        var codingKeysModel: TestCodingKeysModel = try! CodableJSON.parse(fromString: jsonString)
        XCTAssertEqual(codingKeysModel.intValue, 100)
        codingKeysModel = try! CodableJSON.parse(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(codingKeysModel.intValue, 100)

        jsonString = "{\"doubleValue\":1.2,\"intArrayValue\":[100,200],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}"
        var complexModel: TestComplexModel = try! CodableJSON.parse(fromString: jsonString)
        XCTAssertEqual(complexModel.intArrayValue, [100, 200])
        complexModel = try! CodableJSON.parse(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(complexModel.intArrayValue, [100, 200])
    }

    func testParseModelError() {
        var jsonString = ""

        jsonString = "{\"date\":0}"
        XCTAssertThrowsError(try CodableJSON.parse(fromString: jsonString) as TestDateModel)
    }

    func testModeltoJSONString() {
        let codableModel = TestCodableModel()
        //  let dateModel = TestDateModel()
        let customCodableModel = TestCustomCodableModel()
        let codingKeysModel = TestCodingKeysModel()
        let complexModel = TestComplexModel()

        XCTAssertEqual(try codableModel.toJSONString(), "{\"intValue\":1,\"stringValue\":\"str\"}")
        //  TODO: regex
        //  XCTAssertEqual(try dateModel.toJSONString(), "{\"dateValue\":0}")
        XCTAssertEqual(try customCodableModel.toJSONString(), "{\n  \"dateValue\" : 0\n}")
        XCTAssertEqual(try codingKeysModel.toJSONString(), "{\"int\":1,\"str\":\"str\"}")
        XCTAssertEqual(try complexModel.toJSONString(), "{\"doubleValue\":1.2,\"intArrayValue\":[1,2],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}")

        XCTAssertEqual(try codableModel.toData(), "{\"intValue\":1,\"stringValue\":\"str\"}".toUtf8Data())
        //  TODO: regex
        //  XCTAssertEqual(try dateModel.toJSONString(), "{\"dateValue\":0}")
        XCTAssertEqual(try customCodableModel.toData(), "{\n  \"dateValue\" : 0\n}".toUtf8Data())
        XCTAssertEqual(try codingKeysModel.toData(), "{\"int\":1,\"str\":\"str\"}".toUtf8Data())
        XCTAssertEqual(try complexModel.toData(), "{\"doubleValue\":1.2,\"intArrayValue\":[1,2],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}".toUtf8Data())

    }

    func testModelInitFromJSON() {
        var jsonString = ""

        jsonString = "{\"intValue\":100,\"stringValue\":\"str\"}"
        var codableModel = try! TestCodableModel(fromString: jsonString)
        XCTAssertEqual(codableModel.intValue, 100)
        codableModel = try! TestCodableModel(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(codableModel.intValue, 100)

        jsonString = "{\"dateValue\":0}"
        var customCodableModel = try! TestCustomCodableModel(fromString: jsonString)
        XCTAssertEqual(customCodableModel.dateValue, Date(timeIntervalSince1970: 0))
        customCodableModel = try! TestCustomCodableModel(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(customCodableModel.dateValue, Date(timeIntervalSince1970: 0))

        jsonString = "{\"int\":100,\"str\":\"str\"}"
        var codingKeysModel = try! TestCodingKeysModel(fromString: jsonString)
        XCTAssertEqual(codingKeysModel.intValue, 100)
        codingKeysModel = try! TestCodingKeysModel(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(codingKeysModel.intValue, 100)

        jsonString = "{\"doubleValue\":1.2,\"intArrayValue\":[100,200],\"intDictionary\":{\"1\":1,\"2\":2},\"intValue\":1,\"strDictionary\":{\"1\":1,\"2\":2},\"stringArrayValue\":[\"1\",\"2\"],\"stringValue\":\"str\"}"
        var complexModel = try! TestComplexModel(fromString: jsonString)
        XCTAssertEqual(complexModel.intArrayValue, [100, 200])
        complexModel = try! TestComplexModel(fromData: jsonString.toUtf8Data())
        XCTAssertEqual(complexModel.intArrayValue, [100, 200])
    }

}
