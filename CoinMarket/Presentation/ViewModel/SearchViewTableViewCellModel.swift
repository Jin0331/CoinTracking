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
    
    var favoriteButtonClicked : Observable<Void?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool> = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        // cell에 접근할 때, ID를 추출하여 favorite status 변경
        inputCoinID.bind { value in
            guard let value = value else { return }
            let item = self.repository.fetchItem(coinID: value).first!
            
            self.outputFavoriteBool.value = item.favorite
        }
        
        // favorite button이 클릭되었을 때, realm update 및
        favoriteButtonClicked.bind { _ in
            
            guard let coinID = self.inputCoinID.value else { return }
            
            self.repository.updateFavoriteToggle(coinID, self.outputFavoriteBool.value)
        }
        
    }
}
