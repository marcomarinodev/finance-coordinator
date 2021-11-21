//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import UIKit
import Reusable

protocol TabBarViewControllerDelegate: AnyObject {
    func tabBarViewControllerDidTapHome(_ tabBarViewController: TabBarViewController)
    func tabBarViewControllerDidTapFinance(_ tabBarViewController: TabBarViewController)
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    weak var coordinatorDelegate: TabBarViewControllerDelegate?
    
    var controllers: [UIViewController] = [] {
        didSet {
            guard isViewLoaded, oldValue != controllers else { return }
            setupTabBar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        delegate = self
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.unselectedItemTintColor = .gray
        
        for selectedViewController in controllers {
            switch (selectedViewController as? UINavigationController)?.viewControllers.first {
            case is HomeViewController:
                selectedViewController.tabBarItem.title = "Home"
                selectedViewController.tabBarItem.image = UIImage(systemName: "newspaper")
                selectedViewController.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")
            case is FinanceViewController:
                selectedViewController.tabBarItem.title = "Finance"
                selectedViewController.tabBarItem.image = UIImage(systemName: "eurosign.circle")
                selectedViewController.tabBarItem.selectedImage = UIImage(systemName: "eurosign.circle.fill")
            default:
                break
            }
        }
        
        /// TODO: - UI Setup right here...
        
        viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        switch (viewController as? UINavigationController)?.viewControllers.first {
        case is HomeViewController:
            coordinatorDelegate?.tabBarViewControllerDidTapHome(self)
        case is FinanceViewController:
            coordinatorDelegate?.tabBarViewControllerDidTapFinance(self)
        default:
            break
        }
        
    }
    
}

extension TabBarViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
}

