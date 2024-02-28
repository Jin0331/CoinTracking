//
//  ChartViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import Then
import Kingfisher
import Toast
//import Charts
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
        
        bindData()

    }

    private func bindData() {
        viewModel.outputMarket.bind { value in
            guard let first = value.first else { return }
            self.configureUI(first)
            self.drawChart(first)
        }
        
        viewModel.outputFavoriteBool.bind { value in
            
            guard let favorite = value else { return }
            print(#function, favorite)
            
            let rightButtonItem = self.viewModel.outputFavoriteBool.value! ?  UIBarButtonItem(image: DesignSystem.systemImage.favoriteFill, style: .done, target: self, action: #selector(self.rightBarButtonClicked)) : UIBarButtonItem(image: DesignSystem.systemImage.favorite, style: .plain, target: self, action: #selector(self.rightBarButtonClicked))
            
            rightButtonItem.tintColor = DesignSystem.colorSet.purple
            
            self.navigationItem.rightBarButtonItem = rightButtonItem
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
    
    private func configureUI(_ first : Market) {
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
    
    private func drawChart(_ first : Market) {
    
        print(first.sparkline_in_7d.count)
        var lineChartEntry = [ChartDataEntry]()
        
        for (hour, data) in first.sparkline_in_7d.enumerated() {
               let value = ChartDataEntry(x: Double(hour) , y: data)
               lineChartEntry.append(value)
        }
        
        let set1 = LineChartDataSet(entries: lineChartEntry, label: "Number")
        let gradientColors = [DesignSystem.colorSet.white.cgColor, DesignSystem.colorSet.purple.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.mode = .cubicBezier
        set1.setColor(DesignSystem.colorSet.purple)
        set1.fillAlpha = 0.9
        set1.lineWidth = 2.5
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        set1.drawCirclesEnabled = false

        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)
        let lineChartData = LineChartData(dataSet: set1)

        mainView.bottomChartView.data = lineChartData
    }
    

}
