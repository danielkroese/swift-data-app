import SwiftUI

struct NavigationHeaderStyle<S>: ViewModifier where S: ShapeStyle {
    let style: S
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(style, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(titleDisplayMode)
    }
}

extension View {
    func navigationHeaderStyle<S>(
        _ style: S,
        size: NavigationBarItem.TitleDisplayMode
    ) -> some View where S: ShapeStyle {
        self.modifier(NavigationHeaderStyle(style: style, titleDisplayMode: size))
    }
}
