//
//  UIApplicationExtension.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    var appCoordinator: AppCoordinator? {
        return (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator
    }
    
//    var tabBarCoordinator: TabBarCoordinator? {
//        return appCoordinator?.search(type: TabBarCoordinator.self)
//    }
}
