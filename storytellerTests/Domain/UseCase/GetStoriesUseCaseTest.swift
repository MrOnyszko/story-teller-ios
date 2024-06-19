import XCTest
import MockSwift
@testable import storyteller

final class GetStoriesUseCaseTest: XCTestCase {
    
    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_return_empty_stories_list() async throws {
        let sut = GetStoriesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).getStories().willReturn([])
        
        let result = try await sut.execute()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_Given_NoError_When_execute_Then_return_stories_list() async throws {
        let sut = GetStoriesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).getStories().willReturn([Story._test()])
        
        let result = try await sut.execute()
        
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result, [Story._test()])
    }
    
    func test_Given_Error_When_execute_Then_throw() async throws {
        let sut = GetStoriesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).getStories().willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(),
            TestError.generic
        )
    }
}
