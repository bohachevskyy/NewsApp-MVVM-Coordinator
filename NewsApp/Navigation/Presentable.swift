//
//  Presentable.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
