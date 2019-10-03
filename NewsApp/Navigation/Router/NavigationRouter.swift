//
//  NavigationRouter.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

final class NavigationRouter: NSObject {
    fileprivate weak var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        super.init()
    }
    
    var toPresent: UIViewController? {
        return rootController
    }
}

// MARK:- Routable
extension NavigationRouter: NavigationRoutable {
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, animated: false)
    }
    
    func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: animated)
    }
    
    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        guard let controller = module?.toPresent else { return }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        rootController?.popViewController(animated: animated)
    }
    
    func popToRootModule(animated: Bool) {
        rootController?.popToRootViewController(animated: animated)
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func cleanStack() {
        rootController?.viewControllers = []
    }
}

