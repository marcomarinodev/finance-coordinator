//
//  NavigationController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    var embeddedInDarkNavigationController: UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [self]
        navigationController.navigationBar.tintColor = .systemGreen
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemGreen]
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemGreen]
    
        return navigationController
    }
}
