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
    var favoriteIDList : Observable<[Search]?> = Observable([])
    var outputFavorite : Observable<[Market]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        
        getCoinIDListTrigger.bind { value in
            self.favoriteIDList.value = self.repository.fetchSearchItemWithFavorite()
            self.extractCoinID(self.favoriteIDList.value)
        }
    }
    
    
    private func extractCoinID(_ data : [Search]?) {
        
        guard let data = data else { return }
        
        let coinID = data.map { return $0.coinID }.joined(separator: ",")
        print(coinID)
        
        CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: coinID)) { response, error in
            
            if let error = error {
                //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨 -> Realm 조회
                print("network Error")
                // output 설정
                //TODO: - multiple 조회
//                self.outputFavorite.value = self.repository.fetchMarketItem(coinID: coinID)
            } else {
                guard let response = response else { return }
                self.outputFavorite.value = response.map { data in
                    // embedd class
                    let embeddedItem = self.repository.createEmbeddedItem(data)
                    self.repository.searchCreateOrUpdateItem(coinID: data.id, coinName: data.name,
                                                             conSymbol: data.symbol,
                                                             symbolImage : data.symbolImage,
                                                             currentPrice: data.currentPrice,
                                                             lastUpdated: data.lastUpdated.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSz")!,
                                                             change: embeddedItem , sparkline_in_7d: data.sparklineIn7D.price)
                    self.repository.createRelationSearchWithMarket(coinID: data.id)
                    return self.repository.fetchMarketItem(coinID: data.id)
                }
            }
        }
        
        
        
        
    }
}
