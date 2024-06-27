//
//  Date+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

extension Date {
    static func fromString(_ date: String?) -> Date? {
        guard let date else { return nil }
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: date)
    }
    
    func asString() -> String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }
    
    func asHumanString() -> String {
        let dateFormatter = DateFormatter()
        let ident = DeviceUtils.getPreferredLocale().identifier
        dateFormatter.locale = Locale(identifier: ident)
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
