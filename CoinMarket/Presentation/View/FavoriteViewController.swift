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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function, "즐겨찾기화면")
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
        
        mainView.favoriteCollectionView.dragDelegate = self
        mainView.favoriteCollectionView.dropDelegate = self
        mainView.favoriteCollectionView.dragInteractionEnabled = true
        
        mainView.refreshControll.addTarget(self, action: #selector(refreshFunction), for: .valueChanged)
    }
    
    @objc func refreshFunction(_ sender : UIRefreshControl){
        
        print(#function, sender.isRefreshing)
        
        self.viewModel.getCoinIDListTrigger.value = ()
        self.mainView.refreshControll.endRefreshing()
    }
    
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "즐겨찾기"
    }
}

extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        
        return viewModel.outputFavorite.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configureUI(viewModel.outputFavorite.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        let coinID = self.viewModel.outputFavorite.value[indexPath.row].coinID
        chartViewTransition(coinID: coinID, marketExist: self.viewModel.searchMarket(coinID: coinID))
        
    }
}

//MARK: -collection View drag drop
extension FavoriteViewController : UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = viewModel.outputFavorite.value[indexPath.row]
        
        return [dragItem]
    }
    
    // 셀이 이동이 가능한지 여부,, 무조건 된다는 가정
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard collectionView.hasActiveDrag else { return UICollectionViewDropProposal(operation: .forbidden) }
        return UICollectionViewDropProposal(operation: .move)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        if let destinationIndexPath = coordinator.destinationIndexPath {
            if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates {
                    
                    let targetID = viewModel.outputFavorite.value[sourceIndexPath.item].coinID
                    print(#function, "soruce ID : ", targetID, "source : ",sourceIndexPath, "target : ",destinationIndexPath)
                    
                    // 화면에서 지워지는 것처럼 보여지는 코드
                    viewModel.outputFavorite.value.remove(at: sourceIndexPath.item)
                    viewModel.outputFavorite.value.insert(item.dragItem.localObject as! Market, at: destinationIndexPath.item)
                    
                    
                    // 실제 값이 바뀌는
                    viewModel.updateFavoriteRank(targetCoinID: targetID, source: sourceIndexPath, destination: destinationIndexPath)
                    
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }
            }
        }
    }
}
