//
//  File.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    // MARK: - TabBar properties
    private weak var tabBarController: UITabBarController?
    
    private(set) var uiTabBarItems: [UITabBarItem] = []
    
    func start() {
        var tabBarViewControllers: [UIViewController] = []
        
        let tabBarController = UITabBarController()
        tabBarController.modalPresentationStyle = .custom
        tabBarController.modalPresentationCapturesStatusBarAppearance = true
                
        let homeCoordinator = HomeCoordinator()
        let homeNavigationController = homeCoordinator.start()
        let uiTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "card"), tag: 0)
        uiTabBarItems.append(uiTabBarItem)
        homeNavigationController.tabBarItem = uiTabBarItem
        self.add(childCoordinator: homeCoordinator)
        tabBarViewControllers.append(homeNavigationController)
        
        tabBarController.viewControllers = tabBarViewControllers
        
        UIApplication.shared.appCoordinator?.changeRootViewController(tabBarController)
    }
}
