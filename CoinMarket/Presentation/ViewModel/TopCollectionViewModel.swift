//
//  TopCollectionViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import Foundation
import RealmSwift

class TopCollectionViewModel {
    
    private let repository = RealmRepository()
    
    var coinTrend : Observable<[(Int,CoinTrend)]?> = Observable(nil)
    var nftTrend : Observable<[(Int, NFTTrend)]?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
    }
    
}
