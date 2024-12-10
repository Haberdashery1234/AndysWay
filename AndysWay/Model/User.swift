//
//  User.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

var MockUser = User(id: UUID(), displayName: "Christian Grise", email: "christian@grise.dev", avatarUrl: nil, addedMarkers: [], friends: [], location: "Arlington, MA, USA")

struct User: Codable, Identifiable {
    var id: UUID
    var displayName: String
    var email: String
    var avatarUrl: URL?
    var addedMarkers: [MyMarker]
    var friends: [User]
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        case email
        case avatar
        case addedMarkers
        case friends
        case location
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        displayName = try container.decode(String.self, forKey: .displayName)
        email = try container.decode(String.self, forKey: .email)
        avatarUrl = try container.decodeIfPresent(URL.self, forKey: .avatar) ?? nil
        addedMarkers = try container.decode([MyMarker].self, forKey: .addedMarkers)
        friends = try container.decode([User].self, forKey: .friends)
        location = try container.decodeIfPresent(String.self, forKey: .location)
    }
    
    init(id: UUID, displayName: String, email: String, avatarUrl: URL?, addedMarkers: [MyMarker], friends: [User], location: String?) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.avatarUrl = avatarUrl
        self.addedMarkers = addedMarkers
        self.friends = friends
        self.location = location
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(displayName, forKey: .displayName)
        try container.encode(email, forKey: .email)
        try container.encode(avatarUrl, forKey: .avatar)
        try container.encode(addedMarkers, forKey: .addedMarkers)
        try container.encode(friends, forKey: .friends)
        try container.encode(location, forKey: .location)
    }
}
