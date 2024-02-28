//
//  ChartViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import Kingfisher

//TODO: - percentage 음수, 양수에 따라 색 빨간색 파란색 적용
//TODO: - lastUpdate 오늘인지 아닌지 판단해서 오늘이면 "Today" 아니면 "Past" 또는 날짜 기입 - 완료

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
            self.configureLabelText(first)

        }
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureLabelText(_ first : Market) {
        
        self.mainView.symbolImage.kf.setImage(with: first.symbolImageURL)
        self.mainView.symbolTitleLabel.text = first.coinName
        self.mainView.currentPriceLabel.text = first.currentPrice.toNumber(digit: 0, percentage: false)
        self.mainView.athChangeLabel.text = first.change?.perprice_change_percentage_24h.toNumber(digit: 2, percentage: true)
        self.mainView.updateDateLabel.text = first.lastUpdated.toString(dateFormat: "M/d hh:mm")
        self.mainView.hightPriceLabel.subLabel.text = first.change?.high_24h.toNumber(digit: 0, percentage: false)
        self.mainView.lowPriceLabel.subLabel.text = first.change?.low_24h.toNumber(digit: 0, percentage: false)
        self.mainView.newHightPriceLabel.subLabel.text = first.change?.ath.toNumber(digit: 0, percentage: false)
        self.mainView.newLowPriceLabel.subLabel.text = first.change?.atl.toNumber(digit: 0, percentage: false)
    }
    
}
