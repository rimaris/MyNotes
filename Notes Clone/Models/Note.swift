//
//  Note.swift
//  Notes Clone
//
//  Created by Мария Васильева on 06.03.2023.
//

import Foundation

class Note: Codable, Identifiable {
    var id = UUID()
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
