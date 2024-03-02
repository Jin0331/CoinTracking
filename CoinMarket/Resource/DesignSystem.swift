//
//  ImageSystem.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/27/24.
//

import UIKit

enum DesignSystem {
    
    enum colorSet  {
        static let black = UIColor.ublack
        static let blue = UIColor.ublue
        static let gray = UIColor.uGray
        static let lightBlack = UIColor.ulightBlack
        static let lightBlue = UIColor.ulightBlue
        static let lightGray = UIColor.ulightGray
        static let pink = UIColor.upink
        static let purple = UIColor.upurple
        static let red = UIColor.ured
        static let white = UIColor.uWhite
    }
    
    enum systemImage {
        static let favorite = UIImage(named: "btn_star")
        static let favoriteFill = UIImage(named: "btn_star_fill")
    }
    
    enum tabbarImage {
        static let trend = UIImage(named: "tab_trend")
        static let trendInactive = UIImage(named: "tab_user_inactive")
        
        static let portfolio = UIImage(named: "tab_portfolio")
        static let portfolioInactive = UIImage(named: "tab_portfolio_inactive")
        
        static let search = UIImage(named: "tab_search")
        static let searchInactive = UIImage(named: "tab_search_inactive")
        
        static let user = UIImage(named: "tab_user")
        static let userInactive = UIImage(named: "tab_user_inactive")
    }
}
