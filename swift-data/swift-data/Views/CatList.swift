import SwiftUI
import SwiftData

struct CatList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var sortOption: CatSortOption
    
    @Query private var cats: [Cat]
    
    init(
        sortOption: Binding<CatSortOption>
    ) {
        _sortOption = sortOption
        _cats = Query(sort: [sortOption.wrappedValue.sortDescriptor])
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(cats) { cat in
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
            .contentMargins(32, for: .scrollContent)
            .scrollContentBackground(.hidden)
            .background(.orange.quinary)
            .animation(.smooth, value: cats)
            
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
