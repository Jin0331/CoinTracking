//
//  FavoriteCollectionViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/4/24.
//

import Foundation

class FavoriteCollectionViewModel {
    
    private let repository = RealmRepository()
    
    var favorite : Observable<Market?> = Observable(nil)
    
    var reloadCollectionViewTrigger : Observable<Void?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
    }
    
}
