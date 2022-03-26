//
//  CartesianProduct.swift
//  CartesianProduct
//
//  Created by Sasha Lopoukhine on 08/05/2017.
//  Copyright © 2017 CartesianProduct. All rights reserved.
//

public struct CartesianProduct<Collections: Collection> where Collections.Element: Collection {
    let collections: Collections

    fileprivate init(collections: Collections) {
        self.collections = collections
    }
}

extension Collection where Element: Collection {

    public func cartesianProduct() -> CartesianProduct<Self> {
        return CartesianProduct(collections: self)
    }
}

extension CartesianProduct: Sequence {

    public typealias Element = [Collections.Element.Element]

    public struct Iterator: IteratorProtocol {

        let collections: Collections
        var indices: [Collections.Element.Index]
        var endIteration = false

        fileprivate init(collections: Collections) {
            self.collections = collections
            self.indices = collections.map(\.startIndex)
        }

        public mutating func next() -> Element? {
            guard !endIteration else { return nil }
            guard !indices.isEmpty else {
                endIteration = true
                return []
            }

            let result = zip(collections, indices).map { $0[$1] }

            for (i, c) in collections.enumerated() {
                c.formIndex(after: &indices[i])
                guard indices[i] == c.endIndex else { return result }
                // Reset this index, and advance
                indices[i] = c.startIndex
            }

            // Means we have advanced every index of the collection past the end
            endIteration = true
            return result
        }
    }

    public func makeIterator() -> Iterator {
        Iterator(collections: collections)
    }
}

extension CartesianProduct {

    public var count: Int { collections.reduce(1) { $0 * $1.count } }
}

private func cartesianProduct<Element>(arrays: [[Element]]) -> [[Element]] {
    guard 1 < arrays.count else { return arrays }

    var result: [[Element]] = []
    var indices = Array<Int>(repeating: 0, count: arrays.count)

    whileLoop: while true {
        result.append(zip(arrays, indices).map { array, index in array[index] })

        forLoop: for index in (0 ..< arrays.count).reversed() {
            indices[index] += 1
            guard indices[index] == arrays[index].count else { break forLoop }
            guard 0 != index else { break whileLoop }
            indices[index] = 0
        }
    }

    return result
}

//extension Sequence where Iterator.Element: Sequence {
//
//    public func cartesianProduct() -> [[Iterator.Element.Iterator.Element]] {
//        return CartesianProduct.cartesianProduct(arrays: self.map { Array($0) })
//    }
//}
