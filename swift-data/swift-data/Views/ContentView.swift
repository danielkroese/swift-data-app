import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var cats: [Cat]

    var body: some View {
        NavigationStack {
            List { listContent }
                .scrollContentBackground(.hidden)
                .padding(.top, 32)
                .toolbar { toolbar }
                .navigationTitle("Cat organizer")
                .navigationBarTitleDisplayMode(.large)
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
    
    private var listContent: some View {
        ForEach(cats) { cat in
            NavigationLink {
                EditCatView(cat: cat)
            } label: {
                Text("\(cat.name), \(cat.color.rawValue)")
            }
            .listRowBackground(cat.color.color.opacity(0.4))
        }
        .onDelete(perform: deleteCats)
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            EditButton()
            
            Button(action: addCat) {
                Label("Add new Cat", systemImage: "plus")
            }
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
