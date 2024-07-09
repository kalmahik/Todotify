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
    static func getFileURL(name: String) throws -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileManagerError.error("DOCUMENTS DIRECTORY DON'T EXIST")
        }
        return dir.appendingPathComponent(name)
    }

    static func isFileExist(name: String) -> Bool {
         do {
             let fileURL = try getFileURL(name: name)
             return FileManager.default.fileExists(atPath: fileURL.path)
         } catch {
             return false
         }
     }
}
