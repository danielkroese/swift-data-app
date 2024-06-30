import SwiftUI

struct OptionsView: View {
    @Binding var sortOption: SortOption
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort")) {
                    Picker("Sort", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .navigationTitle("Options")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
        }
    }
}

enum SortOption: String, CaseIterable {
    case none = "Default"
    case nameAscending = "Name (A-Z)"
    case nameDescending = "Name (Z-A)"
    case colorAscending = "Color (A-Z)"
    case colorDescending = "Color (Z-A)"
}

#Preview {
    OptionsView(sortOption: .constant(.nameAscending))
}
