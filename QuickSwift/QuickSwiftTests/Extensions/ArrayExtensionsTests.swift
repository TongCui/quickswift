//
//  ArrayExtensionsTests.swift
//  QuickSwift_Tests
//
//  Created by tcui on 24/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class ArrayExtensionsTests: XCTestCase {

    func testSum() {
        var array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.sum(), 15)

        array = [Int]()
        XCTAssertEqual(array.sum(), 0)
    }

    func testProduct() {
        var array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.product(), 120)

        array = []
        XCTAssertEqual(array.product(), 0)

        array = [1]
        XCTAssertEqual(array.product(), 1)

        array = [0]
        XCTAssertEqual(array.product(), 0)
    }

    func testAverage() {
        var array = [Double]()

        array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.average(), 3)

        array = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(array.average(), 3.5)

        array = []
        XCTAssertEqual(array.average(), 0)
    }

    func testArrayPushPop() {
        var array = [Int]()
        var element: Int?

        element = array.pop()
        XCTAssertEqual(element, nil)
        XCTAssertEqual(array, [])

        array.push(1)
        XCTAssertEqual(array, [1])

        array.push(2)
        XCTAssertEqual(array, [1, 2])

        element = array.pop()
        XCTAssertEqual(element, 2)
        XCTAssertEqual(array, [1])

        element = array.pop()
        XCTAssertEqual(element, 1)
        XCTAssertEqual(array, [])
    }

    func testArrayShiftUnShift() {
        var array = [Int]()
        var element: Int?

        element = array.unshift()
        XCTAssertEqual(element, nil)
        XCTAssertEqual(array, [])

        array.shift(1)
        XCTAssertEqual(array, [1])

        array.shift(2)
        XCTAssertEqual(array, [2, 1])

        element = array.unshift()
        XCTAssertEqual(element, 2)
        XCTAssertEqual(array, [1])

        element = array.unshift()
        XCTAssertEqual(element, 1)
        XCTAssertEqual(array, [])
    }

    func testArraySafeMethods() {
        var array = [1, 2, 3, 4, 5]

        array.safeRemove(at: 10)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        array.safeRemove(at: 3)
        XCTAssertEqual(array, [1, 2, 3, 5])

        array = [1, 2, 3, 4, 5]
        array.safeInsert(6, at: 10)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        array.safeInsert(6, at: 3)
        XCTAssertEqual(array, [1, 2, 3, 6, 4, 5])

        array = [1, 2, 3, 4, 5]
        array.safeSwapAt(4, 10)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        array.safeSwapAt(0, 1)
        XCTAssertEqual(array, [2, 1, 3, 4, 5])
    }

    func testArrayElementMethods() {
        var array = [1, 2, 3, 4, 5]

        array.removeElement(10)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        array.removeElement(1)
        XCTAssertEqual(array, [2, 3, 4, 5])

        array = [1, 2, 3, 4, 5, 2, 3, 4]
        array.removeElement(3)
        XCTAssertEqual(array, [1, 2, 4, 5, 2, 4])

        array = [1, 2, 3, 4, 5, 2, 3, 4]
        array.removeElements([1, 2, 3])
        XCTAssertEqual(array, [4, 5, 4])

        array = [1, 2, 3, 4, 5, 2, 3, 4]
        array.removeElements([])
        XCTAssertEqual(array, [1, 2, 3, 4, 5, 2, 3, 4])

        array = [1, 2, 3, 4, 5, 2, 3, 4]
        array.removeElements([10, 11])
        XCTAssertEqual(array, [1, 2, 3, 4, 5, 2, 3, 4])

        array = [1, 2, 3, 4, 5]
        array.swapElements(4, 10)
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        array.swapElements(3, 5)
        XCTAssertEqual(array, [1, 2, 5, 4, 3])

        array = [1, 2, 3, 4, 5]
        XCTAssertTrue(array.contains([1]))
        XCTAssertTrue(array.contains([1, 2]))
        XCTAssertFalse(array.contains([1, 10]))
        XCTAssertTrue(array.contains([]))

        array = [1, 2, 3, 1, 4, 5]
        XCTAssertEqual(array.indexes(of: 1), [0, 3])
        XCTAssertEqual(array.indexes(of: 10), [])
        XCTAssertEqual(array.indexes(of: 5), [5])
    }

    func testEqualOperator() {
        var array1 = [[1, 2], [3, 4], [5]]
        var array2 = [[1, 2], [3, 4], [5]]
        XCTAssertTrue(array1.elementsEqual(array2))

        array1 = [[1, 2], [3, 4]]
        array2 = [[1, 2], [3, 4], [5]]
        XCTAssertFalse(array1.elementsEqual(array2))

        array1 = [[1, 2], [3, 4, 5]]
        array2 = [[1, 2], [3, 4]]
        XCTAssertFalse(array1.elementsEqual(array2))

        array1 = []
        array2 = []
        XCTAssertTrue(array1.elementsEqual(array2))
    }

    func testArrayConditions() {
        let array = [1, 2, 3, 4, 5]
        var res: Bool = false

        res = array.all { $0 > 0 }
        XCTAssertEqual(res, true)
        res = array.all { $0 > 1 }
        XCTAssertEqual(res, false)

        res = array.any { $0 > 0 }
        XCTAssertEqual(res, true)
        res = array.any { $0 > 1 }
        XCTAssertEqual(res, true)
        res = array.any { $0 > 10 }
        XCTAssertEqual(res, false)

        res = array.none { $0 > 0 }
        XCTAssertEqual(res, false)
        res = array.none { $0 > 1 }
        XCTAssertEqual(res, false)
        res = array.none { $0 > 10 }
        XCTAssertEqual(res, true)

        XCTAssertEqual(array.reject { $0 < 3 }, [3, 4, 5])
    }

    func testArrayRunLoop() {
        let array = [1, 2, 3, 4, 5]
        var temp = [Int]()

        array.forEachWithIndex { (index, element) in
            XCTAssertEqual(array[index], element)
            temp.append(element)
        }
        XCTAssertEqual(temp, [1, 2, 3, 4, 5])

        temp = []
        array.forEach(where: { $0 < 3 }) { element in
            temp.append(element)
        }
        XCTAssertEqual(temp, [1, 2])

        temp = []
        array.forEachReversed { temp.append($0) }
        XCTAssertEqual(temp, [5, 4, 3, 2, 1])

        temp = []
        array.forEachReversedWithIndex { (index, element) in
            temp.append(element)
        }
        XCTAssertEqual(temp, [5, 4, 3, 2, 1])
    }

    func testArrayEquality() {
        var lhs = [1, 2, 3, 4, 5]
        var rhs = [1, 2, 3, 4, 5]
        XCTAssertEqual(lhs == rhs, true)

        lhs = [1, 2, 3, 4, 5]
        rhs = [1, 2, 3, 4]
        XCTAssertEqual(lhs == rhs, false)

        lhs = []
        rhs = []
        XCTAssertEqual(lhs == rhs, true)
    }

    func testArrayGroupBySize() {
        var array = [Int]()
        var res = [[Int]]()
        var expected = [[Int]]()

        array = []
        res = array.group(bySize: 0)
        expected = []
        XCTAssertTrue(res.elementsEqual(expected))

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 0)
        expected = []
        XCTAssertTrue(res.elementsEqual(expected))

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 1)
        expected = [[1], [2], [3], [4], [5]]
        XCTAssertTrue(res.elementsEqual(expected))

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 2)
        expected = [[1, 2], [3, 4], [5]]
        XCTAssertTrue(res.elementsEqual(expected))

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 3)
        expected = [[1, 2, 3], [4, 5]]
        XCTAssertTrue(res == expected)

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 5)
        expected = [[1, 2, 3, 4, 5]]
        XCTAssertTrue(res == expected)

        array = [1, 2, 3, 4, 5]
        res = array.group(bySize: 8)
        expected = [[1, 2, 3, 4, 5]]
        XCTAssertTrue(res == expected)
    }

    func testArrayGroupByKey() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var res = [String: [Int]]()
        var expected = [String: [Int]]()

        //  TODO

        res = array.group { ($0 % 2 == 0) ?  "even" : "odd" }
        expected = ["even": [2, 4, 6, 8, 10], "odd": [1, 3, 5, 7, 9]]
        print("\(res) \(expected)")

        res = array.group { element in
            switch element % 3 {
            case 0: return "0"
            case 1: return "1"
            case 2: return "2"
            default: return ""
            }
        }
        expected = ["0": [3, 6, 9], "1": [1, 4, 7, 10], "2": [2, 5, 8]]
        print("\(res) \(expected)")
    }

    func testArrayUnique() {
        var array = [1, 2, 3, 4, 4, 5, 5, 6, 6, 7]

        XCTAssertEqual(array.uniqued(), [1, 2, 3, 4, 5, 6, 7])
        array.unique()
        XCTAssertEqual(array, [1, 2, 3, 4, 5, 6, 7])

        array = []
        XCTAssertEqual(array.uniqued(), [])
        array.unique()
        XCTAssertEqual(array, [])
    }

    func testArrayShuffle() {
        var array = [1, 2, 3, 4, 5]

        XCTAssertEqual(array.shuffled().sorted(), [1, 2, 3, 4, 5].sorted())
        array.shuffle()
        XCTAssertEqual(array.sorted(), [1, 2, 3, 4, 5].sorted())

        array = []
        XCTAssertEqual(array.shuffled(), [])
        array.shuffle()
        XCTAssertEqual(array, [])
    }
}
