//
//  User.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let avatar: String?
}
