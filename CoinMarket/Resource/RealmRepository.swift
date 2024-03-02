//
//  RealmRepository.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    
    private let realm = try! Realm()
    
    func realmLocation() {
        print(realm.configuration.fileURL!)
    }
    
    
    //MARK: - Create
    
    // CREATE
    func createItem<T:Object>(_ item : T) {
        
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create")
            }
        } catch {
            print(error)
        }
    }
    
    // CREATE OR UPDATE
    ////  Search API
    func searchCreateOrUpdateItem(coinID : String, coinName : String,
                                  conSymbol : String, rank : Int?,
                                  large : String) {
        do {
            try realm.write {
                realm.create(Search.self, value: ["coinID": coinID, "coinName":coinName,
                                                  "conSymbol": conSymbol,"rank" : rank,
                                                  "large": large,"upDate":Date()
                                                 ], update: .modified) }
        } catch {
            print(error)
        }
    }
    
    //// Market API
    func searchCreateOrUpdateItem(coinID : String, coinName : String,
                                  conSymbol : String, symbolImage : String,
                                  currentPrice : Double, lastUpdated : Date,
                                  change : CoinChange?, sparkline_in_7d : [Double]) {
        do {
            try realm.write {
                realm.create(Market.self, value: ["coinID": coinID,
                                                  "coinName":coinName,
                                                  "conSymbol": conSymbol,
                                                  "symbolImage": symbolImage,
                                                  "currentPrice": currentPrice,
                                                  "lastUpdated" : lastUpdated,
                                                  "change" : change,
                                                  "sparkline_in_7d" : sparkline_in_7d,
                                                  "upDate":Date()
                                                 ], update: .modified) }
        } catch {
            print(error)
        }
    }
    
    func createEmbeddedItem(_ data : MarketCoin) -> CoinChange {
        
        return CoinChange(perprice_change_percentage_24h: data.priceChangePercentage24H,
                          low_24h: data.low24H,
                          high_24h: data.high24H,
                          ath: data.ath,
                          ath_date: data.athDate.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSz")!,
                          atl: data.atl,
                          atl_date: data.atlDate.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSz")!)
        
    }
    
    func createRelationSearchWithMarket(coinID : String) {
        
        
        
        guard let currentSearchTable = fetchSearchItem(coinID: coinID)?.first else { return }
        let currentMarketTable = fetchMarketItem(coinID: coinID)
        
        do {
            try realm.write {
                currentSearchTable.market.removeAll()
                currentSearchTable.market.append(currentMarketTable)
            }
        } catch {
            print(error)
        }
    }
    
    
    //MARK: - Read
    // READ
    func fetchSearchItem() -> [Search] {
        let result = realm.objects(Search.self)
        
        return Array(result)
    }
    
    func fetchSearchItem(coinID : String) -> Results<Search>? {
        let result = realm.objects(Search.self)
            .where {
                $0.coinID == coinID }
        
        return result
    }
    
    func searchFetchItemFilterdSorted(coinID : String) -> [Search] {
        
        let result = realm.objects(Search.self)
            .filter("coinID CONTAINS[cd] %@ AND rank != -999", coinID)
            .sorted(byKeyPath: "rank", ascending: true)
            .prefix(25)
        
        return Array(result)
    }
    
    //    func fetchMarketItem(coinID : String) -> Results<Market> {
    //        let result = realm.objects(Market.self)
    //            .where {
    //                $0.coinID == coinID }
    //
    //        return result
    //    }
    
    func fetchMarketItem(coinID : String) -> Market {
        let result = realm.objects(Market.self).where { $0.coinID == coinID }
        
        return Array(result)[0]
    }
    
    func fetchSearchItemWithFavorite() -> [Search] {
        let result = realm.objects(Search.self).where {$0.favorite == true }
        
        return Array(result)
    }
    
    func fetchMultipleMarketItem(coinIDs : String) -> [Market] { // ,구분자로 된 String
        let searchFavoriteTrue = fetchSearchItemWithFavorite()
        
        return searchFavoriteTrue.map { return $0.market[0] }
    }
    
    //MARK: - Update
    // FAVORITE TOGGLE
    func updateFavoriteToggle(_ coinID : String, _ favorite : Bool) {
        
        do {
            try realm.write {
                realm.create(Search.self, value: ["coinID": coinID, "favorite" : favorite, "upDate":Date()], update: .modified) }
        } catch {
            print(error)
        }
    }
    
    
    
    
}
