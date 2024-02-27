//
//  CoinAPIManager.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

//MARK: - Singletone 패턴

import Foundation
import Alamofire

class CoinAPIManager {
    
    
    static let shared = CoinAPIManager()
    
    private init() { }
    
    func callRequest<T:Decodable>(type : T.Type, api : CoinAPI, completionHandler : @escaping (T?, AFError?) -> Void) {
        
        print(api.endPoint)
        
        AF.request(api.endPoint,
                   method: CoinAPI.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString))
        .responseDecodable(of: type) { response in
            
            switch response.result {
            case .success(let success):
                print("API 조회 성공")
                
                completionHandler(success, nil)
            case .failure(let faiure):
                print(faiure)
                
                completionHandler(nil, faiure)
            }
        }
    }
    
}


/*
 
 //trend API
 CoinAPIManager.shared.callRequest(type: SearchTrendingModel.self, api: .trend) { value, error in
     
 dump(value)
 }

 CoinAPIManager.shared.callRequest(type: SearchModel.self, api: .search(coinName: "bitcoinpow")) { value, error in

     dump(value)
 }
 
 //TODO: - market에서 ids 받을 때, Array -> join 형태로 진행하면 될 듯
 CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: "bitcoinpow")) { value, error in

     dump(value)
 }
 
 */
