//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private(set) weak var window: UIWindow?
    
    init(window: UIWindow) { self.window = window }
    
    func start(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let window = window else { return false }
        
        let tourCoordinator = TourCoordinator()
        tourCoordinator.start(from: window)
        self.add(childCoordinator: tourCoordinator)
        
        return true
    }
}

// MARK: - App lifecycle
extension AppCoordinator {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // ...
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // ...
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // ...
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // ...
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // ...
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // ...
    }
    
}
