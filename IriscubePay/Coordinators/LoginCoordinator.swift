//
//  LoginCoordinator.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    func start(from window: UIWindow) {
        
        let loginViewController = LoginViewController()
        loginViewController.coordinatorDelegate = self
        
        let navigationController = loginViewController.embeddedInClearNavigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginViewController(_ loginViewController: LoginViewController, didEnterAgentCode code: String) {
        let tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator.start()
    }
}
