//
//  FinanceCoordiantor.swift
//  NewsApp
//
//  Created by Marinò, Marco on 12/11/21.
//

import Foundation

final class FinanceCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var tabBarViewController: TabBarViewController?
    var financeViewController: FinanceViewController?
    
    func start(from tabBarViewController: TabBarViewController, with financeViewController: FinanceViewController) {
        
        tabBarViewController.coordinatorDelegate = self
        self.tabBarViewController = tabBarViewController
        
        financeViewController.coordinatorDelegate = self
        self.financeViewController = financeViewController
    }
    
}

extension FinanceCoordinator: FinanceViewControllerDelegate {
    
    func financeViewControllerDidTapDetails(_ financeViewController: FinanceViewController, stockName: String) {
        
        // instantiate its coordinator
        let stockDetailCoordinator = StockDetailCoordinator()
        
        // run its coordinator
        stockDetailCoordinator.start(from: financeViewController, with: stockName)
        
        // add it to childCoordinators
        self.add(childCoordinator: stockDetailCoordinator)
        
    }
    
    func financeViewControllerDidQuery(_ financeViewController: FinanceViewController, query: String) {
        
        FinanceClient.getStocks(query: query) { response in
            switch response {
            case .success(let stocks):
                financeViewController.stocks = stocks
            case .failure(let failure):
                print(failure)
                break
            }
        }
        
    }
}

extension FinanceCoordinator: TabBarViewControllerDelegate {
    func tabBarViewControllerDidTapHome(_ tabBarViewController: TabBarViewController) {
        if let tabBarCoordinator = getIfExist(type: TabBarCoordinator.self) {
            guard let homeViewController = tabBarCoordinator.homeViewController else { return }
            if let homeCoordinator = tabBarCoordinator.search(type: HomeCoordinator.self) {
                homeCoordinator.removeFromParentCoordinator()
                tabBarCoordinator.add(childCoordinator: homeCoordinator)
            }
            else {
                let homeCoordinator = HomeCoordinator()
                homeCoordinator.start(from: tabBarViewController, with: homeViewController)
                add(childCoordinator: homeCoordinator)
            }
        }
    }
    
    func tabBarViewControllerDidTapFinance(_ tabBarViewController: TabBarViewController) {
        //
    }
    
    
}
