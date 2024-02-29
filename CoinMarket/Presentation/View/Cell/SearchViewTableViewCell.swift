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
    
    var viewModel = SearchViewTableViewCellModel() // SearchViewModel 재사용
    
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
        $0.configuration = config
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindData() {
        
        viewModel.search.bind { value in
            guard let value = value else { return }
            
            self.viewModel.inputCoinID.value = value.coinID
            self.symbolImage.kf.setImage(with: value.largeURL)
            self.nameLabel.text = value.coinName
            self.symbolLabel.text = value.conSymbol
        }
        
        viewModel.outputFavoriteBool.bind { value in
            self.favoriteButton.setNeedsUpdateConfiguration()
        }
    }
    
    
    override func configureView() {
        super.configureView()
        
        print(#function)
        
        favoriteButton.addAction(UIAction(handler: { _ in
            
            //TODO: - 즐겨찾기 10개 초과 토스트 여기서 해야됨. 10개 초과시 return으로 아래 코드 실행되지 않도록
            let status = self.viewModel.getCase(self.viewModel.fetchFavoriteTrueRowNumber())
            self.makeToast(status.textValue, duration: 1) }), for: .touchUpInside)
        
        // toggle 될 때마다, button 이미지 변경 됨.
        favoriteButton.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.image = self.viewModel.outputFavoriteBool.value ? DesignSystem.systemImage.favoriteFill : DesignSystem.systemImage.favorite
            button.configuration = config
        }
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
    
    override func prepareForReuse() {
        symbolImage.image = nil
        nameLabel.text = nil
        symbolLabel.text = nil
        favoriteButton.addAction(UIAction(handler: { _ in }), for: .touchUpInside)
    }
    
}
