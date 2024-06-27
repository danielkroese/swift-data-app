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
            Text("Select an item") // main view
        }
    }
    
    private var list: some View {
        ForEach(cats) { cat in
            NavigationLink {
                Text("Cat created at \(cat.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
            } label: {
                Text(cat.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
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
            let newItem = Cat(timestamp: Date())
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
