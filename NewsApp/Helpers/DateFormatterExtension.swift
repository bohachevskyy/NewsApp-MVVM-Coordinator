//
//  DateFormatterExtension.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 31/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
