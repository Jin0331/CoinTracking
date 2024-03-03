//
//  TopCollectionViewCell.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class TopCollectionViewCell: BaseCollectionViewCell {
    
    let viewModel = TopCollectionViewModel()
    weak var senderDelegate : PassTransitionProtocol?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindData() {
        
        viewModel.coinTrend.bind{ [self] value in
            guard let value = value else { return }
            
            [topLabel, middleLabel, bottomLabel].enumerated().forEach { index, item in
                
                item.rankLabel.text = String(value[index].0 + 1)
                item.symbolImage.kf.setImage(with: value[index].1.largeURL)
                item.nameLabel.text = value[index].1.coinName
                item.symbolLabel.text = value[index].1.conSymbol
                item.priceLabel.text = value[index].1.price
                
                item.percentLabel.textColor = value[index].1.percentage >= 0 ? DesignSystem.colorSet.red : DesignSystem.colorSet.blue
                item.percentLabel.text = value[index].1.percentage >= 0 ? "+\(value[index].1.percentage.toNumber(digit: 2, percentage: true) ?? "")": value[index].1.percentage.toNumber(digit: 2, percentage: true)
                
                item.transitionButtn.tag = value[index].0
                item.transitionButtn.addTarget(self, action: #selector(transitionButtnClicked), for: .touchUpInside)
                
            }
        }
        
        viewModel.nftTrend.bind{ [self] value in
            guard let value = value else { return }
            
            let labelList = value.count > 1 ? [topLabel, middleLabel, bottomLabel] : [topLabel]
            labelList.enumerated().forEach { index, item in
                
                item.rankLabel.text = String(value[index].0 + 1)
                item.symbolImage.kf.setImage(with: value[index].1.thumbURL)
                item.nameLabel.text = value[index].1.nftName
                item.symbolLabel.text = value[index].1.nftSymbol
                item.priceLabel.text = value[index].1.floorPrice
                
                if let value = Double(value[index].1.percentage) {
                    item.percentLabel.textColor = value >= 0 ? DesignSystem.colorSet.red : DesignSystem.colorSet.blue
                    item.percentLabel.text = value >= 0 ? "+\(value.toNumber(digit: 2, percentage: true) ?? "")": value.toNumber(digit: 2, percentage: true)
                }
            }
            
        }
        
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
    
    @objc func transitionButtnClicked(_ sender : UIButton) {
        print(#function, sender.tag)
        senderDelegate?.didSeletButton(sender.tag)
    }
    
}
