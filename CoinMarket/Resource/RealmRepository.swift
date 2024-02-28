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
                                  conSymbol : String, currentPrice : Double,
                                  lastUpdated : Date, change : CoinChange?,
                                  sparkline_in_7d : [Double]) {
        do {
            try realm.write {
                realm.create(Market.self, value: ["coinID": coinID,
                                                  "coinName":coinName,
                                                  "conSymbol": conSymbol,
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
    
    
    // READ
    func fetchItem() -> [Search] {
        let result = realm.objects(Search.self)
        
        return Array(result)
    }
    
    func fetchItem(coinID : String) -> Results<Search> {
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
