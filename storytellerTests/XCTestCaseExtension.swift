import XCTest
import Combine
import Foundation

extension XCTestCase {
    
    enum TestError: Error, Comparable {
        case generic
    }
    
    func assertPublisher<T: Publisher>(
        _ publisher: T,
        emits values: [T.Output],
        when action: @escaping () async -> Void,
        timeout: TimeInterval = 0.5,
        file: StaticString = #file,
        line: UInt = #line
    ) async where T.Output: Equatable, T.Failure == Never {
        var receivedValues: [T.Output] = []
        let expectation = XCTestExpectation(description: "Awaiting publisher values")
        expectation.expectedFulfillmentCount = values.count
        
        let cancellable = publisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("Publisher emitted an error", file: file, line: line)
                }
            } receiveValue: { value in
                receivedValues.append(value)
                expectation.fulfill()
            }
        
        await action()

        await fulfillment(of: [expectation], timeout: timeout)
        cancellable.cancel()
        
        XCTAssertEqual(receivedValues, values, "Publisher emitted unexpected values", file: file, line: line)
    }
    
    
    func XCTAssertThrowsErrorAsync<T, R>(
        _ expression: @autoclosure () async throws -> T,
        _ errorThrown: @autoclosure () -> R,
        _ message: @autoclosure () -> String = "This method should fail",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async where R: Comparable, R: Error  {
        do {
            let _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            XCTAssertEqual(error as? R, errorThrown())
        }
    }
}
