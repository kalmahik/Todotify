////
////  TodoItem+Extensions.swift
////  Todotify
////
////  Created by kalmahik on 17.06.2024.
////
//
//import Foundation
//
//typealias JsonDictionary = [String: Any]
//
//extension TodoItem {
//
//    
//    static func parse(csv: Any) -> TodoItem? {
//
//            //locate the file you want to use
//            guard let filepath = Bundle.main.path(forResource: "data", ofType: "csv") else {
//                return
//            }
//
//            //convert that file into one long string
//            var data = ""
//            do {
//                data = try String(contentsOfFile: filepath)
//            } catch {
//                print(error)
//                return
//            }
//
//            //now split that string into an array of "rows" of data.  Each row is a string.
//            var rows = data.components(separatedBy: "\n")
//
//            //if you have a header row, remove it here
//            rows.removeFirst()
//
//            //now loop around each row, and split it into each of its columns
//            for row in rows {
//                let columns = row.components(separatedBy: ",")
//
//                //check that we have enough columns
//                if columns.count == 4 {
//                    let firstName = columns[0]
//                    let lastName = columns[1]
//                    let age = Int(columns[2]) ?? 0
//                    let isRegistered = columns[3] == "True"
//
//                    
//                    let id = jsonObject[CodingKeys.id.stringValue] as? String
//                    let text = jsonObject[CodingKeys.text.stringValue] as? String
//                    let isCompleted = jsonObject[CodingKeys.isCompleted.stringValue] as? Bool
//                    let createdAt = jsonObject[CodingKeys.createdAt.stringValue] as? String
//                    let deadline = jsonObject[CodingKeys.deadline.stringValue] as? String
//                    let editedAt = jsonObject[CodingKeys.editedAt.stringValue] as? String
//                    let importanceString = jsonObject[CodingKeys.importance.stringValue] as? String ?? Importance.usual.rawValue
//                    let importance = Importance(rawValue: importanceString) ?? Importance.usual
//                    
//                    return TodoItem(){}
//                }
//            }
//        }
//}
