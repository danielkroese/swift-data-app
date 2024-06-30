import SwiftUI

struct ActionButtonStyle: ViewModifier {
    let color: Color
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
                .labelStyle(.iconOnly)
                .font(.system(size: 32))
                .frame(width: 32, height: 32)
                .foregroundStyle(.background)
                .padding()
                .background(color, in: Circle())
        }
        .background(color.secondary, in: Circle())
        .shadow(color: color.opacity(0.5), radius: 20)
    }
}

extension View {
    func actionButtonStyle(_ color: Color, action: @escaping () -> Void) -> some View {
        self.modifier(ActionButtonStyle(color: color, action: action))
    }
}

#Preview {
    Text("Hello, world!")
        .actionButtonStyle(.red) { }
}
