import XCTest
import MockSwift
@testable import storyteller

final class RemoveStoryUseCaseTest: XCTestCase {

    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_add_and_return_story() async throws {
        let sut = RemoveStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).removeStory(storyId: "1").willDoNothing()
        
        try await sut.execute(storyId: "1")
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = RemoveStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).removeStory(storyId: "1").willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(storyId: "1"),
            TestError.generic
        )
    }
}
