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
        
        for selectedViewController in controllers {
            switch (selectedViewController as? UINavigationController)?.viewControllers.first {
            case is HomeViewController:
                selectedViewController.tabBarItem.image = UIImage(systemName: "newspaper")
                selectedViewController.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")
            case is FinanceViewController:
                selectedViewController.tabBarItem.image = UIImage(systemName: "eurosign.circle")
                selectedViewController.tabBarItem.selectedImage = UIImage(systemName: "eurosign.circle.fill")
            default:
                break
            }
        }
        
        /// TODO: - UI Setup right here...
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 15, y: 0, width: view.frame.width - 30, height: tabBar.frame.height + 10), cornerRadius: 25).cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.systemGreen.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 20
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.7
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.unselectedItemTintColor = .systemGray6
        tabBar.tintColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
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

