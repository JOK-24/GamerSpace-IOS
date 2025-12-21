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
        // Configurar apariencia del TabBar
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Fondo del TabBar
        appearance.backgroundColor = UIColor.darkBlue
        
        // Borde superior sutil
        appearance.shadowColor = UIColor.purple.withAlphaComponent(0.3)
        appearance.shadowImage = createGradientLine()
        
        // Estilo de los ítems normales (no seleccionados)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.6),
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
        
        // Estilo de los ítems seleccionados
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.purple,
            .font: UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.purple
        
        // Aplicar apariencia
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        // Color de tint (seleccionado)
        tabBar.tintColor = UIColor.purple
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
    }
    
    // Crear línea de gradiente para el borde superior
    private func createGradientLine() -> UIImage? {
        let bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let colors = [
            UIColor.purple.withAlphaComponent(0.5).cgColor,
            UIColor.purple.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor
        ] as CFArray
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0.0, 0.5, 1.0])!
        
        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: 0, y: 0),
            end: CGPoint(x: bounds.width, y: 0),
            options: []
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
