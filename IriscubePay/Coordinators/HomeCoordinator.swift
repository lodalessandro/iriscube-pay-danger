//
//  HomeCoordinator.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 03/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    func start() -> UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.coordinatorDelegate = self
        let navigationController = homeViewController.embeddedInClearNavigationController

        return navigationController
    }
    
}

extension HomeCoordinator: HomeViewControllerDelegate {
    
}
