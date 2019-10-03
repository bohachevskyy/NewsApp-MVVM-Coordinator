//
//  NewsServiceImpl
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

final class NewsServiceImpl: NewsService {
    func getNews(page: Int, completion: @escaping (Result<NewsResponse, Error>) -> ()) {
        HTTPClient.request(requestConvertible: NewsAPIRouter.getNews(page: page), completion: completion)
    }
}
