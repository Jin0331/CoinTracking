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
    var fetchSearchItemWithFavoriteTrigger : Observable<Void?> = Observable(nil)
    var refreshControllTrigger : Observable<Void?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        print(#function, "Favorite")
        
        fetchSearchItemWithFavoriteTrigger.bind { _ in
            self.favoriteIDList.value = self.repository.fetchSearchItemWithFavorite()
        }
        
        getCoinIDListTrigger.bind { value in
            self.fetchSearchItemWithFavoriteTrigger.value = ()
            self.extractCoinID(self.favoriteIDList.value)
        }
    }
    
    
    func updateFavoriteRank(targetCoinID : String, source : IndexPath, destination : IndexPath) {
        
        repository.updateFavoriteRankSwitching(targetCoinID, source, destination)

    }
    
    private func extractCoinID(_ data : [Search]?) {
        
        guard let data = data, !data.isEmpty else {
            print("모든 즐겨찾기값 해제됨")
            self.outputFavorite.value = self.repository.fetchMultipleMarketItem()
            return
        }

        let coinID = data.map { return $0.coinID }.joined(separator: ",")
        print(coinID, "즐겨찾기 화면이야?")
        
        CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: coinID)) { response, error in
            
            if let error {
                //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨 -> Realm 조회
                print("network Error")
                // output 설정
                //TODO: - multiple 조회 - 완료
                //TODO: - Toast 띄워야 됨.
                self.outputFavorite.value = self.repository.fetchMultipleMarketItem()
            } else {
                guard let response = response else { return }
                
                // output
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
                
                // output sort by favorite rank
                self.outputFavorite.value.sort {
                    ($0.search.first?.favoriteRank!)! < ($1.search.first?.favoriteRank!)!
                }
            }
        }
    }
    
}



