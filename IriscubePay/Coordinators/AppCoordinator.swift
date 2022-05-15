//
//  AppCoordinator.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    private(set) weak var window: UIWindow?
    
    
    init(window: UIWindow) {
        super.init()
        
        self.window = window
    }
    
    func start(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }
        
        // present the first screen
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.start(from: window)
        add(childCoordinator: loginCoordinator)
        
        return true
    }
    
    func changeRootViewController(_ viewController: UIViewController) {
        guard let window = self.window else { return }
        
        // change the root view controller to a specific view controller
        window.rootViewController = viewController
        
        // animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromRight],
                          animations: nil,
                          completion: nil)
    }
}
