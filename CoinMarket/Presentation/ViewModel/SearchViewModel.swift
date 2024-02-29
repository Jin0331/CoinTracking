//
//  SearchViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

class SearchViewModel {
    
    private let repository = RealmRepository()
    
    var inputCoinID : Observable<String?> = Observable(nil)
    
    var outputSearch : Observable<[Search]> = Observable([])
    
    var favoriteButtonClicked : Observable<Void?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool> = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            guard let value, !value.isEmpty else { return }
            
            // API request -> realm Create or Update
            CoinAPIManager.shared.callRequest(type: SearchModel.self, api: .search(coinName: value)) { response, error in
                if let error = error {
                    //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨
                } else {
                    guard let response = response else { return }
                    response.coins.forEach { item in
                        self.repository.searchCreateOrUpdateItem(coinID: item.id, coinName: item.name,conSymbol: item.symbol, rank: item.marketCapRank, large: item.large)
                    }
                    self.repository.realmLocation()
                    self.outputSearch.value = self.repository.searchFetchItemFilterdSorted(coinID: value)
                }
            }
        }
        
        // favorite button이 클릭되었을 때, realm update
        favoriteButtonClicked.bind { _ in
            
            guard let coinID = self.inputCoinID.value else { return }
            
            self.repository.updateFavoriteToggle(coinID, self.outputFavoriteBool.value)
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
