# SDSTestUtilityClass

## RepeatedExpectation
tired to write many expectation for testing with repeatedly fulfilment?
use RepeatedExpectation !
```
func test_something() async throws {
    // preparation (specify how many times expectation will be fulfilled
    let expectations = RepeatedExpectation(5) 

     var cancellables: Set<AnyCancellable> = Set()

     // setup sut which should fulfill at some point

     sut.objectDidChange.sink { change in
       // call expectations.fulfill()
       expectations.fulfill()
     }.store(in: &cancellables)

     // do something
     
     // then wait for expectation fulfilled n times (in following, wait for one fulfillment)
     await fulfillment(of: [expectations[1]], timeout: 3)

     // test result
     XCTAssert.....
}
```
