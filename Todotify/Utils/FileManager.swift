//
//  FileManager.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

enum FileManagerError: Error {
    case fileNotFound
    case fileAlreadyExist
    case error(String)
}

extension FileManager {
    static func getFile(name: String) -> URL? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(name)
            return fileURL
        }
        return nil
    }
    
    static func isFileExist(name: String) -> Bool {
        if let fileURL = getFile(name: name) {
            return FileManager.default.fileExists(atPath: fileURL.path)
        } else {
            return false
        }
    }
}
