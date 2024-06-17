import XCTest
import MockSwift
@testable import storyteller

final class BrowseStoriesViewModelTest: XCTestCase {
    
    @Mock var getStoriesUseCase: GetStoriesUseCase
    @Mock var removeStoryUseCase: RemoveStoryUseCase
    
    private var sut: BrowseStoriesViewModel!

    @MainActor
    func Given_NoError_When_load_Then_emit_loaded_state() throws {
        
        given(getStoriesUseCase).execute().willReturn([])
        
        sut = BrowseStoriesViewModel(
            state: BrowseStoriesState(),
            getStoriesUseCase: getStoriesUseCase,
            removeStoryUseCase: removeStoryUseCase
        )
        
        sut.load()
        
        XCTAssertEqual(sut.state.type, .loaded)
    }
}
