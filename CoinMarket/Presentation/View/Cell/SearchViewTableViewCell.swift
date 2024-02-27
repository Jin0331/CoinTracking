//
//  SearchViewTableViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit
import SnapKit
import Then

class SearchViewTableViewCell: BaseTableViewCell {
    
    let symbolImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .black
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let symbolLabel = UILabel().then {
        $0.textColor = DesignSystem.colorSet.gray
        $0.font = .systemFont(ofSize: 17)
    }
    
    let favoriteButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = DesignSystem.systemImage.favorite!.applyingSymbolConfiguration(.init(pointSize: 50)) // systemImage에만 적용됨.. 추후 찾아보자
        
        $0.configuration = config
    }
    
    override func configureHierarchy() {
        [symbolImage, nameLabel, symbolLabel, favoriteButton].forEach{ contentView.addSubview($0)}
    }
    
    override func configureLayout() {
        
        symbolImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(10)
            make.top.equalTo(symbolImage.snp.top)
            make.width.equalTo(100)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.width.equalTo(100)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(50)
        }
    }


}
