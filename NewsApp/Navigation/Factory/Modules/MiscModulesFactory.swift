//
//  MiscModulesFactory.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 31/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation
import SafariServices

protocol MiscModulesFactory {
    func makeSafariView(url: URL) -> SFSafariViewController
}
