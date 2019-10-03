//
//  URLParameterEncoder.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

struct URLParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.invalidURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters.map({ (key, value) -> URLQueryItem in
                let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return URLQueryItem(name: key, value: encodedValue)
            })
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
