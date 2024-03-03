//
//  TopCollectionViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import UIKit
import SnapKit
import Then

class TopCollectionViewCell: BaseCollectionViewCell {
    
    let mainStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 1
    }
    
    let topLabel = CommonTrendingLabel().then { _ in
    }
    
    let middleLabel = CommonTrendingLabel().then { _ in
    }
    
    let bottomLabel = CommonTrendingLabel().then { _ in
    }
    
    override func configureHierarchy() {
        contentView.addSubview(mainStackView)
        
        [topLabel, middleLabel, bottomLabel].forEach { return mainStackView.addArrangedSubview($0)}
    }
    
    override func configureLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
