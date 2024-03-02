//
//  FavoriteViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/2/24.
//

import Foundation

class FavoriteViewModel {
    
    private let repository = RealmRepository()
    
    var getCoinIDListTrigger : Observable<Void?> = Observable(nil)
    var favoriteIDList : Observable<[Search]> = Observable([])
    
    
    init() {
        transform()
    }
    
    private func transform() {
        
        getCoinIDListTrigger.bind { value in
            
            self.favoriteIDList.value = self.repository.fetchSearchItemWithFavorite()
            
            print(self.favoriteIDList.value)
        }
        
    }
}
