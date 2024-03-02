//
//  FavoriteViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/29/24.
//

import UIKit

class FavoriteViewController: BaseViewController {

    let mainView = FavoriteView()
    let viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function, "즐겨찾기 화면")
        dataBind()
    }
    
    func dataBind() {
        viewModel.getCoinIDListTrigger.value = ()
        
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "Favorite Coin"
    }
}
