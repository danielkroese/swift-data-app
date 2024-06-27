import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var cats: [Cat]

    var body: some View {
        NavigationSplitView {
            List { list }
                .toolbar { toolbar }
        } detail: {
            Text("Select an item")
        }
    }
    
    private var list: some View {
        ForEach(cats) { cat in
            NavigationLink {
                EditCatView(cat: cat)
            } label: {
                Text("\(cat.name), \(cat.color.rawValue)")
            }
        }
        .onDelete(perform: deleteItems)
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            EditButton()
            
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Cat(timestamp: Date(), name: "New cat", color: .white)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
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
