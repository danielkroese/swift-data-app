import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var cats: [Cat]
    
    @State private var showOptions = false
    @State private var sortOption: SortOption = .none
    
    var body: some View {
        NavigationStack {
            List { listContent }
                .scrollContentBackground(.hidden)
                .padding(.top)
                .background(.orange.quinary)
                .toolbar { toolbar }
                .navigationTitle("Cat organizer")
                .navigationHeaderStyle(.orange, size: .large)
                .animation(.default, value: sortOption)
                .sheet(isPresented: $showOptions) {
                    OptionsView(sortOption: $sortOption.animation())
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(16)
                }
        }
    }
    
    private var listContent: some View {
        ForEach(sortedAndFilteredCats) { cat in
            NavigationLink {
                EditCatView(cat: cat)
            } label: {
                Label {
                    Text("\(cat.name), \(cat.color.rawValue)")
                } icon: {
                    Image(systemName: "pawprint.fill")
                        .foregroundStyle(cat.color.color)
                }
            }
            .listRowSeparatorTint(.orange)
            .listRowBackground(cat.color.color.opacity(0.4))
        }
        .onDelete(perform: deleteCats)
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            EditButton()
                .foregroundStyle(.primary)
            
            Button(action: addCat) {
                Label("Add new Cat", systemImage: "plus")
            }
            
            Button(action: { showOptions = true }) {
                Label("Sort and Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
    
    private func addCat() {
        withAnimation {
            let newCat = CatFactory.create()
            modelContext.insert(newCat)
        }
    }
    
    private var sortedAndFilteredCats: [Cat] {
            switch sortOption {
            case .none:
                return cats
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
