//
//  ChartViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

//MARK: - API request -> Search , Market Bind -> Query -> outputSepcific

class ChartViewModel {
    
    let repository = RealmRepository()
    
    var inputCoinID : Observable<String?> = Observable(nil)
    //    var outputCointSpecific : Observable
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            guard let value else { return }
            
            print(value, #function)
            
            CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: value)) { response, error in
                
                if let error = error {
                    //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨
                } else {
                    guard let response = response else { return }
                    guard let data = response.first else { return }
                    
                    // embedd class
                    let embeddedItem = self.repository.createEmbeddedItem(data)
                    self.repository.searchCreateOrUpdateItem(coinID: data.id, coinName: data.name, 
                                                             conSymbol: data.symbol,
                                                             currentPrice: data.currentPrice,
                                                             lastUpdated: data.lastUpdated.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSz")!,
                                                             change: embeddedItem , sparkline_in_7d: data.sparklineIn7D.price)
                    
                    // Search Table과 Relation 설정
                    self.repository.createRelationSearchWithMarket(coinID: value)
                }
            }
        }
    }
    
}
