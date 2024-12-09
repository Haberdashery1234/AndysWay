//
//  Marker.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation
import SwiftUI

enum MyMarkerType: String, Codable, Identifiable, CaseIterable {
    case water = "water"
    case trash = "trash"
    case light = "light"
    case attack = "attack"
    
    var id: RawValue { rawValue }

    var markerImage: Image {
        switch self {
        case .water: return Image("water")
        case .trash: return Image("trash")
        case .light: return Image("light")
        case .attack: return Image("attack")
        }
    }
}

struct MyMarker: Codable, Identifiable, Transferable, CustomStringConvertible {
    
    public var id: UUID?
    public var type: MyMarkerType
    public var latitude: Double?
    public var longitude: Double?
//    let createdAt: Date
//    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type = "marker_type"
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        type = try container.decode(MyMarkerType.self, forKey: .type)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
    }
    
    init(type: MyMarkerType, latitude: Double? = 0, longitude: Double? = 0) {
        self.type = type
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
    }
    
    init(id: UUID, type: MyMarkerType, latitude: Double? = 0, longitude: Double? = 0) {
        self.id = id
        self.type = type
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
    }
    
    var description: String {
        return "\(type) \(latitude ?? 0.0) \(longitude ?? 0.0)"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .content)
    }
    
    func toJSONData() -> Data? {
        var json = [String: Any]()
        
        json["marker_type"] = type.rawValue
        json["latitude"] = latitude
        json["longitude"] = longitude
        
        guard let data = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        
        return data
    }
}
