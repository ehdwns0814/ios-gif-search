//
//  TabBarViewController.swift
//  ios-gif-search
//
//  Created by 동준 on 3/8/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchViewController = SearchViewController()
        let myViewController = MyViewController()
        
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        myViewController.tabBarItem.image = UIImage(systemName: "person.crop.square")
        
        let navigationSearch = UINavigationController(rootViewController: searchViewController)
        let navigationMy = UINavigationController(rootViewController: myViewController)
        
        setViewControllers([navigationSearch, navigationMy], animated: false)
    }
}
