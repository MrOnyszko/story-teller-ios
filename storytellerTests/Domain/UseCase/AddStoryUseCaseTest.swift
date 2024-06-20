import XCTest
import MockSwift
@testable import storyteller

final class AddStoryUseCaseTest: XCTestCase {
    
    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_add_and_return_story() async throws {
        let sut = AddStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource)
            .addStory(
                title: "Title",
                content: "Content",
                languageCode: "en"
            )
            .willReturn(Story._test())
        
        let result = try await sut.execute(
            title: "Title",
            content: "Content",
            languageCode: "en"
        )
        
        XCTAssertEqual(result, Story._test())
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = AddStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource)
            .addStory(
                title: "Title",
                content: "Content",
                languageCode: "en"
            )
            .willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(
                title: "Title",
                content: "Content",
                languageCode: "en"
            ),
            TestError.generic
        )
    }
}
