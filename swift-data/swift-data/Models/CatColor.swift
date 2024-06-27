import Foundation
import SwiftData

enum CatColor: String, Codable, CaseIterable {
    case red
    case orange
    case brown
    case white
    case black
    case grey
}

extension CatColor: Identifiable {
    var id: Self { self }
}
