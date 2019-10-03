//
//  MainModulesFactory.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

protocol MainModulesFactory {
    func makeNewsFeedView() -> NewsVC
    func makeNewsDetailView(news: NewsModel) -> NewsDetailVC
}
