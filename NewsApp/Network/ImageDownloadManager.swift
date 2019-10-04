//
//  ImageDownloadManager.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 9/30/19.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

final class ImageDownloadManager {
    static private var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @discardableResult
    static func downloadImage(url urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(.success(cachedImage))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result: Result<UIImage, Error>
            
            if let error = error {
                result = .failure(error)
            } else if let data = data,
                let image = UIImage(data: data) {
                result = .success(image)
            } else {
                result = .failure(NetworkError.invalidURL)
            }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                case .failure(_):
                    break
                }
                
                completion(result)
            }
        }
        
        task.resume()
        return task
    }
}
