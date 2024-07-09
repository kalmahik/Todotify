//
//  String+Extensions.swift
//  Todotify
//
//  Created by Murad Azimov on 20.06.2024.
//

import CocoaLumberjackSwift
import Foundation

extension String {
    // этот метод делит текст на части, используя регулярку
    static func splitTextByRegex(text: String, regexPattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            let ranges = results.map { $0.range }

            var lastIndex = 0
            var substrings: [String] = []

            for range in ranges {
                let start = nsString.substring(with: NSRange(location: lastIndex, length: range.location - lastIndex))
                substrings.append(start)
                lastIndex = range.location + range.length
            }

            if lastIndex < nsString.length {
                let end = nsString.substring(with: NSRange(location: lastIndex, length: nsString.length - lastIndex))
                substrings.append(end)
            }

            if nsString.length > 0 && ranges.last?.location == nsString.length - 1 {
                substrings.append("")
            }

            return substrings

        } catch let error {
            DDLogWarn("\(error.localizedDescription)")
            return []
        }
    }
}
