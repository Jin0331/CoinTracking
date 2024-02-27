//
//  CommonCoinModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import Foundation


//MARK: - Search /  SearchTrending 동시에 사용. 이에 따라, 공통되지 않는 항목에 대한 Default 값의 지정 필요
struct SearchCoinModel : Decodable {
    let coins : [Coins]
//    let nfts : [NFTs]
}

struct Coins : Decodable {
    let item : CoinsItems
}

struct CoinsItems : Decodable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let small: String
    let data: CoinData
    
    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol, small, data
    }
    
    //TODO: - Nil 예외처리
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.coinID = (try? container.decode(Int.self, forKey: .coinID)) ?? -999
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.small = try container.decode(String.self, forKey: .small)
        self.data = (try? container.decode(CoinData.self, forKey: .data)) ?? CoinData(price: "", priceChangePercentage24H: [:], sparkline: "")
    }
    
}

struct CoinData : Decodable {
    let price : String
    let priceChangePercentage24H: [String: Double]
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24H = "price_change_percentage_24h"
        case sparkline
    }
}

struct NFTs: Decodable {
    let id, name, symbol: String
    let thumb: String
    let data: NFTData
}

struct NFTData: Decodable {
    let floorPrice, floorPriceInUsd24HPercentageChange : String
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case sparkline
    }
}


//MARK: - Market
struct MarketCoinModel : Decodable {
    let id, symbol, name: String
    let image: String
    let currentPrice, high24H, low24H: Double
    let priceChangePercentage24H: Double
    let ath: Int
    let athDate: String
    let atl: Int
    let atlDate, lastUpdated: String
    let sparklineIn7D: SparklineIn7D

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Decodable {
    let price: [Double]
}
