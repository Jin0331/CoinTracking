//
//  SearchViewTableViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit
import SnapKit
import Then

//TODO: - search start -> Search API 호출 -> Realm Create 또는 Update (항목이 없다면, create 있다면 ID 중심으로 Update 되어야 함) -> sort(내림차순) 및 쵀대 상위 25개까지 tableView에 뿌림

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
        $0.setImage(DesignSystem.systemImage.favorite, for: .normal)
        $0.setTitleColor(DesignSystem.colorSet.purple, for: .normal)
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
    }


}
