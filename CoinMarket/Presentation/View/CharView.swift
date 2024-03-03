//
//  CharView.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import SnapKit
import Then
import DGCharts

class CharView: BaseView {

    let topView = UIView().then { _ in
    }
    
    let symbolImage = UIImageView().then { _ in
    }
    
    let symbolTitleLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 33, weight: .bold)
    }
    
    let currentPriceLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 35, weight: .bold)
    }
    
    let athChangeLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.red
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let updateDateLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    // middleView
    let middleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let middleStackViewTop =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let hightPriceLabel =  ChartPriceView().then {
        $0.textLabel.text = "고가"
        $0.textLabel.textColor = DesignSystem.colorSet.red
    }
    
    let lowPriceLabel =  ChartPriceView().then {
        $0.textLabel.text = "저가"
        $0.textLabel.textColor = DesignSystem.colorSet.blue
    }
    
    let middleStackViewBottom =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let newHightPriceLabel =  ChartPriceView().then {
        $0.textLabel.text = "신고점"
        $0.textLabel.textColor = DesignSystem.colorSet.red
    }
    
    let newLowPriceLabel = ChartPriceView().then {
        $0.textLabel.text = "신저점"
        $0.textLabel.textColor = DesignSystem.colorSet.blue
    }
    
    let updateBottom = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    let bottomChartView = LineChartView(frame: .zero).then {
        $0.setScaleEnabled(false)
        $0.animate(xAxisDuration: 1.5)
        $0.drawGridBackgroundEnabled = false
        $0.xAxis.drawAxisLineEnabled = false
        $0.xAxis.drawGridLinesEnabled = false
        $0.leftAxis.drawAxisLineEnabled = false
        $0.leftAxis.drawGridLinesEnabled = false
        $0.rightAxis.drawAxisLineEnabled = false
        $0.rightAxis.drawGridLinesEnabled = false
        $0.legend.enabled = false
        $0.xAxis.enabled = false
        $0.leftAxis.enabled = false
        $0.rightAxis.enabled = false
        $0.xAxis.drawLabelsEnabled = false
    }
    
    override func configureHierarchy() {
        [topView, middleStackView, bottomChartView, updateBottom].forEach{ addSubview($0)}
        
        // topView
        [symbolImage, symbolTitleLabel, currentPriceLabel, athChangeLabel, updateDateLabel].forEach { topView.addSubview($0)}
        
        // middleView
        [middleStackViewTop, middleStackViewBottom].forEach { middleStackView.addArrangedSubview($0)}
        
        middleStackViewTop.addArrangedSubview(hightPriceLabel)
        middleStackViewTop.addArrangedSubview(lowPriceLabel)
        middleStackViewBottom.addArrangedSubview(newHightPriceLabel)
        middleStackViewBottom.addArrangedSubview(newLowPriceLabel)
        
    }
    
    override func configureLayout() {
        
        // topView
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
        
        symbolImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(3)
            make.size.equalTo(45)
        }
        
        symbolTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(8)
            make.verticalEdges.equalTo(symbolImage)
            make.trailing.equalToSuperview().inset(5)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage)
            make.top.equalTo(symbolTitleLabel.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        athChangeLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentPriceLabel)
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(40)
        }
        
        updateDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(athChangeLabel.snp.trailing).offset(5)
            make.top.equalTo(athChangeLabel)
            make.width.lessThanOrEqualTo(150)
        }
        
        // middleView
        middleStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.height.equalTo(140)
        }
        
        bottomChartView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        updateBottom.snp.makeConstraints { make in
            make.top.equalTo(bottomChartView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    func configureUI(_ first : Market) {
        symbolImage.kf.setImage(with: first.symbolImageURL)
        symbolTitleLabel.text = first.coinName
        
        currentPriceLabel.text = first.currentPrice.toPoint()
        
        if let value = first.change?.perprice_change_percentage_24h {
            if value >= 0 {
                athChangeLabel.textColor = DesignSystem.colorSet.red
                athChangeLabel.text = "+\(value.toNumber(digit: 2, percentage: true)!)"
            } else {
                athChangeLabel.textColor = DesignSystem.colorSet.blue
                athChangeLabel.text = "\(value.toNumber(digit: 2, percentage: true)!)"
            }
        }
        
        updateDateLabel.text = first.lastUpdated.toString(dateFormat: "M/d hh:mm",raw: false)
        hightPriceLabel.subLabel.text = first.change?.high_24h.toPoint()
        lowPriceLabel.subLabel.text = first.change?.low_24h.toPoint()
        newHightPriceLabel.subLabel.text = first.change?.ath.toPoint()
        newLowPriceLabel.subLabel.text = first.change?.atl.toPoint()
        
        updateBottom.text = "\(first.upDate.toString(dateFormat: "M/d hh:mm:ss",raw: true)) 업데이트"
    }
    
    func drawChart(_ first : Market) {
    
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

        bottomChartView.data = lineChartData
    }

}
