//
//  Constants.swift
//  Notes Clone
//
//  Created by Мария Васильева on 06.03.2023.
//

import Foundation

enum Constants {
    static let notesCellIdentifier = "NotesCell"

    static let createNewNoteSegueId = "createNewNote"
    static let editNoteSegueId = "editNote"
    
    static let notesUserDefaultsKey = "MY_NOTES"
    static let notFirstRunUserDefaultsKey = "IS_NOT_FIRST_RUN"
    
    static let secondsInDay = 86400.0
    static let secondsInWeek = secondsInDay * 7
}
