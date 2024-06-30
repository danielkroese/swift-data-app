import SwiftUI

struct EditButtonStyle<S: ShapeStyle>: ButtonStyle {
    let style: S
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title3.bold())
            .foregroundStyle(style)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
