//
//  DeviceUtils.swift
//  Todotify
//
//  Created by Murad Azimov on 27.06.2024.
//

import Foundation

struct DeviceUtils {
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
