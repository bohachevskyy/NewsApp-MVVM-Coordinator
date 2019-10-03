//
//  CoordinatorFactory.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    let modulesFactory = ModulesFactory()
}

extension CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window, modulesFactory: modulesFactory)
    }
}
