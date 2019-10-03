//
//  RecipeAPIRouter.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

enum NewsAPIRouter: NetworkRoutable {
    case getNews(page: Int)
    
    var host: String { return "newsapi.org" }
    
    var path: String {
        switch self {
        case .getNews(_):
            return "/v2/top-headlines"
        }
    }
    
    var httpMethod: String { return "GET" }
    
    var authenticationQueryParameterers: Parameters? {
        return ["apiKey": "e2c24d143b504040bf1b6c959592d16e"]
    }
    
    var queryParameters: Parameters? {
        switch self {
        case .getNews(let page):
            return ["page": page, "language": "en"]
        }
    }
    
    var bodyParameters: Parameters? { return nil }
    
    var headers: Headers? { return nil }
}
