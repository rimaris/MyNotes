//
//  ViewController.swift
//  Notes Clone
//
//  Created by Мария Васильева on 05.03.2023.
//

import UIKit

class NotesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var repository: Repository = UserDefaultsRepository()
    @IBOutlet weak var notesCountItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        repository.delegate = self
        
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        
        updateNotesCount()
        repository.createFirstNoteIfFirstRun()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }
        tableView.deselectRow(at: selectedIndexPath, animated: true)
        
    }
    
    func updateNotesCount() {
        let notesCount = notes.count
        let lastNumber = notesCount % 10
        var countText: String
        if lastNumber == 0 || 5 <= lastNumber && lastNumber <= 9 || (10 <= notesCount && notesCount <= 19) {
            countText = "заметок"
        } else if lastNumber == 1 {
            countText = "заметка"
        } else {
            countText = "заметки"
        }
        notesCountItem.title = "\(notesCount) \(countText)"
    }
}

//MARK: - Notes storage
extension NotesListViewController {
    var notes: [Note] {
        get {
            return repository.getNotes()
            
        }
    }
}

//MARK: - UITableViewDelegate
extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.delete(note: notes[indexPath.row])
        }
    }
}

//MARK: - UITableViewDataSource
extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notesCellIdentifier, for: indexPath) as? NoteCellView else {
            fatalError("Cannot dequeue \(Constants.notesCellIdentifier)")
        }
        cell.note = notes[indexPath.row]
        return cell
    }
}

//MARK: - Navigation
extension NotesListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.editNoteSegueId:
            let sender = sender as? NoteCellView
            let destination = segue.destination as? EditNoteViewController
            destination?.note = sender?.note
            destination?.repository = repository
        case Constants.createNewNoteSegueId:
            let destination = segue.destination as? EditNoteViewController
            destination?.repository = repository
            destination?.createNewNote()
        default:
            return
        }
    }
}

//MARK: - RepositoryDelegate
extension NotesListViewController: RepositoryDelegate {
    func repositoryDidUpdateNotes() {
        tableView.reloadData()
        updateNotesCount()
    }
}
