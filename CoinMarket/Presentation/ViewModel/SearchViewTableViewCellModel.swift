//
//  SearchViewTableViewCellModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

class SearchViewTableViewCellModel {
    
    let repository = RealmRepository()
    
    var search : Observable<Search?> = Observable(nil)
    
    var inputCoinID : Observable<String?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool> = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            guard let value = value else { return }
            var item = self.repository.fetchItem(coinID: value).first!
            
            self.outputFavoriteBool.value = item.favorite
        }
        
    }
}
