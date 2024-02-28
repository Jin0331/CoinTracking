//
//  ChartViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit

class ChartViewController: BaseViewController {

    let mainView = CharView()
    let viewModel = ChartViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func configureNavigation() {
        super.configureNavigation()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}
