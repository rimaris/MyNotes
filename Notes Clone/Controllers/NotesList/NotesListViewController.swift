//
//  ViewController.swift
//  Notes Clone
//
//  Created by Мария Васильева on 05.03.2023.
//

import UIKit

class NotesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
    }
}

//MARK: - Notes storage
extension NotesListViewController {
    var notes: [Note] {
        get {
            return [
                Note(title: "Список покупок", body: "1. Бананы"),
                Note(title: "Задачи", body: "Учеба"),
                Note(title: "work", body: "task 1"),
                Note(title: "Cooking", body: "pancakes")
            ]
        }
    }
}

//MARK: - UITableViewDelegate
extension NotesListViewController: UITableViewDelegate {
    
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
        default:
            return
        }
    }
}
