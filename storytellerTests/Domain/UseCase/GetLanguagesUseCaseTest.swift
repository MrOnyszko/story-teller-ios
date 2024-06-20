import XCTest
import MockSwift
@testable import storyteller

final class GetLanguagesUseCaseTest: XCTestCase {

    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_return_empty_languages_list() async throws {
        let sut = GetLanguagesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).languages().willReturn([])
        
        let result = try await sut.execute()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_Given_NoError_When_execute_Then_languages_list() async throws {
        let sut = GetLanguagesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).languages().willReturn(["en", "pl"])
        
        let result = try await sut.execute()
        
        XCTAssertEqual(result, ["en", "pl"])
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = GetLanguagesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).languages().willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(),
            TestError.generic
        )
    }
}
