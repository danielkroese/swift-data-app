import XCTest
@testable import swift_data

final class CatTests: XCTestCase {
    func test_init() {
        _ = Cat(timestamp: Date(), name: "", color: .red)
    }
}
