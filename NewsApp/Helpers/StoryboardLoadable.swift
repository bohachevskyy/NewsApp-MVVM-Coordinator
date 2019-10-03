//
//  StoryboardLoadable.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {
    static var identifier: String { get }
    static var storyboardName: String { get }
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var storyboardName: String {
        return "Main"
    }
    
    static func loadFromStoryboard() -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
