import Foundation
import SwiftData

@Model
final class Cat {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var name: String
    var colorString: String
    
    var color: CatColor {
        get { CatColor(rawValue: colorString) ?? .orange }
        set { colorString = newValue.rawValue }
    }
    
    init(timestamp: Date, name: String, color: CatColor) {
        self.id = UUID()
        self.timestamp = timestamp
        self.name = name
        self.colorString = color.rawValue
    }
}
