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
    @Persisted var favoriteRank : Int?
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
    @Persisted var symbolImage : String
    @Persisted var currentPrice : Double
    @Persisted var lastUpdated : Date
    @Persisted var change : CoinChange?
    @Persisted var sparkline_in_7d : List<Double>
    @Persisted var upDate : Date
    @Persisted var regDate : Date
    
    @Persisted(originProperty: "market") var search : LinkingObjects<Search>
    
    convenience init(coinID: String, coinName: String, conSymbol: String, symbolImage : String, currentPrice: Double, lastUpdated: Date, sparkline_in_7d: List<Double>) {
        self.init()
        self.coinID = coinID
        self.coinName = coinName
        self.conSymbol = conSymbol
        self.symbolImage = symbolImage
        self.currentPrice = currentPrice
        self.lastUpdated = lastUpdated
        self.sparkline_in_7d = sparkline_in_7d
        self.upDate = Date()
        self.regDate = Date()
    }
    
    var symbolImageURL : URL {
        get {
            return URL(string: symbolImage) ?? URL(string: "")!
        }
    }
    
}

class CoinChange : EmbeddedObject {
    @Persisted var perprice_change_percentage_24h : Double
    @Persisted var low_24h : Double
    @Persisted var high_24h : Double
    @Persisted var ath : Double
    @Persisted var ath_date : Date
    @Persisted var atl : Double
    @Persisted var atl_date : Date
    
    convenience init(perprice_change_percentage_24h: Double, low_24h: Double, high_24h: Double, ath: Double, ath_date: Date, atl: Double, atl_date: Date) {
        self.init()
        self.perprice_change_percentage_24h = perprice_change_percentage_24h
        self.low_24h = low_24h
        self.high_24h = high_24h
        self.ath = ath
        self.ath_date = ath_date
        self.atl = atl
        self.atl_date = atl_date
    }
}
