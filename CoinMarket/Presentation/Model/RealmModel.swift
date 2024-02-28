//
//  RealmModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import Foundation
import RealmSwift

//MARK: - SearchTrend
//class SearchTrend : Object {
//    
//}

class Search : Object {
    @Persisted(primaryKey: true) var coinID : String // 중복되지 않는 coin의 아이디
    @Persisted var coinName : String
    @Persisted var conSymbol : String
    @Persisted var rank : Int?
    @Persisted var large : String // 썸네일 이미지
    @Persisted var favorite : Bool
    @Persisted var upDate : Date
    @Persisted var regDate : Date
    
    @Persisted var market : List<Market>
    
    convenience init(coinID: String, coinName: String, conSymbol: String, rank: Int?, large: String) {
        self.init()
        self.coinID = coinID
        self.coinName = coinName
        self.conSymbol = conSymbol
        self.rank = rank
        self.large = large
        self.favorite = false
        self.upDate = Date()
        self.regDate = Date()
    }
    
    // 연산 property
    var largeURL : URL {
        get {
            return URL(string: large) ?? URL(string: "")!
        }
    }
}

class Market : Object {
    @Persisted(primaryKey: true) var coinID : String
    @Persisted var coinName : String
    @Persisted var conSymbol : String
    @Persisted var currentPrice : Double
    @Persisted var lastUpdated : Date
    @Persisted var change : CoinChange?
    @Persisted var sparkline_in_7d : List<Double>
    @Persisted var regDate : Date
    
    @Persisted(originProperty: "market") var search : LinkingObjects<Search>
}

class CoinChange : EmbeddedObject {
    @Persisted var perprice_change_percentage_24h : Double
    @Persisted var low_24h : Double
    @Persisted var high_24h : Double
    @Persisted var ath : Double
    @Persisted var ath_date : Date
    @Persisted var atl : Double
    @Persisted var atl_date : Date
}
