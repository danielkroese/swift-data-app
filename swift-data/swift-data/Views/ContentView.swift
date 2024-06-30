import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var cats: [Cat]
    
    @State private var showOptions = false
    @State private var sortOption: SortOption = .dateAscending
    
    var body: some View {
        NavigationStack {
            ZStack {
                List { listContent }
                    .contentMargins(32, for: .scrollContent)
                    .scrollContentBackground(.hidden)
                    .background(.orange.quinary)
                    .toolbar { toolbar }
                    .navigationTitle("Cat organizer")
                    .navigationHeaderStyle(.orange, size: .large)
                    .animation(.smooth, value: cats)
                    .animation(.smooth, value: sortOption)
                    .sheet(isPresented: $showOptions) {
                        OptionsView(sortOption: $sortOption)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .presentationCornerRadius(16)
                    }
                
                Button(action: addCat) {
                    Label("Add new Cat", systemImage: "plus")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 32))
                        .foregroundStyle(.background)
                        .padding(16)
                        .background(Color.orange, in: Circle())
                }
                .background(Color.orange.secondary, in: Circle())
                .shadow(color: .orange.opacity(0.5), radius: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(16)
            }
        }
    }
    
    private var listContent: some View {
        ForEach(sortedAndFilteredCats) { cat in
            NavigationLink {
                EditCatView(cat: cat)
            } label: {
                Label {
                    Text(cat.name.localizedCapitalized)
                } icon: {
                    Image(systemName: "pawprint.fill")
                        .foregroundStyle(cat.color.color)
                }
            }
            .listRowStyle(cat.color.color)
        }
        .onDelete(perform: deleteCats)
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
    
    private var sortedAndFilteredCats: [Cat] {
        switch sortOption {
        case .dateAscending:
            return cats.sorted { $0.timestamp < $1.timestamp }
        case .dateDescending:
            return cats.sorted { $0.timestamp > $1.timestamp }
        case .nameAscending:
            return cats.sorted { $0.name < $1.name }
        case .nameDescending:
            return cats.sorted { $0.name > $1.name }
        case .colorAscending:
            return cats.sorted { $0.color.rawValue < $1.color.rawValue }
        case .colorDescending:
            return cats.sorted { $0.color.rawValue > $1.color.rawValue }
        }
    }
    
    private func addCat() {
        withAnimation {
            let newCat = CatFactory.create()
            modelContext.insert(newCat)
        }
    }
    
    private func deleteCats(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(cats[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Cat.self, inMemory: true)
}
