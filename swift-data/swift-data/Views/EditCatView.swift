import SwiftUI

struct EditCatView: View {
    @Bindable var cat: Cat
    
    private let dateFormat = Date.FormatStyle(date: .abbreviated, time: .shortened)

    var body: some View {
        Form {
            Text("\(cat.name) was added on \(cat.timestamp, format: dateFormat)")
            
            TextField("Name", text: $cat.name)
            
            Picker("Color", selection: $cat.color) {
                ForEach(CatColor.allCases) { color in
                    Text(color.rawValue.localizedCapitalized)
                }
            }
        }
        .navigationTitle("Edit Cat")
        .navigationBarTitleDisplayMode(.inline)
    }
}
