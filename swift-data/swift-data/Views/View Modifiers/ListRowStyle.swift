import SwiftUI

struct ListRowStyle<S>: ViewModifier where S: ShapeStyle & Equatable {
    @Environment(\.colorScheme) private var colorScheme
    
    let style: S
    
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .listRowSeparator(.hidden)
            .listRowBackground(
                Rectangle()
                    .foregroundStyle(style.tertiary)
            )
            .listRowSpacing(18)
            .listSectionSpacing(18)
            .animation(.smooth, value: style)
    }
    
    private var toolbarColorScheme: ColorScheme {
        colorScheme == .dark ? .light : .dark
    }
}

extension View {
    func listRowStyle<S>(_ style: S) -> some View where S: ShapeStyle & Equatable {
        self.modifier(ListRowStyle(style: style))
    }
}
