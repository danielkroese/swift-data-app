struct CatFactory {
    static func create() -> Cat {
        Cat(timestamp: .now, name: randomCatName, color: randomColor)
    }
    
    private static var randomCatName: String {
        [
            "Smokey",
            "Nova",
            "Luna",
            "Sylvester",
            "Tom",
            "Poes"
        ].randomElement() ?? "Cat"
    }
    
    private static var randomColor: CatColor {
        CatColor.allCases.randomElement() ?? .orange
    }
}
