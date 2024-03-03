//
//  BaseViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

class BaseViewController : UIViewController {
    
    private let repository = RealmRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureNavigation()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
        view.backgroundColor = DesignSystem.colorSet.white
    }
    
    // navigation controller가 있다면 적용되는 사항
    func configureNavigation() {
        // 배경색
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = DesignSystem.colorSet.white
        navigationController?.navigationBar.barTintColor = DesignSystem.colorSet.white
        
        // title 크게
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // back button
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = DesignSystem.colorSet.purple
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func chartViewTransition(coinID : String, marketExist : Bool) {
        CoinAPIManager.shared.callRequestStatus(api: .ping) { status in
            
            print("API Request ",status)
            
            if status {
                let vc = ChartViewController()
                vc.viewModel.inputCoinID.value = coinID
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if status == false && marketExist {
                let vc = ChartViewController()
                vc.viewModel.inputCoinID.value = coinID
                vc.viewModel.inputDataAccess.value = false
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                self.showToast(message : "❌ API Rate Limit 입니다. 잠시만 기다려주세요.", seconds: 3.0)
            }
        }
        
    }
    
}
