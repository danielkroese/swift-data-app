import SwiftData

struct ModelContainerFactory {
    static func create() throws -> ModelContainer {
        let schema = Schema([
            Cat.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        
        return modelContainer
    }
}
