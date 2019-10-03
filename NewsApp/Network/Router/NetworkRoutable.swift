//
//  NetworkRoutable.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

protocol NetworkRoutable: URLRequestCovertible {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var authenticationQueryParameterers: Parameters? { get }
    var queryParameters: Parameters? { get }
    var bodyParameters: Parameters? { get }
    var headers: Headers? { get }
}

private extension NetworkRoutable {
    var baseURL: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
}

extension NetworkRoutable {
    var scheme: String { return "https" }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        try ParameterEncoding.encode(urlRequest: &urlRequest,
                                     urlAuthParameters: authenticationQueryParameterers,
                                     urlParameters: queryParameters,
                                     bodyParameters: bodyParameters)
        
        urlRequest.httpMethod = httpMethod
        
        headers?.forEach({ (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        return urlRequest
    }
}
