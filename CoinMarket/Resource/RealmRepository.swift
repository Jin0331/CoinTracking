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
    
    // UPDATE
    func searchCreateOrUpdateItem(coinID : String, coinName : String,
                                  conSymbol : String, rank : Int?,
                                  thumb : String, priority : String?) {
        do {
            try realm.write {
                realm.create(Search.self,
                             value: ["coinID": coinID,
                                     "coinName":coinName,
                                     "conSymbol": conSymbol,
                                     "rank" : rank,
                                     "thumb": thumb
                                    ],
                             update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    
}
