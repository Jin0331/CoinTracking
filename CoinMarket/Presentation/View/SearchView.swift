//
//  SearchView.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import UIKit
import SnapKit
import Then

class SearchView : BaseView {
    // UI
    let mainTableView = UITableView().then {
        $0.register(SearchViewTableViewCell.self, forCellReuseIdentifier: SearchViewTableViewCell.identifier)
        $0.rowHeight = 80
        $0.separatorStyle = .none
    }
    
    lazy var searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = ""
        $0.hidesNavigationBarDuringPresentation = false
        $0.obscuresBackgroundDuringPresentation = false
    }
    
    override func configureHierarchy() {
        addSubview(mainTableView)
    }
    
    override func configureLayout() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(5)
        }
    }
    
}
