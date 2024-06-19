//
//  FileManager.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

extension FileManager {
    static func getFile(name: String) -> URL? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(name)
            return fileURL
        }
        return nil
    }
}
