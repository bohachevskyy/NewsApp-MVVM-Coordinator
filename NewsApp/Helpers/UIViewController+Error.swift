//
//  UIViewController+Error.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 10/3/19.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
