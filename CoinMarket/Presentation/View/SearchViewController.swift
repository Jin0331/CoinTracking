//
//  SearchViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
}
