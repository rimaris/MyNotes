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
            updatePreviewLabel(preview: note?.body, updateDate: note?.updateDate)
        }
    }
}

//MARK: - Updating Notes Methods
extension NoteCellView {
    private func updateTitleLabel(title: String?) {
        guard let title = title else { return }
        if title.isEmpty {
            titleLabel.text = "Без названия"
        } else {
            titleLabel.text = title
        }
    }
    
    private func updatePreviewLabel(preview: String?, updateDate: Date?) {
        guard let preview = preview, let updateDate = updateDate else { return }
        let formatter = DateFormatter()
        if updateDate.timeIntervalSinceNow < Constants.secondsInDay {
            formatter.dateFormat = "HH:mm"
        } else if updateDate.timeIntervalSinceNow < Constants.secondsInWeek {
            formatter.dateFormat = "E"
        } else {
            formatter.dateFormat = "MMM d"
        }
        let previewDate = formatter.string(from: updateDate)
        previewLabel.text = "\(previewDate) \(preview)"
    }
}
