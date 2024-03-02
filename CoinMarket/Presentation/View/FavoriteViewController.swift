//
//  FavoriteViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/29/24.
//

import UIKit

class FavoriteViewController: BaseViewController {

    let mainView = FavoriteView()
    let viewModel = FavoriteViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function, "즐겨찾기 화면")
        dataBind()
    }
    
    func dataBind() {
        viewModel.getCoinIDListTrigger.value = ()
        
        viewModel.outputFavorite.bind { _ in
            self.mainView.favoriteCollectionView.reloadData()
        }
        
    }
    
    override func configureView() {
        super.configureView()
        mainView.favoriteCollectionView.dataSource = self
        mainView.favoriteCollectionView.delegate = self
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "Favorite Coin"
    }
}

extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.outputFavorite.value.count)
        return viewModel.outputFavorite.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configureUI(viewModel.outputFavorite.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        let vc = ChartViewController()
        vc.viewModel.inputCoinID.value = self.viewModel.outputFavorite.value[indexPath.row].coinID
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
