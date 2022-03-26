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

extension CartesianProduct: Collection {

    public typealias Element = [Collections.Element.Element]

    public struct Index: Comparable {

        var indices: [Collections.Element.Index]

        fileprivate init(_ indices: [Collections.Element.Index]) {
            self.indices = indices
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            assert(lhs.indices.count == rhs.indices.count)
            for (l, r) in zip(lhs.indices, rhs.indices) {
                if l < r {
                    return true
                } else if r < l {
                    return false
                }
            }
            return false
        }
    }

    public var startIndex: Index { Index(collections.map(\.startIndex)) }
    public var endIndex: Index { Index(collections.map(\.endIndex)) }
    public var count: Int { isEmpty ? 0 : collections.reduce(1) { $0 * $1.count } }
    public var isEmpty: Bool { collections.isEmpty || collections.contains(where: \.isEmpty) }

    public func formIndex(after i: inout Index) {
        for (ci, c) in collections.enumerated() {
            c.formIndex(after: &i.indices[ci])
            guard i.indices[ci] == c.endIndex else { return }
            // Reset this index, and advance
            i.indices[ci] = c.startIndex
        }

        i = endIndex
    }

    public func index(after i: Index) -> Index {
        var index = i
        formIndex(after: &index)
        return index
    }

    public subscript(position: Index) -> [Collections.Element.Element] {
        zip(collections, position.indices).map { $0[$1] }
    }
}
