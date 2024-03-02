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
    
    var outputMarket : Observable<Market?> = Observable(nil)
    
    var outputFavoriteBool : Observable<Bool?> = Observable(nil)
    
    var callRequestTringger : Observable<String?> = Observable(nil)
    
    private var favoriteButtonClicked : Observable<Void?> = Observable(nil)
    
    private var apiTimer = Timer()
    private var timerStartTrigger : Observable<Void?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {

        inputCoinID.bind { value in
            guard let value else { return }
            
            // api 호출
            self.callRequest(value)
        }
        
        // favorite button이 클릭되었을 때, realm update
        favoriteButtonClicked.bind { _ in
            
            guard let coinID = self.inputCoinID.value else { return }
            
            self.repository.updateFavoriteToggle(coinID, self.outputFavoriteBool.value!)
        }
        
        callRequestTringger.bind { coinID in
            
            guard let coinID = coinID else { return }
            
            self.callRequest(coinID)
        }
        
        timerStartTrigger.bind { _ in
            self.apiTimer = Timer.scheduledTimer(timeInterval: 10,
                                                    target: self,
                                                selector: #selector(self.updateUserMatchStatus),
                                                    userInfo: nil,
                                                    repeats: true)
            print("timer 실행")
        }
        
    }
    
    private func callRequest(_ value : String) {
        CoinAPIManager.shared.callRequest(type: MarketCoinModel.self, api: .market(ids: value)) { response, error in
            
            if let error {
                //TODO: - 네트워크가 안 될 때, 에러 핸들링 진행해야 됨 -> Realm 조회
                print("network Error")
                // output 설정
                self.outputMarket.value = self.repository.fetchMarketItem(coinID: value)
                self.outputFavoriteBool.value = self.outputMarket.value?.search.first?.favorite
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
                self.outputMarket.value = self.repository.fetchMarketItem(coinID: value)
                self.outputFavoriteBool.value = self.outputMarket.value?.search.first?.favorite
            }
        }
    }
    
    @objc private func updateUserMatchStatus(sender: Timer) {
        callRequestTringger.value = inputCoinID.value
    }
    
    
    // timer stop
    func timerstop() {
        apiTimer.invalidate()
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
