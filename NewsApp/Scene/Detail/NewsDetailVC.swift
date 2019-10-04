//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController, StoryboardLoadable {
    typealias ViewModelType = NewsDetailViewModel
    var viewModel: NewsDetailViewModel!
    
    @IBOutlet private weak var imageDetail: UIImageView!
    @IBOutlet private weak var titleNews: UILabel!
    @IBOutlet private weak var descNews: UILabel!
    @IBOutlet private weak var dateNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        titleNews.text = viewModel.title
        descNews.text = viewModel.newsDescription
        dateNews.text = viewModel.newsDete
        
        ImageDownloadManager.downloadImage(url: viewModel.imageURL) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.imageDetail.image = image
            case .failure(_):
                break
            }
        }
    }
    
    @IBAction private func openDidTap(_ sender: Any) {
        viewModel.didTapOriginal()
    }
    
}
