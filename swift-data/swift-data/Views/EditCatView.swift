import SwiftUI
import UIKit

struct EditCatView: View {
    @Bindable var cat: Cat
    @Environment(\.dismiss) private var dismiss
    
    private let dateFormat = Date.FormatStyle(date: .abbreviated, time: .shortened)
    
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
                    TextField("Name", text: $cat.name.animation())
                    
                    Picker("Color", selection: $cat.color.animation()) {
                        ForEach(CatColor.allCases) { color in
                            Text(color.rawValue.localizedCapitalized)
                        }
                    }
                }
                .listRowBackground(cat.color.color.opacity(0.4))
            }
            .scrollContentBackground(.hidden)
            
            Button("Close") {
                dismiss()
            }
        }
        .background(cat.color.color.quinary)
        .navigationTitle("Edit cat")
        .navigationHeaderStyle(cat.color.color, size: .inline)
    }
}

#Preview {
    EditCatView(cat: CatFactory.create())
}
