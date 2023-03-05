//
//  NoteCellView.swift
//  Notes Clone
//
//  Created by Мария Васильева on 05.03.2023.
//

import UIKit

class NoteCellView: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    
    var note: Note? {
        didSet {
            updateTitleLabel(title: note?.title)
            updatePreviewLabel(preview: note?.body)
        }
    }
}

//MARK: - Updating Notes Methods
extension NoteCellView {
    private func updateTitleLabel(title: String?) {
        guard let title = title else { return }
        titleLabel.text = title
    }
    
    private func updatePreviewLabel(preview: String?) {
        guard let preview = preview else { return }
        previewLabel.text = preview
    }
}
