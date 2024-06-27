import SwiftUI
import SwiftData

enum CatColor: String, Codable, CaseIterable {
    case red
    case orange
    case brown
    case white
    case black
    case gray
    
    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .brown: .brown
        case .white, .gray: .gray
        case .black: .black
        }
    }
}

extension CatColor: Identifiable {
    var id: Self { self }
}
