//
//  Marker.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

class Marker: Codable, Identifiable {
    public var uuid: UUID
    public var type: String
    public var latitude: Double
    public var longitude: Double
//    let createdAt: Date
//    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case type
        case latitude
        case longitude
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(type, forKey: .type)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decodeIfPresent(UUID.self, forKey: .uuid) ?? UUID()
        self.type = try container.decode(String.self, forKey: .type)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
