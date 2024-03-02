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
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 10
        $0.layer.masksToBounds = false
    }
    
    let symbolImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 19, weight: .bold)
    }
    
    let symbolLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    let currentPriceLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 19, weight: .bold)
    }
    
    let athChangeLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.red
        $0.font = .systemFont(ofSize: 15)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        
        [symbolImage, nameLabel, symbolLabel, currentPriceLabel, athChangeLabel].forEach { bgView.addSubview($0)}
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        symbolImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(5)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(symbolImage.snp.top)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.trailing.equalTo(nameLabel)
        }
        
        athChangeLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(5)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(60)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(athChangeLabel.snp.top).offset(5)
            make.trailing.equalTo(athChangeLabel)
            make.leading.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override func prepareForReuse() {
        symbolImage.image = nil
        nameLabel.text = nil
        symbolLabel.text = nil
        currentPriceLabel.text = nil
        athChangeLabel.text = nil
    }
    
    func configureUI(_ first : Market) {
        symbolImage.kf.setImage(with: first.symbolImageURL)
        nameLabel.text = first.coinName
        symbolLabel.text = first.conSymbol
        currentPriceLabel.text = first.currentPrice.toNumber(digit: 0, percentage: false)
        athChangeLabel.text = first.change?.perprice_change_percentage_24h.toNumber(digit: 2, percentage: true)
    }
    
    
}
