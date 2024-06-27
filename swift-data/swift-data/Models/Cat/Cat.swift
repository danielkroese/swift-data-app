import Foundation
import SwiftData

@Model
final class Cat {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var name: String
    var color: CatColor
    
    init(timestamp: Date, name: String, color: CatColor) {
        self.id = UUID()
        self.timestamp = timestamp
        self.name = name
        self.color = color
    }
}
