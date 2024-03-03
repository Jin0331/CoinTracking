//
//  TrendingViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 3/3/24.
//

import UIKit

protocol PassTransitionProtocol : AnyObject {
    func didSeletButton(_ buttonTag : Int)
}

class TrendingViewController: BaseViewController {
    
    let mainView = TrendingView()
    let viewModel = TrendingViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "trending")
        dataBind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function, "trending")
        dataBind()
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        print(#function, "trending")
    //        dataBind()
    //    }
    
    func dataBind() {
        viewModel.fetchFavoriteTrigger.value = ()
        print(viewModel.outputFavorite.value.count)
        
        DispatchQueue.main.async {
            self.viewModel.outputFavorite.bind { _ in
                self.mainView.mainTableView.reloadData()
            }
        }
        
        viewModel.outputNFTTrending.bind { value in
            self.mainView.mainTableView.reloadData()
        }
    }
    
    override func configureView() {
        super.configureView()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "Crypto Coin"
    }
}

extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TrendingViewModel.SettingType.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch TrendingViewModel.SettingType.getSection(section) {
            
        case .favorite :
            return viewModel.outputFavorite.value.count >= 2 ? 1 : 0
        default :
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch TrendingViewModel.SettingType.getSection(section) {
        case .favorite :
            return viewModel.outputFavorite.value.count >= 2 ? 25 : CGFloat.leastNonzeroMagnitude
        default :
            return 25
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        myLabel.text = TrendingViewModel.SettingType.getSection(section).title
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TrendingViewModel.SettingType.getSection(indexPath.section) {
            
        case .favorite :
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
            cell.favoriteCollectionView.delegate = self
            cell.favoriteCollectionView.dataSource = self
            cell.favoriteCollectionView.tag = indexPath.section
            cell.favoriteCollectionView.reloadData()
            
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as! TopTableViewCell
            cell.topCollectionView.delegate = self
            cell.topCollectionView.dataSource = self
            cell.topCollectionView.tag = indexPath.section
            cell.topCollectionView.reloadData()
            
            return cell
            
        }
    }
}

//MARK: - Collection View
extension TrendingViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch TrendingViewModel.SettingType.getSection(collectionView.tag) {
        case .favorite:
            return viewModel.outputFavorite.value.count
        case .coin:
            return viewModel.outputCoinTrending.value.count
        case .nft:
            return viewModel.outputNFTTrending.value.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch TrendingViewModel.SettingType.getSection(collectionView.tag) {
        case .favorite:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
            
            if let first = viewModel.outputFavorite.value[indexPath.row].market.first {
                cell.configureUI(first)
            }
            return cell
        case .coin:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as! TopCollectionViewCell
            
            cell.viewModel.coinTrend.value = viewModel.outputCoinTrending.value[indexPath.row]
            cell.senderDelegate = self
            
            return cell
        case .nft:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as! TopCollectionViewCell
            
            cell.viewModel.nftTrend.value = viewModel.outputNFTTrending.value[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch TrendingViewModel.SettingType.getSection(collectionView.tag) {
        case .favorite:
            let vc = ChartViewController()
            vc.viewModel.inputCoinID.value = self.viewModel.outputFavorite.value[indexPath.row].coinID
            navigationController?.pushViewController(vc, animated: true)
        case .nft, .coin:
            return
        }
    }
    
}

extension TrendingViewController : PassTransitionProtocol {
    func didSeletButton(_ buttonTag: Int) {
        
        let vc = ChartViewController()
        vc.viewModel.inputCoinID.value = self.viewModel.outputCoinTrendingSimple.value[buttonTag].coinID
        navigationController?.pushViewController(vc, animated: true)
    }
}
