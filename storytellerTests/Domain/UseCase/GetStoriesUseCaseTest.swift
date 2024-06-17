import XCTest
import MockSwift
@testable import storyteller

final class GetStoriesUseCaseTest: XCTestCase {
    
    @Mock var storiesDataSource: StoriesDataSource
    private var getStoriesUseCase: GetStoriesUseCase!

    override func setUpWithError() throws {
        getStoriesUseCase = GetStoriesUseCaseImpl(
            storiesDataSource: storiesDataSource
        )
    }

    override func tearDownWithError() throws {
        getStoriesUseCase = nil
    }

    func Given_NoError_When_execute_Then_return_empty_stories_list() async throws {
        given(storiesDataSource).getStories().willReturn([])
        
        let result = try await getStoriesUseCase.execute()
        
        XCTAssertTrue(result.isEmpty)
    }
}
