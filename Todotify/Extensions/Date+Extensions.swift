//
//  Date+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

extension Date {
    static let calendarFormatCell = "dd MMM"
    static let zeroDay = Date(timeIntervalSince1970: 0)

    static func fromString(_ date: String?) -> Date? {
        guard let date else { return nil }
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: date)
    }

    func asString() -> String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }

    func asHumanString(format: String? = nil, style: DateFormatter.Style? = .medium) -> String {
        let dateFormatter = DateFormatter()
        let ident = DeviceUtils.getPreferredLocale().identifier
        dateFormatter.locale = Locale(identifier: ident)
        if let format {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateStyle = .medium
        }
        return dateFormatter.string(from: self)
    }
}
