import SwiftUI

struct NavigationHeaderStyle<S>: ViewModifier where S: ShapeStyle & Equatable {
    @Environment(\.colorScheme) var colorScheme
    
    let style: S
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(style, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(toolbarColorScheme, for: .navigationBar)
            .navigationBarTitleDisplayMode(titleDisplayMode)
            .animation(.smooth, value: style)
    }
    
    private var toolbarColorScheme: ColorScheme {
        colorScheme == .dark ? .light : .dark
    }
}

extension View {
    func navigationHeaderStyle<S>(
        _ style: S,
        size: NavigationBarItem.TitleDisplayMode
    ) -> some View where S: ShapeStyle & Equatable {
        self.modifier(NavigationHeaderStyle(style: style, titleDisplayMode: size))
    }
}
