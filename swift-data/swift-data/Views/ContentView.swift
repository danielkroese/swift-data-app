import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showOptions = false
    @State private var sortOption: CatSortOption = .dateAscending
    
    var body: some View {
        NavigationStack {
                CatList(sortOption: $sortOption)
                    .toolbar { toolbar }
                    .navigationTitle("Cat organizer")
                    .navigationHeaderStyle(.orange, size: .large)
                    .sheet(isPresented: $showOptions) {
                        OptionsView(sortOption: $sortOption)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .presentationCornerRadius(16)
                    }
        }
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            Button(action: { showOptions = true }) {
                Label("Sort and Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
            
            EditButton()
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Cat.self, inMemory: true)
}
