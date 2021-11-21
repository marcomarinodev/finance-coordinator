//
//  TabBarCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var tourViewController: TourViewController?
    var tabBarViewController: TabBarViewController?
    var homeViewController: HomeViewController?
    var homeNavigationViewController: UINavigationController?
    var financeViewController: FinanceViewController?
    var financeNavigationViewController: UINavigationController?
    
    func start(from tourViewController: TourViewController) {
        
        let tabBarViewController = TabBarViewController.instantiate()
        self.tabBarViewController = tabBarViewController
        
        self.tourViewController = tourViewController
        
        // Instantiate view controllers (tabs)
        let homeViewController = HomeViewController.instantiate()
        
        self.homeViewController = homeViewController
        let homeNavigationViewController = homeViewController.embeddedInDarkNavigationController
        self.homeNavigationViewController = homeNavigationViewController
        
        let financeViewController = FinanceViewController.instantiate()
        self.financeViewController = financeViewController
        let financeNavigationViewController = financeViewController.embeddedInDarkNavigationController
        self.financeNavigationViewController = financeNavigationViewController
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start(from: tabBarViewController, with: homeViewController)
        self.add(childCoordinator: homeCoordinator)
        
        let tabBarControllers = [homeNavigationViewController, financeNavigationViewController]
        
        /**
         in tabBarControllers metto i nav navigazione stile instagram in cui non scompare la tab bar al push della view
         in caso in cui non voglio la tab bar inserisco il view controller senza navigation
         */
        tabBarViewController.controllers = tabBarControllers
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        tourViewController.present(tabBarViewController, animated: true, completion: nil)
        
    }
    
}
