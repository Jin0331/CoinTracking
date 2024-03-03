//
//  TrendingView.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import UIKit
import SnapKit
import Then

class TrendingView: BaseView {
    
    lazy var mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = DesignSystem.colorSet.white
        $0.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        $0.register(TopTableViewCell.self, forCellReuseIdentifier: TopTableViewCell.identifier)
        $0.rowHeight = 220
        $0.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
