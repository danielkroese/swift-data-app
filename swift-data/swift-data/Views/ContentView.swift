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
                    .animation(.smooth, value: sortOption)
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
            EditButton()
                .foregroundStyle(.primary)
            
            Button(action: { showOptions = true }) {
                Label("Sort and Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Cat.self, inMemory: true)
}
