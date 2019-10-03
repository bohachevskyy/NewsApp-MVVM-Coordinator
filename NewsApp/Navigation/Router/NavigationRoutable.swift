//
//  NavigationRoutable.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

protocol NavigationRoutable: Presentable {
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    
    func popModule()
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func cleanStack()
}
