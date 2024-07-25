import XCTest
@testable import SDSTestUtilityClass
import Combine

final class RepeatedExpectation_Tests: XCTestCase {
    func testExample() async throws {
        var cancellables: Set<AnyCancellable> = Set()

        let publisher = PassthroughSubject<Void,Never>()
        
        let sut = RepeatedExpectation(5)
        
        var counter = 0
        
        publisher.sink { _ in
            counter += 1
            sut.fulfill()
        }.store(in: &cancellables)

        publisher.send()
        await fulfillment(of: [sut[1]], timeout: 3)
        XCTAssertEqual(counter, 1)

        publisher.send()
        await fulfillment(of: [sut[2]], timeout: 3)
        XCTAssertEqual(counter, 2)

        publisher.send()
        await fulfillment(of: [sut[3]], timeout: 3)
        XCTAssertEqual(counter, 3)

        publisher.send()
        await fulfillment(of: [sut[4]], timeout: 3)
        XCTAssertEqual(counter, 4)

        publisher.send()
        await fulfillment(of: [sut[5]], timeout: 3)
        XCTAssertEqual(counter, 5)
    }
}
