//
//  ModelTestCases.swift
//  QuickSwiftTests
//
//  Created by tcui on 5/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class ModelTestCases: XCTestCase {

    func testModel0() {
        print("Test Model - \(Model1.modelDescription())")
        //  Model
        var model: Model0? = Model0(age: 12, name: "hello world")

        //  Test toJSON
        XCTAssertEqual(try! model.toJSON().count, 2)
        //  Test toJSONString
        XCTAssertEqual(try! model.toJSONString(), "{\"age\":12,\"name\":\"hello world\"}")

        //  Test Parse from valid string
        var string = "{\"age\":20,\"name\":\"appannie\"}"
        model = try? Model0(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.age, 20)
        XCTAssertEqual(model?.name, "appannie")

        //  Test Parse from invalid string
        string = "{\"age\":\"20\",\"name\":\"appannie\"}"
        model = try? Model0(fromString: string)
        XCTAssertNil(model)
    }

    func testModel1() {
        print("Test Model - \(Model1.modelDescription())")
        //  Model
        var model: Model1? = Model1()
        model?.age = 12
        model?.name = "hello world"

        //  Test toJSON
        XCTAssertEqual(try! model.toJSON().count, 2)
        //  Test toJSONString
        XCTAssertEqual(try! model.toJSONString(), "{\"age\":12,\"name\":\"hello world\"}")

        //  Test Parse from valid string
        var string = "{\"age\":20,\"name\":\"appannie\"}"
        model = try? Model1(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.age, 20)
        XCTAssertEqual(model?.name, "appannie")

        //  Test Parse from invalid string
        string = "{\"age\":\"20\",\"name\":\"appannie\"}"
        model = try? Model1(fromString: string)
        XCTAssertNil(model)
    }

    func testModel2() {
        print("Test Model - \(Model2.modelDescription())")
        let date = Date(timeIntervalSince1970: 0)
        //  Model
        var model: Model2? = Model2(date: date)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 1)
        //  Test toJSONString

        XCTAssertEqual(try! model?.toJSONString(), "{\"date\":-978307200}")

        //  Test Parse from valid string
        var string = "{\"date\":-978307100}"
        model = try? Model2(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.date, Date(timeIntervalSince1970: 100))

        //  Test Parse from invalid string
        string = "{\"date\":\"-978307100\"}"
        model = try? Model2(fromString: string)
        XCTAssertNil(model)

        string = "{\"date\":\"2018-01-01\"}"
        model = try? Model2(fromString: string)
        XCTAssertNil(model)
    }

    func testModel3() {
        print("Test Model - \(Model3.modelDescription())")
        let date = Date(timeIntervalSince1970: 0)
        //  Model
        var model: Model3? = Model3(date: date)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 1)
        //  Test toJSONString
        XCTAssertEqual(try! model?.toJSONString(), "{\"date\":0}")

        //  Test Parse from valid string
        var string = "{\"date\":100}"
        model = try? Model3(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.date, Date(timeIntervalSince1970: 100))

        //  Test Parse from invalid string
        string = "{\"date\":\"100\"}"
        model = try? Model3(fromString: string)
        XCTAssertNil(model)

        string = "{\"date\":\"2018-01-01\"}"
        model = try? Model3(fromString: string)
        XCTAssertNil(model)
    }

    func testModel4() {
        print("Test Model - \(Model4.modelDescription())")
        let date = Date(timeIntervalSince1970: 0)
        //  Model
        var model: Model4? = Model4(date: date)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 1)
        //  Test toJSONString
        XCTAssertEqual(try! model?.toJSONString(), "{\"date\":\"1970-01-01\"}")

        //  Test Parse from valid string
        var string = "{\"date\":\"1970-01-02\"}"
        model = try? Model4(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.date, Model4.formatter.date(from: "1970-01-02"))

        //  Test Parse from invalid string
        string = "{\"date\":\"100\"}"
        model = try? Model4(fromString: string)
        XCTAssertNil(model)

        string = "{\"date\":1000}"
        model = try? Model4(fromString: string)
        XCTAssertNil(model)
    }

    func testModel5() {
        print("Test Model - \(Model5.modelDescription())")
        //  Model
        var model: Model5? = Model5(weights: [1.1, 2.2, 3.3], names: ["a", "b", "c"])

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 2)
        //  Test toJSONString
        let jsonString = try! model.toJSONString()
        let match = jsonString.hasPrefix("{\"names\":[\"a\",\"b\",\"c\"],\"weights\":")
        XCTAssertTrue(match)

        var string = "{\"names\":[\"a\",\"b\",\"c\"],\"weights\":[1.1, 2.2, 3.3]}"
        model = try? Model5(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.names, ["a", "b", "c"])
        XCTAssertEqual(model!.weights, [1.1, 2.2, 3.3])

        string = "{\"wrong_names\":[\"a\",\"b\",\"c\"],\"weights\":[1.1, 2.2, 3.3]}"
        model = try? Model5(fromString: string)
        XCTAssertNil(model)

        string = "{\"wrong_names\":[\"a\",\"b\",\"c\"],\"weights\":[\"1\"]}"
        model = try? Model5(fromString: string)
        XCTAssertNil(model)
    }

    func testModel6() {
        print("Test Model - \(Model6.modelDescription())")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        //  Model
        var model: Model6? = Model6()
        model?.counts = [1, 2]
        model?.birthdays = [formatter.date(from: "2000-01-01")!, formatter.date(from: "2010-01-01")!]

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 2)
        //  Test toJSONString
//        XCTAssertEqual(try! model?.toJSONString(), "{\"birthdays\":[\"1999-12-31T16:00:00Z\",\"2009-12-31T16:00:00Z\"],\"counts\":[1,2]}")

        let string = "{\"birthdays\":[\"1999-12-31T16:00:00Z\",\"2009-12-31T16:00:00Z\"],\"counts\":[]}"
        model = try? Model6(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.counts, [])
        XCTAssertEqual(model!.birthdays.count, 2)

    }

    func testModel7() {
        print("Test Model - \(Model7.modelDescription())")

        //  Model
        var model: Model7? = Model7(age: 12)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 1)
        //  Test toJSONString
        XCTAssertEqual(try! model?.toJSONString(), "{\"age\":12}")

        model = Model7(age: nil)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 0)
        //  Test toJSONString
        XCTAssertEqual(try! model?.toJSONString(), "{}")

        var string = "{\"age\":100}"
        model = try? Model7(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.age, 100)

        string = "{}"
        model = try? Model7(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNil(model?.age)

        string = "{\"age\":null}"
        model = try? Model7(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNil(model?.age)

        string = "{\"age\":\"12\"}"
        model = try? Model7(fromString: string)
        XCTAssertNil(model)
    }

    func testModel8() {
        print("Test Model - \(Model8.modelDescription())")

        //  Model
        var model: Model8? = Model8(defaultName: "default", customName: "custom")

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 2)
        //  Test toJSONString
        XCTAssertEqual(try! model?.toJSONString(), "{\"custom_name\":\"custom\",\"defaultName\":\"default\"}")

        var string = "{\"custom_name\":\"custom\", \"defaultName\":\"default\"}"
        model = try? Model8(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.defaultName, "default")
        XCTAssertEqual(model!.customName, "custom")

        string = "{\"customName\":\"custom\", \"defaultName\":\"default\"}"
        model = try? Model8(fromString: string)
        XCTAssertNil(model)
    }

    func testModel9() {
        print("Test Model - \(Model9.modelDescription())")

        //  Model
        var model: Model9? = Model9(value: 1.2)

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 1)
        //  Test toJSONString
        XCTAssertNotNil(try model?.toJSONString())

        model?.value = Float.nan
        XCTAssertEqual(try model?.toJSONString(), "{\"value\":\"nan\"}")

        model?.value = Float.infinity
        XCTAssertEqual(try model?.toJSONString(), "{\"value\":\"+inf\"}")

        model?.value = -Float.infinity
        XCTAssertEqual(try model?.toJSONString(), "{\"value\":\"-inf\"}")

        var string = "{\"value\":1.2}"
        model = try? Model9(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.value, 1.2, accuracy: 0.001)

        string = "{\"value\":\"nan\"}"
        model = try? Model9(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertTrue(model!.value.isNaN)

        string = "{\"value\":\"+inf\"}"
        model = try? Model9(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertTrue(model!.value.isInfinite)

        string = "{\"value\":\"-inf\"}"
        model = try? Model9(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.value, -.infinity)

    }

    func testModel10() {
        print("Test Model - \(Model10.modelDescription())")

        //  Model
        var model: Model10? = Model10()
        model?.urlString = "http://www.google.com"
        model?.url = URL(string: "http://www.google.com")

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 2)
        //  Test toJSONString
        XCTAssertEqual(try model?.toJSONString(), "{\"url\":\"http:\\/\\/www.google.com\",\"urlString\":\"http:\\/\\/www.google.com\"}")

        var string = "{\"url\":\"http:\\/\\/www.google.com\",\"urlString\":\"http:\\/\\/www.google.com\"}"
        model = try? Model10(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.urlString, "http://www.google.com")
        XCTAssertEqual(model!.url!.absoluteString, "http://www.google.com")

        string = "{\"urlString\":\"invalid url string\",\"url\":\"invalid url\"}"
        model = try? Model10(fromString: string)
        XCTAssertNil(model)
    }

    func testModel11() {
        print("Test Model - \(Model11.modelDescription())")

        //  Model
        var model: Model11? = Model11()
        model?.name = "name"
        model?.value = 12
        model?.age = 18

        //  Test toJSON
        XCTAssertEqual(try! model?.toJSON().count, 2)
        //  Test toJSONString
        XCTAssertEqual(try model?.toJSONString(), "{\"info\":{\"age\":18,\"value\":12},\"name\":\"name\"}")

        var string = "{\"info\":{\"age\":18,\"value\":12},\"name\":\"name\"}"
        model = try? Model11(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.name, "name")
        XCTAssertEqual(model!.age, 18)
        XCTAssertEqual(model!.value, 12)

        string = "{\"name\":\"name\"}"
        model = try? Model11(fromString: string)
        XCTAssertNil(model)
    }

    func testModel12() {
        print("Test Model - \(Model12.modelDescription())")

        //  Model
        var model: Model12?

        model = Model12()
        model?.name = "name"
        XCTAssertEqual(try model?.toJSONString(), "{\"name\":\"name\"}")
        model?.age = 18
        XCTAssertEqual(try model?.toJSONString(), "{\"info\":{\"age\":18},\"name\":\"name\"}")
        model?.value = 20
        XCTAssertEqual(try model?.toJSONString(), "{\"info\":{\"age\":18,\"value\":20},\"name\":\"name\"}")

        var string = "{}"
        model = try? Model12(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNil(model?.name)
        XCTAssertNil(model?.age)
        XCTAssertNil(model?.value)

        string = "{\"name\":\"name\"}"
        model = try? Model12(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.name)
        XCTAssertNil(model?.age)
        XCTAssertNil(model?.value)

        string = "{\"info\":{\"age\":18},\"name\":\"name\"}"
        model = try? Model12(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.name)
        XCTAssertNotNil(model?.age)
        XCTAssertNil(model?.value)

        string = "{\"info\":{\"age\":20,\"value\":12},\"name\":\"name\"}"
        model = try? Model12(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.name)
        XCTAssertNotNil(model?.age)
        XCTAssertNotNil(model?.value)
    }

    func testModel13() {
        print("Test Model - \(Model13.modelDescription())")

        //  Model
        var model: Model13?

        model = Model13()
        XCTAssertEqual(try model?.toJSONString(), "{}")
        model?.name = "name"
        XCTAssertEqual(try model?.toJSONString(), "{\"name\":\"name\"}")
        model?.model = Model0(age: 10, name: "name")
        XCTAssertEqual(try model?.toJSONString(), "{\"model\":{\"age\":10,\"name\":\"name\"},\"name\":\"name\"}")

        var string = "{}"
        model = try? Model13(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNil(model?.name)
        XCTAssertNil(model?.model)

        string = "{\"name\":\"name\"}"
        model = try? Model13(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.name)
        XCTAssertNil(model?.model)

        string = "{\"model\":{\"age\":10,\"name\":\"name\"},\"name\":\"name\"}"
        model = try? Model13(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.name)
        XCTAssertNotNil(model?.model)

    }

    func testModel14() {
        print("Test Model - \(Model14.modelDescription())")

        //  Model
        var model: Model14?

        model = Model14()
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":[]}")
        model?.models.append(Model0(age: 1, name: "name1"))
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":[{\"age\":1,\"name\":\"name1\"}]}")
        model?.models.append(Model0(age: 2, name: "name2"))
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":[{\"age\":1,\"name\":\"name1\"},{\"age\":2,\"name\":\"name2\"}]}")

        var string = "{}"
        model = try? Model14(fromString: string)
        XCTAssertNil(model)

        string = "{\"models\":[]}"
        model = try? Model14(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertTrue(model!.models.isEmpty)

        string = "{\"models\":[{\"age\":1,\"name\":\"name1\"},{\"age\":2,\"name\":\"name2\"}]}"
        model = try? Model14(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.models.count, 2)

    }

    func testModel15() {
        print("Test Model - \(Model15.modelDescription())")

        //  Model
        var model: Model15?

        model = Model15()
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":{}}")
        model?.models["1"] = Model0(age: 1, name: "name1")
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":{\"1\":{\"age\":1,\"name\":\"name1\"}}}")
        model?.models["2"] = Model0(age: 2, name: "name2")
        XCTAssertEqual(try model?.toJSONString(), "{\"models\":{\"1\":{\"age\":1,\"name\":\"name1\"},\"2\":{\"age\":2,\"name\":\"name2\"}}}")

        var string = "{}"
        model = try? Model15(fromString: string)
        XCTAssertNil(model)

        string = "{\"models\":{}}"
        model = try? Model15(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertTrue(model!.models.isEmpty)

        string = "{\"models\":{\"1\":{\"age\":1,\"name\":\"name1\"},\"2\":{\"age\":2,\"name\":\"name2\"}}}"
        model = try? Model15(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.models.count, 2)
        XCTAssertEqual(model!.models["1"]!.name, "name1")
        XCTAssertEqual(model!.models["2"]!.name, "name2")

    }

    func testModel16() {
        print("Test Model - \(Model16.modelDescription())")

        //  Model
        var model: Model16?

        model = Model16(value: 10)
        XCTAssertEqual(try model?.toJSONString(), "{\"value\":10}")
        model?.title = "2"
        XCTAssertEqual(try model?.toJSONString(), "{\"value\":2}")

        var string = "{\"value\":2}"
        model = try? Model16(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.value, 2)
        XCTAssertEqual(model!.title, "2")

        string = "{\"value\":2,\"title\":\"100\"}"
        model = try? Model16(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.value, 2)
        XCTAssertEqual(model!.title, "2")
    }

    func testModel17() {
        print("Test Model - \(Model17.modelDescription())")

        //  Model
        var model: Model17?

        model = Model17()
        XCTAssertEqual(try model?.toJSONString(), "{\"model\":{}}")
        model?.model.name = "model13"
        XCTAssertEqual(try model?.toJSONString(), "{\"model\":{\"name\":\"model13\"}}")
        model?.model.model = Model0(age: 12, name: "model0")
        XCTAssertEqual(try model?.toJSONString(), "{\"model\":{\"model\":{\"age\":12,\"name\":\"model0\"},\"name\":\"model13\"}}")

    }

    func testModel18() {
        print("Test Model - \(Model18.modelDescription())")

        //  Model
        var model: Model18?

        model = Model18()
        model?.age = 10
        model?.fakeAge = 20
        XCTAssertEqual(try model?.toJSONString(), "{\"age\":10}")
        model?.fakeAge = 100
        XCTAssertEqual(try model?.toJSONString(), "{\"age\":10}")

        var string = "{\"age\":2}"
        model = try? Model18(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.age, 2)
        XCTAssertEqual(model!.fakeAge, 0)

        string = "{\"age\":2,\"fakeAge\":2}"
        model = try? Model18(fromString: string)
        XCTAssertNotNil(model)
        XCTAssertEqual(model!.age, 2)
        XCTAssertEqual(model!.fakeAge, 0)
    }

    func testParseFromArray() {
        var array = [Model0]()

        1.upto(3) { (idx) in
            array.append(Model0(age: idx, name: "name\(idx)"))
        }

        XCTAssertEqual(try array.toJSONString(), "[{\"age\":1,\"name\":\"name1\"},{\"age\":2,\"name\":\"name2\"},{\"age\":3,\"name\":\"name3\"}]")

        let string = "[{\"age\":1,\"name\":\"name1\"},{\"age\":2,\"name\":\"name2\"},{\"age\":3,\"name\":\"name3\"}]"

        let models: [Model0]? = try? CodableJSON.parse(fromString: string)
        XCTAssertNotNil(models)
        XCTAssertEqual(models!.count, 3)

        models?.forEachWithIndex { (index, model) in
            XCTAssertEqual(model.age, index + 1)
        }
    }

    func testParseFromDictionary() {
        var dictionary = [String: Model0]()

        1.upto(3) { (idx) in
            dictionary[idx.toS()] = Model0(age: idx, name: "name\(idx)")
        }

        XCTAssertEqual(try dictionary.toJSONString(), "{\"1\":{\"age\":1,\"name\":\"name1\"},\"2\":{\"age\":2,\"name\":\"name2\"},\"3\":{\"age\":3,\"name\":\"name3\"}}")

        let string = "{\"1\":{\"age\":1,\"name\":\"name1\"},\"2\":{\"age\":2,\"name\":\"name2\"},\"3\":{\"age\":3,\"name\":\"name3\"}}"

        let models: [String: Model0]? = try? CodableJSON.parse(fromString: string)
        XCTAssertNotNil(models)
        XCTAssertEqual(models!.count, 3)

        models?.forEach { (key, model) in
            XCTAssertEqual(model.name, "name\(key)")
        }
    }

    func testParseFromArrayAndDictionary() {
        var dictionary = [String: [Model0]]()

        1.upto(3) { (idx) in
            dictionary[idx.toS()] = [Model0(age: idx, name: "name\(idx)"), Model0(age: idx, name: "name\(idx)")]
        }

        XCTAssertEqual(try dictionary.toJSONString(), "{\"1\":[{\"age\":1,\"name\":\"name1\"},{\"age\":1,\"name\":\"name1\"}],\"2\":[{\"age\":2,\"name\":\"name2\"},{\"age\":2,\"name\":\"name2\"}],\"3\":[{\"age\":3,\"name\":\"name3\"},{\"age\":3,\"name\":\"name3\"}]}")

        let string = "{\"1\":[{\"age\":1,\"name\":\"name1\"},{\"age\":1,\"name\":\"name1\"}],\"2\":[{\"age\":2,\"name\":\"name2\"},{\"age\":2,\"name\":\"name2\"}],\"3\":[{\"age\":3,\"name\":\"name3\"},{\"age\":3,\"name\":\"name3\"}]}"

        let models: [String: [Model0]]? = try? CodableJSON.parse(fromString: string)
        XCTAssertNotNil(models)
        XCTAssertEqual(models!.count, 3)

        models?.forEach { (key, models) in
            XCTAssertEqual(models.count, 2)
            models.forEach { (model) in
                XCTAssertEqual(model.name, "name\(key)")
            }
        }
    }

    func testParseFromFlatterningDictionary() {
        let string = "{\"data\":[{\"age\":1,\"name\":\"name1\"},{\"age\":2,\"name\":\"name2\"}]}"

        let response: [String: [Model0]]? = try? CodableJSON.parse(fromString: string)
        XCTAssertNotNil(response)
        XCTAssertEqual(response!.count, 1)

        let models = response!["data"]
        XCTAssertNotNil(models)
        XCTAssertEqual(models!.count, 2)

        models?.forEachWithIndex { (index, model) in
            XCTAssertEqual(model.age, index + 1)
        }
    }
}
