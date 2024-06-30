import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.iconOnly)
            .font(.system(size: 32))
            .frame(width: 32, height: 32)
            .foregroundStyle(.background)
            .padding()
            .background(color.opacity(configuration.isPressed ? 0.5 : 1), in: Circle())
            .background(color.secondary, in: Circle())
    }
}
