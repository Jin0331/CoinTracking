//
//  ChartViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import Then
import Kingfisher
import DGCharts

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
        
        print(#function)
        bindData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.timerstop()
        print("타이머 종료")
    }
    
    
    private func bindData() {
    
        viewModel.outputMarket.bind { value in
            guard let first = value else { return }
            self.mainView.configureUI(first)
            self.mainView.drawChart(first)
        }
        
        viewModel.outputFavoriteBool.bind { value in
            
            guard let favorite = value else { return }
            print(#function, favorite)
            
            let rightButtonItem = self.viewModel.outputFavoriteBool.value! ?  UIBarButtonItem(image: DesignSystem.systemImage.favoriteFill, style: .done, target: self, action: #selector(self.rightBarButtonClicked)) : UIBarButtonItem(image: DesignSystem.systemImage.favorite, style: .plain, target: self, action: #selector(self.rightBarButtonClicked))
            
            rightButtonItem.tintColor = DesignSystem.colorSet.purple
            
            self.navigationItem.rightBarButtonItem = rightButtonItem
        }
        
        viewModel.outputDataAccess.bind{ value in
            
            if !value {
                self.showToast(message: "❗️API Limit 입니다. 저장된 데이터를 호출합니다", seconds: 3)
            }
        }
    }
    
    @objc func rightBarButtonClicked(_ sender : UIBarButtonItem) {
        print(#function)
        
        let status = self.viewModel.getCase(self.viewModel.fetchFavoriteTrueRowNumber())
        self.view.makeToast(status.textValue, duration: 1)
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
