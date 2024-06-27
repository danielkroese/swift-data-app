struct CatFactory {
    static func create() -> Cat {
        Cat(timestamp: .now, name: "Brand new cat", color: randomColor)
    }
    
    private static var randomColor: CatColor {
        CatColor.allCases.randomElement() ?? .orange
    }
}
