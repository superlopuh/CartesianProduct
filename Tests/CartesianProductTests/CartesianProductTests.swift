//
//  CartesianProductTests.swift
//  CartesianProduct
//
//  Created by Sasha Lopoukhine on 08/05/2017.
//  Copyright © 2017 CartesianProduct. All rights reserved.
//

import Foundation
import XCTest
import CartesianProduct

class CartesianProductTests: XCTestCase {

    func testEmpty() {
        let sequence: [[Int]] = []
        let product = sequence.cartesianProduct()
        XCTAssert(product.isEmpty)
    }

    func testOne() {
        let sequence: [[Int]] = [[1, 2, 3]]
        let product: [[Int]] = sequence.cartesianProduct()
        XCTAssertEqual(1, product.count)
        XCTAssert(product[0] == sequence[0])
    }

    func testTwo() {
        let sequence: [[String]] = [["1", "2", "3"], ["A", "B", "C"]]
        let product: [[String]] = sequence.cartesianProduct()
        let expected: [[String]] = [
            ["1", "A"], ["1", "B"], ["1", "C"],
            ["2", "A"], ["2", "B"], ["2", "C"],
            ["3", "A"], ["3", "B"], ["3", "C"],
        ]
        print(product)
        XCTAssertEqual(9, product.count)
        guard 9 == product.count else { return }
        for index in 0 ..< 9 {
            XCTAssertEqual(expected[index], product[index])
        }
    }

    func testThree() {
        let sequence: [[String]] = [["0", "1"], ["A", "B"], ["X", "Y"]]
        let product: [[String]] = sequence.cartesianProduct()
        let expected: [[String]] = [
            ["0", "A", "X"], ["0", "A", "Y"],
            ["0", "B", "X"], ["0", "B", "Y"],
            ["1", "A", "X"], ["1", "A", "Y"],
            ["1", "B", "X"], ["1", "B", "Y"],
        ]
        print(product)
        XCTAssertEqual(8, product.count)
        guard 8 == product.count else { return }
        for index in 0 ..< 8 {
            XCTAssertEqual(expected[index], product[index])
        }
    }

    static var allTests = [
        ("testEmpty", testEmpty),
        ("testOne", testOne),
        ("testTwo", testTwo),
        ("testThree", testThree),
    ]
}
