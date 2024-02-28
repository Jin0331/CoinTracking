//
//  SearchViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

class SearchViewModel {
    
    let repository = RealmRepository()
    
    var inputCoinID : Observable<String?> = Observable(nil)
    var outputData : Observable<[Search]?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            guard let value, !value.isEmpty else { print("빈 문자들엉");return }
            
            // API request -> realm Create or Update
            CoinAPIManager.shared.callRequest(type: SearchModel.self, api: .search(coinName: value)) { response, error in
                if let error = error {
                    //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨
                } else {
                    guard let response = response else { return }
                    response.coins.forEach { item in
                        self.repository.searchCreateOrUpdateItem(coinID: item.id, coinName: item.name,conSymbol: item.symbol, rank: item.marketCapRank, thumb: item.thumb)
                    }
                    self.repository.realmLocation()
                }
            }
            
            // fetch by keyword
            self.outputData.value = self.repository.searchFetchItemFilterdSorted(coinID: value)
        }
    }
}
