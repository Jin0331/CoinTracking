//
//  SearchViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

//MARK: - TableView만 있으므로, Custom View 없이 바로 진행
class SearchViewController: BaseViewController {

    let mainView = SearchView()
    let repository = RealmRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CoinAPIManager.shared.callRequest(type: SearchModel.self, api: .search(coinName: "bitcoin")) { response, error in
            if let error = error {
                
            } else {
                guard let response = response else { return }
                
                
                response.coins.forEach { item in
                    self.repository.searchCreateOrUpdateItem(coinID: item.id,
                                                             coinName: item.name,
                                                             conSymbol: item.symbol,
                                                             rank: item.marketCapRank,
                                                             thumb: item.thumb)
                }
                

                
                self.repository.realmLocation()
            }
        }
        
//
        
    }
    
    
    
    override func configureView() {
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        // UISearchContoller
        let searchController = UISearchController(searchResultsController: nil) // UISearchController
        searchController.searchBar.placeholder = ""
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.title = "Search"
        self.navigationItem.searchController = searchController
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
