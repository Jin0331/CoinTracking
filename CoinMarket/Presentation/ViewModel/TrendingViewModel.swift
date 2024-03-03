//
//  TrendingViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import Foundation

class TrendingViewModel {
    
    private let repository = RealmRepository()
    
    var outputFavorite : Observable<[Market]> = Observable([])
//    var outputTrending : Observable<[T]
    
    var fetchFavoriteTrigger : Observable<Void?> = Observable(nil)
    
    init () {
        transform()
    }
    
    private func transform() {
        
        print(#function, " - Trending")
        
        fetchFavoriteTrigger.bind { _ in
            DispatchQueue.main.async {
                self.outputFavorite.value = self.repository.fetchMultipleMarketItem()
            }
        }
        
    }
    
    
    
    
    
    // mainTableView 관련
    enum SettingType: CaseIterable {
        case favorite
        case coin
        case nft
        
        
        static func numberOfSections() -> Int {
            return self.allCases.count
        }
        
        var title: String {
            switch self {
            case .favorite:
                return "My Favorite"
            case .coin:
                return "Top15 Coin"
            case .nft:
                return "Top7 NFT"
            }
        }
        
        static func getSection(_ section: Int) -> SettingType {
            return self.allCases[section]
        }
    }
    
    
    
}
