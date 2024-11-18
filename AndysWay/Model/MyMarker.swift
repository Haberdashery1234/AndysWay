//
//  Marker.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation
import SwiftUI

enum MyMarkerType: String, Codable, Identifiable, CaseIterable {
    var id: RawValue { rawValue }
    
    case water = "water"
    case trash = "trash"
    case light = "light"
    case attack = "attack"
    
    var markerImage: Image {
        switch self {
        case .water: return Image("water")
        case .trash: return Image("trash")
        case .light: return Image("light")
        case .attack: return Image("attack")
        }
    }
}

struct MyMarker: Codable, Identifiable, Transferable {
    
    public var id = UUID()
    public var type: MyMarkerType
    public var latitude: Double?
    public var longitude: Double?
//    let createdAt: Date
//    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case latitude
        case longitude
    }
    
    init(type: MyMarkerType, latitude: Double? = 0, longitude: Double? = 0) {
        self.id = UUID()
        self.type = type
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .content)
    }
}
