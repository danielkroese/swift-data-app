import SwiftUI
import SwiftData

struct EditCatView: View {
    @Bindable var cat: Cat
    
    @Environment(\.dismiss) private var dismiss
    
    private let dateFormat = Date.FormatStyle(date: .abbreviated, time: .shortened)
    
    private let modelContext: ModelContext
    
    init(id: PersistentIdentifier, in container: ModelContainer) {
        modelContext = ModelContext(container)
        modelContext.autosaveEnabled = false
        
        cat = modelContext.model(for: id) as? Cat ?? CatFactory.create()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(cat.name)
                    .font(.title.bold())
                    .foregroundStyle(cat.color.color)
                    .drawingGroup()
                    .padding(.top)
                
                Text("This \(cat.color.rawValue) cat was added on \(cat.timestamp, format: dateFormat)")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Form {
                Group {
                    TextField("Name", text: $cat.name.animation(.smooth))
                    
                    Picker("Color", selection: $cat.color.animation(.smooth)) {
                        ForEach(CatColor.allCases) { color in
                            Text(color.rawValue.localizedCapitalized)
                        }
                    }
                }
                .listRowStyle(cat.color.color)
            }
            .scrollContentBackground(.hidden)
            
            buttonsView
        }
        .background(cat.color.color.quinary)
        .navigationTitle("Edit cat")
        .navigationHeaderStyle(cat.color.color, size: .inline)
    }
    
    private var buttonsView: some View {
        Group {
            if modelContext.hasChanges {
                Button("Save and close") {
                    try? modelContext.save()
                    dismiss()
                }
                .buttonStyle(EditButtonStyle(style: .primary))
                
                Button("Discard and close", role: .destructive) {
                    dismiss()
                }
                .buttonStyle(EditButtonStyle(style: .red))
            } else {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(EditButtonStyle(style: .primary))
            }
        }
        .animation(.smooth, value: modelContext.hasChanges)
    }
}
