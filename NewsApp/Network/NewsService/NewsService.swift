//
//  NewsService.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

protocol NewsService {
    func getNews(page: Int, completion: @escaping (Result<[NewsModel], Error>) -> ())
}
