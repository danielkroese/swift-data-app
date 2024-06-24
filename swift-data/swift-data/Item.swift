//
//  Item.swift
//  swift-data
//
//  Created by Daniël Kroese Personal on 24/06/2024.
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
