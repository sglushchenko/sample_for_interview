//
//  User.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    var name: String {
        return [firstName, lastName].joined(separator: " ")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    static let sample: User = User(id: 1, email: "sample@sample.com", firstName: "First", lastName: "Last", avatar: "https://google.com")
}
