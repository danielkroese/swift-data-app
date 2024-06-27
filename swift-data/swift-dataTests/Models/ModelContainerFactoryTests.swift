import XCTest
@testable import swift_data

final class ModelContainerFactoryTests: XCTestCase {
    func test_create() {
        let sut = ModelContainerFactory.self
        
        XCTAssertNoThrow(try sut.create())
    }
}
