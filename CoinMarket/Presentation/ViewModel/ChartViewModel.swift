//
//  ChartViewModel.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

//MARK: - API request -> Search , Market Bind -> Query -> outputSepcific

class ChartViewModel {
    
    private let repository = RealmRepository()
    
    var inputCoinID : Observable<String?> = Observable(nil)
    
    var outputMarket : Observable<[Market]> = Observable([])
    
    var favoriteButtonClicked : Observable<Void?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            guard let value else { return }
            
            print(value, #function)
            
            CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: value)) { response, error in
                
                if let error = error {
                    //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨
                    // output 설정
                    self.outputMarket.value = self.repository.fetchMarkethItem(coinID: value)
                    self.outputFavoriteBool.value = self.outputMarket.value.first?.search.first?.favorite
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
                    
                    // output 설정
                    self.outputMarket.value = self.repository.fetchMarkethItem(coinID: value)
                    self.outputFavoriteBool.value = self.outputMarket.value.first?.search.first?.favorite
                }
            }
        }
        
        // favorite button이 클릭되었을 때, realm update
        favoriteButtonClicked.bind { _ in
            
            guard let coinID = self.inputCoinID.value else { return }
            
            self.repository.updateFavoriteToggle(coinID, self.outputFavoriteBool.value!)
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
        
        if outputFavoriteBool.value! == true {
            outputFavoriteBool.value!.toggle()
            favoriteButtonClicked.value = ()
            return .remove
        } else if outputFavoriteBool.value == false && cnt < 10 {
            outputFavoriteBool.value!.toggle()
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
