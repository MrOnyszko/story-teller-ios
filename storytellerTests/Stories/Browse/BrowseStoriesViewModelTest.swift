import XCTest
import MockSwift
import Combine
@testable import storyteller

final class BrowseStoriesViewModelTest: XCTestCase {
    
    @Mock var getStoriesUseCase: GetStoriesUseCase
    @Mock var removeStoryUseCase: RemoveStoryUseCase
    
    func sut(state: BrowseStoriesState) -> BrowseStoriesViewModel {
        return BrowseStoriesViewModel(
            state: state,
            getStoriesUseCase: getStoriesUseCase,
            removeStoryUseCase: removeStoryUseCase
        )
    }
    
    @MainActor
    func test_Given_NoError_When_load_Then_emit_empty_state() async throws {
        given(getStoriesUseCase).execute().willReturn([])
        
        let sut = sut(
            state: BrowseStoriesState()
        )
        
        let states = [
            BrowseStoriesState(type: BrowseStoriesState.StateType.loading),
            BrowseStoriesState(type: BrowseStoriesState.StateType.loading),
            BrowseStoriesState(type: BrowseStoriesState.StateType.empty)
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
        given(getStoriesUseCase).execute().willThrow(TestError.generic)
        
        let sut = sut(
            state: BrowseStoriesState()
        )
        
        let states = [
            BrowseStoriesState(type: BrowseStoriesState.StateType.loading),
            BrowseStoriesState(type: BrowseStoriesState.StateType.error)
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
    func test_Given_NoError_When_load_Then_emit_loaded_state() async throws {
        given(getStoriesUseCase).execute().willReturn([Story._test()])
        
        let sut = sut(
            state: BrowseStoriesState()
        )
        
        let states = [
            BrowseStoriesState(type: BrowseStoriesState.StateType.loading),
            BrowseStoriesState(type: BrowseStoriesState.StateType.loading, stories: [Story._test()]),
            BrowseStoriesState(type: BrowseStoriesState.StateType.loaded, stories: [Story._test()])
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
    func test_Given_NoError_When_removeStory_Then_emit_updated_state() async throws {
        given(removeStoryUseCase).execute(storyId: "1").willDoNothing()
        
        let initialState = BrowseStoriesState(type: BrowseStoriesState.StateType.loaded, stories: [Story._test()])
        
        let sut = sut(state: initialState)
        
        let states = [
            initialState,
            BrowseStoriesState(type: BrowseStoriesState.StateType.loaded, stories: []),
            BrowseStoriesState(type: BrowseStoriesState.StateType.empty, stories: [])
        ]
        
        await assertPublisher(
            sut.$state,
            emits: states,
            when: {
                sut.removeStory(offsets: IndexSet(integer: 0))
            }
        )
    }
    
    @MainActor
    func test_Given_Error_When_removeStory_Then_do_nothing() async throws {
        given(removeStoryUseCase).execute(storyId: "1").willThrow(TestError.generic)
        
        let initialState = BrowseStoriesState(type: BrowseStoriesState.StateType.loaded, stories: [Story._test()])
        
        let sut = sut(state: initialState)
        
        let states = [
            initialState,
        ]
        
        await assertPublisher(
            sut.$state,
            emits: states,
            when: {
                sut.removeStory(offsets: IndexSet(integer: 0))
            }
        )
    }
}
