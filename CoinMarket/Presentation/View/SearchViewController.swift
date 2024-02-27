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

        CoinAPIManager.shared.callRequest(type: SearchCoinModel.self, api: .trend) { value, error in
            
            print(value)
        }
    }
}
