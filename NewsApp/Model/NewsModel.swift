//
//  NewsModel.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

class NewsModel: Codable {
    let title: String?
    let desc: String?
    let publishedAt: Date?
    let imageUrl: String?
    private let contentLink: String?
    
    var contentUrl: URL? {
        if let contentLink = contentLink {
            return URL(string: contentLink)
        }
        
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case desc = "description"
        case imageUrl = "urlToImage"
        case contentLink = "url"
        case publishedAt
        case title
    }
}

struct NewsResponse: Codable {
    let articles: [NewsModel]
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case articles
        case totalResults
    }
}
