//
//  BaseViewController.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

class BaseViewController : UIViewController {
    
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
    
}
