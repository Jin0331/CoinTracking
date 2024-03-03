//
//  TopLabel.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import UIKit
import SnapKit
import Then

class CommonTrendingLabel : BaseView {
    
    let bgView = UIView().then {
        $0.backgroundColor = .brown
    }
    
    let rankLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
        
        $0.text = "1"
        $0.backgroundColor = .red
    }
    
    let symbolImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        
        $0.backgroundColor = .yellow
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        
        $0.text = "asdzxcasdzxcasd"
        $0.backgroundColor = .gray
    }
    
    let symbolLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.font = .systemFont(ofSize: 17)
        
        $0.text = "LTC"
        $0.backgroundColor = .green
    }
    
    let priceLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        
        $0.text = "0.4175"
        $0.backgroundColor = .magenta
    }
    
    let percentLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.red
        $0.font = .systemFont(ofSize: 17)
        
        $0.text = "%21.18%"
        $0.backgroundColor = .systemPink
    }
    
    
    override func configureHierarchy() {
        addSubview(bgView)
        [rankLabel, symbolImage, priceLabel, percentLabel, nameLabel, symbolLabel].forEach{bgView.addSubview($0)}
    }
    
    override func configureLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.size.equalTo(45)
        }
        
        symbolImage.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(10)
            make.centerY.equalTo(rankLabel)
            make.size.equalTo(45)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolImage.snp.top)
            make.trailing.equalToSuperview().inset(5)
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(20)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.trailing.equalTo(priceLabel)
            make.size.equalTo(priceLabel)
        }
        

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(10)
            make.trailing.equalTo(priceLabel.snp.leading)
            make.top.equalTo(symbolImage.snp.top)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.trailing.equalTo(nameLabel)
        }
    }
}
