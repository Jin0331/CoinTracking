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
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    let currentPriceLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 35, weight: .bold)
    }
    
    let athChangeLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.red
        $0.font = .systemFont(ofSize: 20)
    }
    
    let updateDateLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.lightBlack
        $0.font = .systemFont(ofSize: 20)
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
        $0.subLabel.text = "1235123"
        $0.textLabel.textColor = DesignSystem.colorSet.red
    }
    
    let newLowPriceLabel =  ChartPriceView().then {
        $0.textLabel.text = "신저점"
        $0.subLabel.text = "1235123"
        $0.textLabel.textColor = DesignSystem.colorSet.blue
    }
    
    let bottomChartView = LineChartView(frame: .zero).then {
        $0.backgroundColor = .red
               
    }
    
    override func configureHierarchy() {
        [topView, middleStackView, bottomChartView].forEach{ addSubview($0)}
        
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
            make.size.equalTo(60)
        }
        
        symbolTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(8)
            make.verticalEdges.equalTo(symbolImage)
            make.trailing.equalToSuperview().inset(5)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage)
            make.top.equalTo(symbolTitleLabel.snp.bottom).offset(15)
            make.height.equalTo(60)
        }
        
        athChangeLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentPriceLabel)
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(10)
            make.width.greaterThanOrEqualTo(65)
        }
        
        updateDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(athChangeLabel.snp.trailing).offset(8)
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(150)
        }
        
        // middleView
        middleStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.height.equalTo(140)
        }
        
        bottomChartView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }

}
