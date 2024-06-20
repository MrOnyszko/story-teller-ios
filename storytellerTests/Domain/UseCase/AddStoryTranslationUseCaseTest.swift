import XCTest
import MockSwift
@testable import storyteller

final class AddStoryTranslationUseCaseTest: XCTestCase {

    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_add_and_return_story() async throws {
        let sut = AddStoryTranslationUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource)
            .addTranslation(
                storyId: "1",
                languageCode: "en",
                title: "Title",
                content: "Content"
            )
            .willReturn(StoryTranslation._test())
        
        let result = try await sut.execute(
            storyId: "1",
            title: "Title",
            content: "Content",
            languageCode: "en"
        )
        
        XCTAssertEqual(result, StoryTranslation._test())
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = AddStoryTranslationUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource)
            .addTranslation(
                storyId: "1",
                languageCode: "en",
                title: "Title",
                content: "Content"
            )
            .willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(
                storyId: "1",
                title: "Title",
                content: "Content",
                languageCode: "en"
            ),
            TestError.generic
        )
    }
}
