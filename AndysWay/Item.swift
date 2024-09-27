//
//  Item.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
