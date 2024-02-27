//
//  CoinAPI.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

//TODO: - Alamofire를 이용한 Network 구성

import Foundation
import Alamofire

enum CoinAPI : CaseIterable {
    
    static let baseURL = "https://api.coingecko.com/api/v3/"
    static let imageURL = "https://assets.coingecko.com/coins/images/"
    static let method : HTTPMethod = .get
    
    static var allCases: [CoinAPI] {
        return [.trend, .search(coinName: ""), .market(ids: "")]
    }
    
    case trend
    case search(coinName : String)
    case market(ids : String) //TODO: - 나라별 언어 추후 반영?
    
    var endPoint : URL {
        switch self {
        case .trend:
            return URL(string: CoinAPI.baseURL + "search/trending")!
        case .search:
            return URL(string: CoinAPI.baseURL + "search")!
        case .market:
            return URL(string: CoinAPI.baseURL + "coin/markets")!
        }
    }
    
    var parameter : Parameters {
        switch self {
        case .search(coinName: let coinName):
            return ["query": coinName]
        case .market(ids: let ids):
            return ["ids":ids, "vs_currency" : "krw", "sparkline" : "true"]
            
        default :
            return [:]
            
        }
    }
    
    //MARK: - Error 관련 Enum
    enum APIError : Error {
        case failedRequeset
        case noData
        case invalidResponse
        case invalidData
        case invalidDecodable
    }
    
}
