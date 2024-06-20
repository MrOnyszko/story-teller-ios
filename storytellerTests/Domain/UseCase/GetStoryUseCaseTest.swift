import XCTest
import MockSwift
@testable import storyteller

final class GetStoryUseCaseTest: XCTestCase {

    @Mock var storiesDataSource: StoriesDataSource
    
    func test_Given_NoError_When_execute_Then_return_story() async throws {
        let sut = GetStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).getStory(id: "1").willReturn(Story._test())
        given(storiesDataSource).getStoryTranslations(storyId: "1").willReturn([StoryTranslation._test()])
        
        let result = try await sut.execute(storyId: "1")
        
        XCTAssertEqual(result.story, Story._test())
        XCTAssertEqual(result.translations, [StoryTranslation._test()])
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = GetStoryUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
        
        given(storiesDataSource).getStory(id: "1").willThrow(TestError.generic)
                
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(storyId: "1"),
            TestError.generic
        )
    }
}
