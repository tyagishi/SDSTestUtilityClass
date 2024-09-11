//
//  RepeatedExpectation.swift
//
//  Created by : Tomoaki Yagishita on 2024/07/25
//  © 2024  SmallDeskSoftware
//

import Foundation
import XCTest

/// XCTestExpectation container
/// usage
/// ```
/// func test_something() async throws {
///     let expectations = RepeatedExpectation(5) // preparation (specify how many times expectation will be fulfilled
///
///     var cancellables: Set<AnyCancellable> = Set()
///
///     // setup sut which should fulfill at some point
///
///     sut.objectDidChange.sink { change in
///       // call expectations.fulfill()
///       expectations.fulfill()
///     }.store(in: &cancellables)
///
///     // do something
///     // wait for expectation fulfilled n times (in following, wait for one fulfillment)
///     await fulfillment(of: [expectations[1]], timeout: 3)
///
///     // test result
///     XCTAssert.....
/// ```
public class RepeatedExpectation: Sendable {
    public var expectations: [XCTestExpectation] = []
    
    public init(_ num: Int) {
        for index in 0...num {
            let expectation = XCTestExpectation(description: "\(index)-th")
            expectation.assertForOverFulfill = false
            expectation.expectedFulfillmentCount = (index != 0) ? index : Int.max
            expectations.append(expectation)
        }
    }
    
    public subscript(index: Int) -> XCTestExpectation {
        guard index >= 0, index < expectations.count else { fatalError("invalid index")}
        return expectations[index]
    }
    
    public func fulfill() {
        expectations.forEach({
            $0.fulfill()
        })
    }
}
