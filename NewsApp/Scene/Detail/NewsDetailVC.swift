//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController, StoryboardLoadable {
    typealias ViewModelType = NewsModel
    var viewModel: NewsModel!
    
    @IBOutlet private weak var imageDetail: UIImageView!
    @IBOutlet private weak var titleNews: UILabel!
    @IBOutlet private weak var descNews: UILabel!
    @IBOutlet private weak var dataNews: UILabel!
    
    var newsModel: NewsModel?
    var onOpenExternalResource: ((URL) -> Void)?
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsModel?.title ?? "Detail News"
        titleNews.text = newsModel?.title
        descNews.text = newsModel?.desc
        
        if let imageUrl = newsModel?.imageUrl {
            ImageDownloadManager.downloadImage(url: imageUrl) { [weak self] (result) in
                switch result {
                case .success(let image):
                    self?.imageDetail.image = image
                case .failure(_):
                    break
                }
            }
        }
        
        if let date = newsModel?.publishedAt { dataNews.text = dateFormatter.string(from: date) }
    }
    
    @IBAction private func openDidTap(_ sender: Any) {
        if let contentUrl = newsModel?.contentUrl {
            onOpenExternalResource?(contentUrl)
        }
    }
    
}
