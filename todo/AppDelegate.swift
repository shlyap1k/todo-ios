//
//  AppDelegate.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let router = RouterImpl(navigationController: navigationController)
        let initialViewController = TodoListViewController(viewModel: .init(router: router))
        
        navigationController.viewControllers = [initialViewController]

        window.backgroundColor = .white
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
