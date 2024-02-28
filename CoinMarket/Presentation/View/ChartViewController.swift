//
//  ChartViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import Kingfisher

class ChartViewController: BaseViewController {

    let mainView = CharView()
    let viewModel = ChartViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()

    }

    func bindData() {
        viewModel.outputMarket.bind { value in
            
            // 상위 Table 접근 방법... List로 되어 있어고, optional이기 때문에 first로 접근해야 됨.
            //dump(value.first?.search.first?.favorite)
            
            guard let first = self.viewModel.outputMarket.value.first else { return }
            
            self.mainView.symbolImage.kf.setImage(with: first.symbolImageURL)
            self.mainView.symbolTitleLabel.text = first.coinName
            self.mainView.currentPriceLabel.text = first.currentPrice.toNumber(digit: 0)
            
        }
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
//    private func
    
}
