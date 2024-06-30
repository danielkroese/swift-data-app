import SwiftUI
import SwiftData

enum CatColor: String, Codable, CaseIterable {
    case red
    case orange
    case brown
    case gray
    case blue
    case yellow
    
    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .brown: .brown
        case .gray: .gray
        case .blue: .blue
        case .yellow: .yellow
        }
    }
}

extension CatColor: Identifiable {
    var id: Self { self }
}
