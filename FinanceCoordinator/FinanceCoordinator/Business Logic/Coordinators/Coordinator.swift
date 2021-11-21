//
//  Coordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import UIKit

protocol Coordinator: AnyObject {
    
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
    
    /// To improved with a specialized algorithm
    func getIfExist<T: Coordinator>(type: T.Type) -> T? {
        
        if self is T {
            return (self as! T)
        }
        else if let parentCoordinator = parentCoordinator {
            return parentCoordinator.getIfExist(type: type)
        }
        
        // if there's not any parentCoordinator exit
        
        return nil
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
