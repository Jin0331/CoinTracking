//
//  TrendingViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import Foundation

class TrendingViewModel {
    
    private let repository = RealmRepository()
    
    var outputFavorite : Observable<[Search]> = Observable([])
    var outputCoinTrending : Observable<[[(Int, CoinTrend)]]> = Observable([])
    var outputNFTTrending : Observable<[[(Int, NFTTrend)]]> = Observable([])
    
    var outputCoinTrendingSimple : Observable<[CoinTrend]> = Observable([])
    
    var fetchFavoriteTrigger : Observable<Void?> = Observable(nil)
    var getTrendListTrigger : Observable<Void?> = Observable(nil)
    
    init () {
        transform()
    }
    
    private func transform() {
        
        print(#function, " - Trending")
        
        getTrendListTrigger.bind { _ in
            self.callRequest()
        }
        
        // Favorite 값 가져오기
        fetchFavoriteTrigger.bind { _ in
            self.outputFavorite.value = self.repository.fetchSearchItemWithFavorite()
        }
        
    }
    
    private func callRequest() {
        
        CoinAPIManager.shared.callRequest(type: SearchTrendingModel.self, api: .trend) { response, error in
            
            if let error {
                print("network error")
                self.outputCoinTrendingSimple.value = self.repository.fetchCoinTrendItem()
                self.outputCoinTrending.value = self.repository.fetchCoinTrendItem().splitIntoSubarrays(ofSize: 3)
                self.outputNFTTrending.value = self.repository.fetchNFTTrendItem().splitIntoSubarrays(ofSize: 3)
            } else {
                guard let response = response else { return }
                
                // 기존 테이블 삭제
                self.repository.allCoinTrendTableRemove()
                self.repository.allNFTTrendTableRemove()
                
                
                // coinTrend table 생성
                response.coins.forEach { row in
                    let table = CoinTrend(coinID: row.item.id, coinName: row.item.name, conSymbol: row.item.symbol, large: row.item.large, price: row.item.data.price, percentage: row.item.data.priceChangePercentage24H["krw"]!)
                    
                    self.repository.trendCreateItem(table)
                    
                    // Search Table Update
                    self.repository.searchCreateOrUpdateItem(coinID: row.item.id, coinName: row.item.name, conSymbol: row.item.symbol, rank: row.item.marketCapRank, searchKeyword: nil,  large: row.item.large)
                    
                }
                
                response.nfts.forEach { row in
                    let table = NFTTrend(nftID: row.id, nftName: row.name, nftSymbol: row.symbol, thumb: row.thumb, floorPrice: row.data.floorPrice, percentage: row.data.floorPriceInUsd24HPercentageChange)
                    
                    self.repository.trendCreateItem(table)
                }
                
                self.outputCoinTrendingSimple.value = self.repository.fetchCoinTrendItem()
                self.outputCoinTrending.value = self.repository.fetchCoinTrendItem().splitIntoSubarrays(ofSize: 3)
                self.outputNFTTrending.value = self.repository.fetchNFTTrendItem().splitIntoSubarrays(ofSize: 3)
                
            }
            
        }
    }
    
    func searchMarket(coinID : String) -> Bool {
        
        print("데이터 존재 여부", !repository.fetchMarketItemExist(coinID: coinID))
        
        return !repository.fetchMarketItemExist(coinID: coinID)
    }
    
    // mainTableView 관련
    enum SettingType: CaseIterable {
        case favorite
        case coin
        case nft
        
        
        static func numberOfSections() -> Int {
            return self.allCases.count
        }
        
        var title: String {
            switch self {
            case .favorite:
                return "즐겨찾기"
            case .coin:
                return "Top15 Coin"
            case .nft:
                return "Top7 NFT"
            }
        }
        
        static func getSection(_ section: Int) -> SettingType {
            return self.allCases[section]
        }
    }
    
    
    
}
