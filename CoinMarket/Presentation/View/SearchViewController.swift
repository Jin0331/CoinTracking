//
//  SearchViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

//MARK: - TableView만 있으므로, Custom View 없이 바로 진행
//TODO: - search start -> Search API 호출 -> Realm Create 또는 Update (항목이 없다면, create 있다면 ID 중심으로 Update 되어야 함) -> sort(내림차순) 및 쵀대 상위 25개까지 tableView에 뿌림
class SearchViewController: BaseViewController {

    let mainView = SearchView()
    let viewModel = SearchViewModel()
    let repository = RealmRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputData.bind { value in
            
            if let value {
                print(value)
            }
        }
                
    }
    
    override func configureView() {
        super.configureView()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.searchController.delegate = self
        mainView.searchController.searchBar.delegate = self
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        self.navigationItem.title = "Search"
        self.navigationItem.searchController = mainView.searchController
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as! SearchViewTableViewCell
        
        cell.symbolImage.image = DesignSystem.systemImage.favorite
        cell.nameLabel.text = "BitCoin"
        cell.symbolLabel.text = "BTC"

        return cell
    }
    
    
}

extension SearchViewController : UISearchControllerDelegate {
    
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)

        viewModel.inputCoinID.value = searchBar.text
//        mainView.searchController.isActive = false
        
    }
}
