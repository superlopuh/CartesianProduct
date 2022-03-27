import XCTest
@testable import CartesianProduct

class CartesianProductTests: XCTestCase {

    func testArraysOfInts() {
        let testCases: [([[Int]], [[Int]])] = [
            ([], []),
            ([[], []], []),
            ([[0]], [[0]]),
            ([[0], []], []),
            ([[0, 1]], [[0], [1]]),
            ([[0, 1], [2, 3]], [[0, 2], [1, 2], [0, 3], [1, 3]]),
            ([[0, 1], [2, 3], [4, 5]], [
                [0, 2, 4], [1, 2, 4],
                [0, 3, 4], [1, 3, 4],
                [0, 2, 5], [1, 2, 5],
                [0, 3, 5], [1, 3, 5],
            ]),
        ]

        for (sequence, expected) in testCases {
            let product = sequence.cartesianProduct()
            XCTAssertEqual(product.count, expected.count)
            XCTAssertEqual(product.isEmpty, product.isEmpty)
            XCTAssertEqual(Array(product), expected)
            if product.isEmpty {
                XCTAssertEqual(product.startIndex, product.endIndex)
            } else {
                XCTAssertLessThan(product.startIndex, product.endIndex)
            }
        }
    }

    func testRange() {
        let testCases: [([Range<Int>], [[Int]])] = [
            ([], []),
            ([0 ..< 2], [[0], [1]]),
            ([0 ..< 2, 3 ..< 5], [[0, 3], [1, 3], [0, 4], [1, 4]]),
        ]

        for (sequence, expected) in testCases {
            let product = sequence.cartesianProduct()
            XCTAssertEqual(product.count, expected.count)
            XCTAssertEqual(product.isEmpty, product.isEmpty)
            XCTAssertEqual(Array(product), expected)
            if product.isEmpty {
                XCTAssertEqual(product.startIndex, product.endIndex)
            } else {
                XCTAssertLessThan(product.startIndex, product.endIndex)
            }
        }
    }
}
