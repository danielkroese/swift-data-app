import SwiftUI

struct OptionsView: View {
    @Binding var sortOption: CatSortOption
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort")) {
                    Picker("Sort", selection: $sortOption) {
                        ForEach(CatSortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                .listRowStyle(.purple)
            }
            .listRowStyle(.purple)
            .background(.purple.quinary)
            .navigationTitle("Options")
            .navigationBarItems(trailing: Button("Done") { dismiss() })
            .navigationHeaderStyle(.purple, size: .large)
        }
    }
}

#Preview {
    OptionsView(sortOption: .constant(.nameAscending))
}
