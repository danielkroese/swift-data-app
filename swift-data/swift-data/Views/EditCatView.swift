import SwiftUI
import UIKit

struct EditCatView: View {
    @Bindable var cat: Cat
    @Environment(\.dismiss) private var dismiss
    
    private let dateFormat = Date.FormatStyle(date: .abbreviated, time: .shortened)

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(cat.name)
                    .font(.title.bold())
                    .foregroundStyle(cat.color.color)
                    .drawingGroup()
                
                Text("This \(cat.color.rawValue) cat was added on \(cat.timestamp, format: dateFormat)")
                    .font(.subheadline)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Form {
                TextField("Name", text: $cat.name.animation())
                
                Picker("Color", selection: $cat.color.animation()) {
                    ForEach(CatColor.allCases) { color in
                        Text(color.rawValue.localizedCapitalized)
                    }
                }
            }
            
            Button("Close") {
                dismiss()
            }
        }
        .background(cat.color.color.quinary)
        .navigationTitle("Edit cat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditCatView(cat: CatFactory.create())
}
