//
//  NewsCell.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dataNews: UILabel!
    static public let newsCellID = "NewsCellID"
    
    private var imageDownloaderTask: URLSessionDataTask?
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloaderTask?.cancel()
        imageDownloaderTask = nil
        imageCell.image = nil
    }
    
    func present(_ news: NewsModel) {
        titleNews.text = news.title
        
        if let imageUrl = news.imageUrl {
            imageDownloaderTask = ImageDownloadManager.downloadImage(url: imageUrl) { [weak self] (result) in
                switch result {
                case .success(let image):
                    self?.imageCell.image = image
                case .failure(_):
                    break
                }
            }
        }
        
        if let date = news.publishedAt {
            dataNews.text = dateFormatter.string(from: date)
        }
    }
    
}
