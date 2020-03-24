//
//  Collection+SafeIndex.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 07/02/2019.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
