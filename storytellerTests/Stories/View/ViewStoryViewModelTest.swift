import XCTest
import MockSwift
import Combine
@testable import storyteller

final class ViewStoryViewModelTest: XCTestCase {
    
    @Mock var getStoryUseCase: GetStoryUseCase
    
    func sut(state: ViewStoryState) -> ViewStoryViewModel {
        return ViewStoryViewModel(
            state: state,
            getStoryUseCase: getStoryUseCase
        )
    }
    
    @MainActor
    func test_Given_NoError_When_load_Then_emit_loaded_state() async throws {
        given(getStoryUseCase).execute(storyId: "1")
            .willReturn(
                GetStoryResult(story: Story._test(), translations: [StoryTranslation._test()])
            )
        
        let sut = sut(
            state: ViewStoryState(storyId: "1")
        )
        
        let states = [
            ViewStoryState(type: ViewStoryState.StateType.loading, storyId: "1"),
            ViewStoryState(type: ViewStoryState.StateType.loading, storyId: "1", story: Story._test()),
            ViewStoryState(
                type: ViewStoryState.StateType.loading,
                storyId: "1",
                story: Story._test(),
                translations: [
                    StoryTranslation._test()
                ]
            ),
            ViewStoryState(
                type: ViewStoryState.StateType.loaded,
                storyId: "1",
                story: Story._test(),
                translations: [
                    StoryTranslation._test()
                ]
            )
        ]
        
        await assertPublisher(
            sut.$state.dropFirst(),
            emits: states,
            when: {
                sut.load()
            }
        )
    }
    
    @MainActor
    func test_Given_Error_When_load_Then_emit_error_state() async throws {
        given(getStoryUseCase).execute(storyId: "1").willThrow(TestError.generic)
        
        let sut = sut(
            state: ViewStoryState(storyId: "1")
        )
        
        let states = [
            ViewStoryState(type: ViewStoryState.StateType.loading, storyId: "1"),
            ViewStoryState(type: ViewStoryState.StateType.error, storyId: "1")
        ]
        
        await assertPublisher(
            sut.$state.dropFirst(),
            emits: states,
            when: {
                sut.load()
            }
        )
    }
}
