//
//  NoteDetailViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import Foundation

import Combine

class NoteDetailViewModel: ObservableObject {
    @Published var notes: [Note] = []

    func addNote(title: String, content: String) {
        let newNote = Note(id: UUID(), title: title, content: content)
        notes.append(newNote)
    }

    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
    }
}
