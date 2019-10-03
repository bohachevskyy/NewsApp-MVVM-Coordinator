//
//  URLRequestCovertible.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

protocol URLRequestCovertible {
    func asURLRequest() throws -> URLRequest
}

typealias Parameters = [String: Any]
typealias Headers = [String: String]
typealias CompletionBlock = (() -> ())
