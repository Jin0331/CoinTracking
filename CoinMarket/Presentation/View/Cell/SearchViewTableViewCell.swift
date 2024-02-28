//
//  SearchViewTableViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class SearchViewTableViewCell: BaseTableViewCell {
    
    var viewModel : SearchViewModel? // SearchViewModel 재사용
    
    let symbolImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolImage.snp.trailing).offset(10)
            make.trailing.equalTo(favoriteButton.snp.leading).inset(5)
            make.top.equalTo(symbolImage.snp.top)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.trailing.equalTo(nameLabel)
        }
    }

    
    func configureCellForRoaAt(indexPath : IndexPath) {
        
        guard let data = viewModel?.outputData.value else { return }
        
        let row = data[indexPath.row]
        
        symbolImage.kf.setImage(with: row.thumbURL)
        nameLabel.text = row.coinName
        symbolLabel.text = row.conSymbol
    }

}
