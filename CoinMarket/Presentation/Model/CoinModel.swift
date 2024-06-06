//
//  CommonCoinModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import Foundation


//MARK: - Search-Trending
// 아래의 Coins가 하위 항목임
struct SearchTrendingModel : Decodable {
    let coins : [CoinsSearchTrending]
    let nfts : [NFTs]
}

struct CoinsSearchTrending : Decodable {
    let item : CoinsItems
}

//MARK: - Search
struct SearchModel : Decodable {
    let coins : [CoinsItems]
}


//MARK: - Search-Trending과 Search에서 공통적인 Model
struct CoinsItems : Decodable {
    let id: String
    let coinID: Int
    let name, symbol, small, large, thumb: String
    let marketCapRank : Int
    let data: CoinData
    
    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case marketCapRank = "market_cap_rank"
        case name, symbol, small, large, thumb, data
    }
    
    //TODO: - Nil 예외처리
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.coinID = (try? container.decode(Int.self, forKey: .coinID)) ?? -999
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.small = (try? container.decode(String.self, forKey: .small)) ?? ""
        self.large = (try? container.decode(String.self, forKey: .large)) ?? ""
        self.thumb = (try? container.decode(String.self, forKey: .thumb)) ?? ""
        self.marketCapRank = (try? container.decode(Int.self, forKey: .marketCapRank)) ?? -999
        self.data = (try? container.decode(CoinData.self, forKey: .data)) ?? CoinData(price: 0, priceChangePercentage24H: [:], sparkline: "")
    }
    
}

struct CoinData : Decodable {
    let price : Double
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
struct MarketCoin : Decodable {
    let id, symbol, name: String
    let symbolImage: String
    let currentPrice, high24H, low24H, priceChangePercentage24H: Double
    let ath: Double
    let athDate: String
    let atl: Double
    let atlDate, lastUpdated: String
    let sparklineIn7D: SparklineIn7D

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case symbolImage = "image"
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
// SparklineIn7D
struct SparklineIn7D: Decodable {
    let price: [Double]
}

typealias MarketCoinModel = [MarketCoin]
