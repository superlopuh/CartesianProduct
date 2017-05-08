//
//  CartesianProduct.swift
//  CartesianProduct
//
//  Created by Sasha Lopoukhine on 08/05/2017.
//  Copyright © 2017 CartesianProduct. All rights reserved.
//

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

extension Sequence where Iterator.Element: Sequence {

    public func cartesianProduct() -> [[Iterator.Element.Iterator.Element]] {
        return CartesianProduct.cartesianProduct(arrays: self.map { Array($0) })
    }
}
