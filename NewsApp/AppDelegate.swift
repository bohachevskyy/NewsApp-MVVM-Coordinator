//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var appCoordinator: Coordinatable = {
        window = UIWindow()
        return CoordinatorFactory().makeAppCoordinator(window: window!)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()
        return true
    }

}

