//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinatable {
    let window: UIWindow
    let modulesFactory: MainModulesFactory & MiscModulesFactory
    
    lazy var navigationController: UINavigationController = UINavigationController()
    lazy var splitController: UISplitViewController = UISplitViewController()
    
    lazy var router: NavigationRoutable = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return SplitRouter(rootController: splitController)
        } else {
            return NavigationRouter(rootController: navigationController)
        }
    }()
    
    init(window: UIWindow, modulesFactory: MainModulesFactory & MiscModulesFactory) {
        self.window = window
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        window.rootViewController = router.toPresent
        window.makeKeyAndVisible()
        showSearchView()
    }
}

// MARK: - Show Views
extension AppCoordinator {
    func showSearchView() {
        let view = modulesFactory.makeNewsFeedView()
        router.setRootModule(view)
        
        view.viewModel.onSelection = { [weak self] (news) in
            self?.showDetailView(news: news)
        }
    }
    
    func showDetailView(news: NewsModel) {
        let view = modulesFactory.makeNewsDetailView(news: news)
        router.push(view)
        
        view.viewModel.onOpenExternalResource = { [weak self] (url) in
            self?.presentSafariView(url: url)
        }
    }
}

extension AppCoordinator {
    func presentSafariView(url: URL) {
        let view = modulesFactory.makeSafariView(url: url)
        view.modalPresentationStyle = .overFullScreen
        router.present(view)
    }
}

