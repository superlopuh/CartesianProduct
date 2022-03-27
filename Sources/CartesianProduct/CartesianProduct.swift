//
//  CartesianProduct.swift
//  CartesianProduct
//
//  Created by Sasha Lopoukhine on 08/05/2017.
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
    public var endIndex: Index { isEmpty ? startIndex : Index(collections.map(\.endIndex)) }
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

extension CartesianProduct: BidirectionalCollection where Collections.Element: BidirectionalCollection {

    public func formIndex(before i: inout Index) {
        guard i != endIndex else {
            // If end index, then decrement all indices.
            // This function can only be called if the collection is not empty, meaning that none of
            // the collections are empty, so this is safe.
            for (ci, c) in collections.enumerated() {
                c.formIndex(before: &i.indices[ci])
            }
            return
        }

        for (ci, c) in collections.enumerated() {
            guard i.indices[ci] == c.startIndex else {
                c.formIndex(before: &i.indices[ci])
                return
            }
            // Start of this collection, reset to last element and decrement next index.
            i.indices[ci] = c.index(before: c.endIndex)
        }

        fatalError("Attempting to decrement startIndex")
    }

    public func index(before i: Index) -> Index {
        var index = i
        formIndex(before: &index)
        return index
    }
}
