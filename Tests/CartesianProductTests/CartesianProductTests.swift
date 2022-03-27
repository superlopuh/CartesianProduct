import XCTest
@testable import CartesianProduct

class CartesianProductTests: XCTestCase {

    func testEmpty() {
        let sequence: [[Int]] = []
        let product = sequence.cartesianProduct()
        XCTAssert(product.isEmpty)
    }

    func testOne() {
        let sequence: [[Int]] = [[1, 2, 3]]
        let product = sequence.cartesianProduct()
        XCTAssertEqual(3, product.count)
    }

    func testTwo() {
        let sequence: [[String]] = [["1", "2", "3"], ["A", "B", "C"]]
        let product = sequence.cartesianProduct()
        let expected: [[String]] = [
            ["1", "A"], ["2", "A"], ["3", "A"],
            ["1", "B"], ["2", "B"], ["3", "B"],
            ["1", "C"], ["2", "C"], ["3", "C"],
        ]
        XCTAssertEqual(product.count, expected.count)
    }

    func testThree() {
        let sequence: [[String]] = [["0", "1"], ["A", "B"], ["X", "Y"]]
        let product = sequence.cartesianProduct()
        let expected: [[String]] = [
            ["0", "A", "X"], ["1", "A", "X"],
            ["0", "B", "X"], ["1", "B", "X"],
            ["0", "A", "Y"], ["1", "A", "Y"],
            ["0", "B", "Y"], ["1", "B", "Y"],
        ]
        XCTAssertEqual(product.count, expected.count)
        XCTAssertEqual(Array(product), expected)
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
        }
    }
}
