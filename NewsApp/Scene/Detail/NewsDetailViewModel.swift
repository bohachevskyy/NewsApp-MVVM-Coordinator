//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 10/4/19.
//  Copyright © 2019 Valeria Felindash. All rights reserved.
//

import Foundation

final class NewsDetailViewModel {
    typealias State = ViewModeState<NewsModel>
    
    // MARK: View properties
    var state: State = .empty
    
    var title: String {
        return newsModel.title ?? ""
    }
    
    var imageURL: String {
        return newsModel.imageUrl ?? ""
    }
    
    var newsDescription: String {
        return newsModel.desc ?? ""
    }
    
    var newsDete: String {
        if let date = newsModel.publishedAt {
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    // MARK: Callbacks
    var onOpenExternalResource: ((URL) -> ())?
    
    // MARK: Lifecycle
    let newsModel: NewsModel
    
    init(newsModel: NewsModel) {
        self.newsModel = newsModel
        state = .withData(data: newsModel)
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}

// MARK: - User actions
extension NewsDetailViewModel {    
    func didTapOriginal() {
        if let url = newsModel.contentUrl {
            onOpenExternalResource?(url)
        }
    }
}

