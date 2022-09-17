//
//  ViewController.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import UIKit

class ViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .white
        setUI()
    }
    
    
    private func setUI() {
        let homeNavigationController = UINavigationController()
        let homeViewController = HomeViewController()
        homeNavigationController.addChild(homeViewController)
        homeNavigationController.tabBarItem.title = Strings.homeTabTitle.rawValue
        let searchNavigationController = UINavigationController()
        let searchViewController = SearchViewController()
        searchNavigationController.addChild(searchViewController)
        searchNavigationController.tabBarItem.title = Strings.searchTabTitle.rawValue
        let tabs = [homeNavigationController,searchNavigationController]
        setViewControllers(tabs, animated: true)

        
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        
//        self.tabBar.layer.shadowOpacity = 0.5
//        self.tabBar.layer.shadowOffset = 0.5
//        self.tabBar.layer.shadowRadius = 2.0
        
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.isHidden = false
        
    }
    
    private func setConstraint() {
    }


}

