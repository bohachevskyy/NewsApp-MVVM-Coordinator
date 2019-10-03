//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 10/3/19.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

final class NewsViewModel {
    typealias State = ViewModeState<[NewsModel]>
    
    var state: State = .empty {
        didSet { onStateChange?(state) }
    }
    
    // MARK: Internal properties
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var gotAllPages: Bool = false
    
    // MARK: Callbacks
    var onSelection: ((NewsModel) -> ())?
    var onError: ((String) -> ())?
    var onStateChange: ((State) -> ())?
    var onCancel: CompletionBlock?
    
    // MARK: Lifecycle
    let newsService: NewsService
    
    // MARK: Constants
    static private let newsPerPage: Int = 20
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
}

// MARK: - User Actions
extension NewsViewModel {
    func didScrollToBottom() {
        guard gotAllPages == false else { return }
        getNews(nextPage: true)
    }
    
    func refresh() {
        getNews(nextPage: false)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard state.data?.count ?? 0 > indexPath.row else { return }
        guard let model = state.data?[indexPath.row] else { return }
        onSelection?(model)
    }
}

// MARK: - Search
private extension NewsViewModel {
    func getNews(nextPage: Bool) {
        guard !isLoading else { return }
        
        isLoading = true
        
        if state == .empty {
            state = .loading
        }
        
        if !nextPage {
            currentPage = 0
            gotAllPages = false
        }
        
        newsService.getNews(page: currentPage + 1) { [weak self] (result) in
            switch result {
            case .failure(let error):
                if !nextPage {
                    self?.state = .empty
                }
                self?.onError?(error.localizedDescription)
            case .success(let news):
                if nextPage {
                    let currentData = self?.state.data ?? []
                    self?.state = .withData(data: currentData + news)
                } else {
                    self?.state = .withData(data: news)
                }
                
                self?.currentPage += 1
                
                if news.count < NewsViewModel.newsPerPage {
                    self?.gotAllPages = true
                }
            }
            
            self?.isLoading = false
        }
    }
}
