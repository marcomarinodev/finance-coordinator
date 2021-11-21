//
//  ArticleCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation
import UIKit

final class ArticleCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var homeViewController: HomeViewController?
    var articleViewController: ArticleViewController?
    var articleNavigationViewController: UINavigationController?
    
    func start(from viewController: HomeViewController, with news: News) {
        
        self.homeViewController = viewController
        
        let articleViewController = ArticleViewController.instantiate()
        articleViewController.coordinatorDelegate = self
        articleViewController.article = news
        self.articleViewController = articleViewController
        
//        let articleNavigationViewController = articleViewController.embeddedInDarkNavigationController
//        self.articleNavigationViewController = articleNavigationViewController
//        viewController.present(articleNavigationViewController, animated: true, completion: nil)
        
        viewController.show(articleViewController, sender: nil)
    }
    
}

extension ArticleCoordinator: ArticleViewControllerDelegate {
    func articleViewControllerWillDismiss(_ articleViewController: ArticleViewController) {
        resetCoordinatorsStack()
    }
}
