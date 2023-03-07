//
//  EditNoteViewController.swift
//  Notes Clone
//
//  Created by Мария Васильева on 06.03.2023.
//

import UIKit

class EditNoteViewController: UIViewController {
    var note: Note?
    var repository: Repository?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        titleTextField.delegate = self
        
        initToolbar()
        setupKeyboardNotificationListeners()
        
        updateTitleTextField(title: note?.title)
        updateTextView(text: note?.body)
    }
    
    func createNewNote() {
        note = Note(title: "", body: "")
    }
    
    private func updateTitleTextField(title: String?) {
        guard let title = title else { return }
        titleTextField.text = title
    }
    
    private func updateTextView(text: String?) {
        guard let text = text else { return }
        textView.text = text
    }
    
    private func saveNoteIfNeeded() {
        guard let note = note else {
            return
        }
        note.updateDate = Date()
        repository?.update(note: note)
    }
}

//MARK: - Toolbar

extension EditNoteViewController {
    private func initToolbar() {
        let toolbar = UIToolbar()
            toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style:   UIBarButtonItem.Style.done, target: self, action: #selector(self.doneTapped))
        toolbar.setItems([donebutton], animated: false)
        toolbar.tintColor = .systemYellow
        textView.inputAccessoryView = toolbar
    }
    
    @objc func doneTapped() {
       self.view.endEditing(true)
    }
}

//MARK: - Keyboard
extension EditNoteViewController {
    private func setupKeyboardNotificationListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
}

//MARK: - UITextViewDelegate
extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.body = textView.text
        saveNoteIfNeeded()
    }
}

//MARK: - UITextFieldDelegate
extension EditNoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        note?.title = textField.text ?? ""
        saveNoteIfNeeded()
    }
}
