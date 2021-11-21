//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 12/11/21.
//

import Foundation

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var tabBarViewController: TabBarViewController?
    var homeViewController: HomeViewController?
    
    func start(from tabBarViewController: TabBarViewController, with homeViewController: HomeViewController) {
        
        tabBarViewController.coordinatorDelegate = self
        self.tabBarViewController = tabBarViewController
        
        homeViewController.coordinatorDelegate = self
        fetchWorldNews(homeViewController)
        
        self.homeViewController = homeViewController
        
    }
    
    private func fetchWorldNews(_ homeViewController: HomeViewController) {
        
        NewsClient.getWorldNews(siteID: BaseURL.NYTIMES.description) { response in
            switch response {
            case .success(let news):
                homeViewController.news = news.results
            case .failure(let failure):
                print(failure)
                break
            }
            
        }
    }
    
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidTapNews(_ homeViewCottroller: HomeViewController, news: News) {
        
        let newsDetailCoordinator = ArticleCoordinator()
        newsDetailCoordinator.start(from: homeViewCottroller, with: news)
        self.add(childCoordinator: newsDetailCoordinator)
    }
}

extension HomeCoordinator: TabBarViewControllerDelegate {
    func tabBarViewControllerDidTapHome(_ tabBarViewController: TabBarViewController) {
        //
    }
    
    func tabBarViewControllerDidTapFinance(_ tabBarViewController: TabBarViewController) {
        if let tabBarCoordinator = getIfExist(type: TabBarCoordinator.self) {
            guard let financeViewController = tabBarCoordinator.financeViewController else { return }
            if let financeCoordinator = tabBarCoordinator.search(type: FinanceCoordinator.self) {
                financeCoordinator.removeFromParentCoordinator()
                tabBarCoordinator.add(childCoordinator: financeCoordinator)
            }
            else {
                let financeCoordinator = FinanceCoordinator()
                financeCoordinator.start(from: tabBarViewController, with: financeViewController)
                add(childCoordinator: financeCoordinator)
            }
        }
    }
}
