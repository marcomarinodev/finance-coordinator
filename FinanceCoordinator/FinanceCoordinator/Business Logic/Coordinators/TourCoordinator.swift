//
//  TourCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import Foundation
import UIKit

final class TourCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var tourViewController: TourViewController?
    
    func start(from window: UIWindow) {
        
        let tourViewController = TourViewController.instantiate()
        
        self.tourViewController = tourViewController
        self.tourViewController?.coordinatorDelegate = self

        window.rootViewController = tourViewController
        window.makeKeyAndVisible()
        
    }
    
}

extension TourCoordinator: TourViewControllerDelegate {
    func tourViewControllerDidTapNext(_ tourViewController: TourViewController) {
        let tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator.start(from: tourViewController)
        self.add(childCoordinator: tabBarCoordinator)
    }
}
