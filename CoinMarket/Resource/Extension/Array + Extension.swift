//
//  Array + Extension.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import Foundation

extension Array {
    func splitIntoSubarrays(ofSize size: Int) -> [[(Int, Element)]] {
        return stride(from: 0, to: count, by: size).map { startIndex in
            let endIndex = Swift.min(startIndex + size, count)
            let subarray = Array(self[startIndex..<endIndex])
            return subarray.enumerated().map { (index, element) in
                (startIndex + index, element)
            }
        }
    }
}
