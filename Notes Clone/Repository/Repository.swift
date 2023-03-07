//
//  Repository.swift
//  Notes Clone
//
//  Created by Мария Васильева on 07.03.2023.
//

import Foundation

protocol RepositoryDelegate: AnyObject {
    func repositoryDidUpdateNotes()
}

protocol Repository {
    func getNotes() -> [Note]
    func update(note: Note)
    func delete(note: Note)
    func createFirstNoteIfFirstRun()
    var delegate: RepositoryDelegate? { get set }
}
