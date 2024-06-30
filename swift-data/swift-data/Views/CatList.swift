import SwiftUI
import SwiftData

struct CatList: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    
    @Binding var sortOption: CatSortOption
    
    @Query private var cats: [Cat]
    
    @State private var multiSelection = Set<UUID>()
    
    init(sortOption: Binding<CatSortOption>) {
        _sortOption = sortOption
        _cats = Query(sort: [sortOption.wrappedValue.sortDescriptor])
    }
    
    var body: some View {
        ZStack {
            List(selection: $multiSelection) {
                ForEach(cats) { cat in
                    NavigationLink {
                        EditCatView(id: cat.persistentModelID, in: modelContext.container)
                    } label: {
                        Label {
                            Text(cat.name.localizedCapitalized)
                        } icon: {
                            Image(systemName: "pawprint.fill")
                                .foregroundStyle(cat.color.color)
                        }
                        .font(.title2)
                        .padding(.vertical, 2)
                    }
                    .listRowStyle(cat.color.color)
                }
                .onDelete(perform: deleteCats)
            }
            .contentMargins(32, for: .scrollContent)
            .scrollContentBackground(.hidden)
            .background(.orange.quinary)
            .animation(.default, value: cats)
            
            actionButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(24)
                .animation(.default, value: multiSelection.isEmpty)
        }
        .onDisappear {
            multiSelection.removeAll()
        }
    }
    
    private var actionButton: some View {
        if multiSelection.isEmpty == false {
            Button(action: deleteCats) {
                Label("Delete selected Cats", systemImage: "trash.fill")
            }
            .buttonStyle(ActionButtonStyle(color: .red))
        } else {
            Button(action: addCat) {
                Label("Add new Cat", systemImage: "plus")
            }
            .buttonStyle(ActionButtonStyle(color: .orange))
        }
    }
    
    private func addCat() {
        let newCat = CatFactory.create()
        
        withAnimation {
            modelContext.insert(newCat)
        }
    }
    
    private func deleteCats() {
        let catsToDelete = cats.filter { cat in
            multiSelection.contains { selection in
                selection == cat.id
            }
        }
        
        withAnimation {
            for cat in catsToDelete {
                modelContext.delete(cat)
            }
            
            multiSelection.removeAll()
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
