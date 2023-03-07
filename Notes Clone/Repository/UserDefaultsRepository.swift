//
//  UserDefaultsRepository.swift
//  Notes Clone
//
//  Created by Мария Солодова on 07.03.2023.
//

import Foundation

struct EncodedNotes: Codable {
    var notes: [Note]
}


class UserDefaultsRepository: Repository {
    weak var delegate: RepositoryDelegate?
    
    private let userDefaults = UserDefaults.standard
    func getNotes() -> [Note] {
        guard let data = userDefaults.object(forKey: Constants.notesUserDefaultsKey) as? Data else { return [] }
        do {
            let loadedData = try JSONDecoder().decode(EncodedNotes.self, from: data)
            return loadedData.notes
        } catch {
            return []
        }
    }
    
    func delete(note: Note) {
        var notes = getNotes()
        let foundIndex = findNoteIndex(notes: notes, note: note)
        guard let foundIndex = foundIndex else {
            print("note not found")
            return
        }
        notes.remove(at: foundIndex)
    }
    
    func update(note: Note) {
        var notes = getNotes()
        let foundIndex = findNoteIndex(notes: notes, note: note)
        guard let foundIndex = foundIndex else {
            notes.append(note)
            saveNotes(notes: notes)
            return
        }
        notes[foundIndex] = note
        saveNotes(notes: notes)
    }
    
    private func findNoteIndex(notes: [Note], note: Note) -> Int? {
        for (i, existingNote) in notes.enumerated() {
            if existingNote.id == note.id {
                return i
            }
        }
        return nil
    }
    
    private func saveNotes(notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(EncodedNotes(notes: notes))
            userDefaults.set(data, forKey: Constants.notesUserDefaultsKey)
            
        } catch {
            print("Error saving data")
            print(error)
            return
        }
        delegate?.repositoryDidUpdateNotes()
    }
    
}
