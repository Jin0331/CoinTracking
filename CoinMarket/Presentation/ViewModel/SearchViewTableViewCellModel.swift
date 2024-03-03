//
//  SearchViewTableViewCellModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

class SearchViewTableViewCellModel {
    
    private let repository = RealmRepository()
    
    var search : Observable<Search?> = Observable(nil)
    
    var inputCoinID : Observable<String?> = Observable(nil)
    
    var favoriteButtonClicked : Observable<Void?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool> = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        // cell에 접근할 때, ID를 추출하여 favorite status 변경
        inputCoinID.bind { value in
            guard let value = value else { return }
            guard let item = self.repository.fetchSearchItem(coinID: value)?.first! else { return }
            
            self.outputFavoriteBool.value = item.favorite
        }
        
        // favorite button이 클릭되었을 때, realm update
        favoriteButtonClicked.bind { _ in
            
            guard let coinID = self.inputCoinID.value else { return }
            
            print("여긴가?")
            
            self.repository.updateFavoriteToggle(coinID, self.outputFavoriteBool.value)
            self.callRequestMarketWithFavorite(coinID)
        }
    }
    
    private func callRequestMarketWithFavorite(_ value : String) {
        CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: value)) { response, error in
            
            if let error {
                //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨 -> Realm 조회
                print("network Error")
            } else {
                guard let response = response else { return }
                guard let data = response.first else { return }
                
                // embedd class
                let embeddedItem = self.repository.createEmbeddedItem(data)
                self.repository.searchCreateOrUpdateItem(coinID: data.id, coinName: data.name,
                                                         conSymbol: data.symbol,
                                                         symbolImage : data.symbolImage,
                                                         currentPrice: data.currentPrice,
                                                         lastUpdated: data.lastUpdated.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSz")!,
                                                         change: embeddedItem , sparkline_in_7d: data.sparklineIn7D.price)
                
                // Search Table과 Relation 설정
                self.repository.createRelationSearchWithMarket(coinID: value)
            }
        }
    }
    
    // 즐겨찾기 관련 함수
    enum FavoriteStatus {
        case add
        case remove
        case error
        
        var textValue : String {
            switch self {
            case .add:
                return "✅ 즐겨찾기가 추가되었습니다"
            case .remove:
                return "❌ 즐겨찾기가 해제되었습니다"
            case .error :
                return "🚫 즐겨찾기 10개 초과되었습니다"
            }
        }
    }
    
    func getCase(_ cnt : Int) -> FavoriteStatus {
        
        if outputFavoriteBool.value == true {
            outputFavoriteBool.value.toggle()
            favoriteButtonClicked.value = ()
            return .remove
        } else if outputFavoriteBool.value == false && cnt < 10 {
            outputFavoriteBool.value.toggle()
            favoriteButtonClicked.value = ()
            
            return .add
        } else {
            return .error
        }
    }
    
    func fetchFavoriteTrueRowNumber() -> Int {
        
        return repository.fetchSearchItem().filter { $0.favorite == true }.count
    }
}
