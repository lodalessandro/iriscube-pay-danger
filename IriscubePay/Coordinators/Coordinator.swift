//
//  Coordinator.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation


protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    
    var presentedCoordinator: Coordinator? { get }
    
    var parentCoordinator: Coordinator? { get set }
}


extension Coordinator {
    
    /// Add a child coordinator to the parent
    func add(childCoordinator: Coordinator) {
        childCoordinator.parentCoordinator = self
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator from the parent
    func remove(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
    /// Reset the coordinator stack
    func resetCoordinatorsStack() {
        self.childCoordinators = []
    }
    
    func removeFromParentCoordinator() {
        parentCoordinator?.remove(childCoordinator: self)
    }
    
    
    func search<T: Coordinator>(type:  T.Type) -> T? {
        
        if self is T {
            return (self as! T)
        }
        
        for child in childCoordinators {
            if let found = child.search(type: type) {
                return found
            }
        }
        return nil
    }
    
    var presentedCoordinator: Coordinator? {
        return childCoordinators.last
    }
}



protocol CoordinatorDelegate: class {
    func coordinatorDidDismiss(_ coordinator: Coordinator)
    func coordinatorDidFinish(_ coordinator: Coordinator)
}


extension CoordinatorDelegate where Self: Coordinator {
    func coordinatorDidDismiss(_ coordinator: Coordinator) {
        self.remove(childCoordinator: coordinator)
    }
    
    func coordinatorDidFinish(_ coordinator: Coordinator) {
        self.remove(childCoordinator: coordinator)
    }
}
