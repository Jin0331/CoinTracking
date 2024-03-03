//
//  UITabbarController + Extension.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/29/24.
//

import UIKit

extension UITabBarController {
    func configureItemDesing(tabBar : UITabBar) {
        
        tabBar.tintColor = DesignSystem.colorSet.gray
        tabBar.barTintColor = DesignSystem.colorSet.white
        
        // item 디자인
        if let item = tabBar.items {
            //TODO: - Active, Inactive 구현해야됨. 지금은 Inactive 상태
            item[0].image = DesignSystem.tabbarImage.trendInactive
            item[0].selectedImage = DesignSystem.tabbarImage.trend
            
            item[1].image = DesignSystem.tabbarImage.searchInactive
            item[1].selectedImage = DesignSystem.tabbarImage.search
            
            item[2].image = DesignSystem.tabbarImage.portfolioInactive
            item[2].selectedImage = DesignSystem.tabbarImage.portfolio
            
        }
    }
}

