import Foundation
import SwiftData

enum CatSortOption: String, CaseIterable {
    case dateAscending = "Old first"
    case dateDescending = "New first"
    case nameAscending = "Name (A-Z)"
    case nameDescending = "Name (Z-A)"
    case colorAscending = "Color (A-Z)"
    case colorDescending = "Color (Z-A)"
    
    var sortDescriptor: SortDescriptor<Cat> {
        switch self {
        case .dateAscending:
            return SortDescriptor(\.timestamp, order: .forward)
        case .dateDescending:
            return SortDescriptor(\.timestamp, order: .reverse)
        case .nameAscending:
            return SortDescriptor(\.name, order: .forward)
        case .nameDescending:
            return SortDescriptor(\.name, order: .reverse)
        case .colorAscending:
            return SortDescriptor(\.colorString, order: .forward)
        case .colorDescending:
            return SortDescriptor(\.colorString, order: .reverse)
        }
    }
}
