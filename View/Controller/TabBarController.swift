//
//  TabBarController.swift
//  GameSpace
//
//  Created by Silvia Ferrer Rodriguez on 16/12/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        // home
        let homeVc = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVc)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        // search
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(
            title: "Buscar",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        // user
        let userVC = UserViewController()
        let userNav = UINavigationController(rootViewController: userVC)
        userNav.tabBarItem = UITabBarItem(
            title: "Perfil",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        viewControllers = [homeNav, searchNav, userNav]
    }
    
    private func setupAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
}
