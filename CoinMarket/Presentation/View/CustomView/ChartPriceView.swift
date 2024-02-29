//
//  ChartPriceView.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import SnapKit
import Then

class ChartPriceView: BaseView {

    let textLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 21, weight: .bold)
    }
    
    let subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 21)
        $0.textColor = DesignSystem.colorSet.gray
    }
    
    override func configureHierarchy() {
        addSubview(textLabel)
        addSubview(subLabel)
    }
    
    override func configureLayout() {
        textLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        subLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }

}
