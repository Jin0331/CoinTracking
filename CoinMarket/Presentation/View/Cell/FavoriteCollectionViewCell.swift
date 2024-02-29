//
//  FavoriteCollectionViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/29/24.
//

import UIKit
import SnapKit
import Then

class FavoriteCollectionViewCell: BaseCollectionViewCell {
    
    let bgView = UIView().then {
        $0.backgroundColor = DesignSystem.colorSet.white
        $0.layer.cornerRadius = 10
        $0.layer.shadowOffset = CGSize(width: 10, height: 5)
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 10
        $0.layer.masksToBounds = false
    }
    
    let symbolImage = UIImageView().then { _ in
    }
    
    let symbolTitleLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    let symbolLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    let currentPriceLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    let athChangeLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.red
        $0.font = .systemFont(ofSize: 18)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        
        [symbolImage, symbolTitleLabel, symbolLabel, currentPriceLabel, athChangeLabel].forEach { bgView.addSubview($0)}
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        symbolImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(3)
            make.size.equalTo(40)
        }
    }
    
}
