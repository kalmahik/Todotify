//
//  CocoaLogger.swift
//  Todotify
//
//  Created by Murad Azimov on 08.07.2024.
//

import CocoaLumberjackSwift
import Foundation

class Logger: NSObject, DDLogFormatter {
    let dateFormatter = ISO8601DateFormatter()

    func format(message logMessage: DDLogMessage) -> String? {
        let timestamp = dateFormatter.string(from: logMessage.timestamp)
        let logLevel = logMessage.level
        let logText = logMessage.message
        return "\(timestamp) [\(logLevel)] - \(logText)"
    }
}
