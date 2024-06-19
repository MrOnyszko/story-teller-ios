import Foundation
import SwiftUI

class BrowseStoriesViewModel : ObservableObject {

    @Published var state: BrowseStoriesState {
        didSet { Logger.info(state) }
    }
    
    private var getStoriesUseCase: GetStoriesUseCase
    private var removeStoryUseCase: RemoveStoryUseCase
    
    init(
        state: BrowseStoriesState,
        getStoriesUseCase: GetStoriesUseCase,
        removeStoryUseCase: RemoveStoryUseCase
    ) {
        self.state = state
        self.getStoriesUseCase = getStoriesUseCase
        self.removeStoryUseCase = removeStoryUseCase
    }
    
    @MainActor
    func load() {
        Task {
            do {
                state.type = .loading
                state.stories = try await getStoriesUseCase.execute()
                if (state.stories.isEmpty) {
                    state.type = .empty
                } else {
                    state.type = .loaded
                }
            } catch let error {
                state.type = .error
                Logger.info(error)
            }
        }
    }
    
    @MainActor
    func removeStory(offsets: IndexSet) {
        offsets.forEach { index in
            Task {
                do {
                    let storyId = state.stories[index].id
                    try await removeStoryUseCase.execute(storyId: storyId)
                    state.stories.remove(at: index)
                    if (state.stories.isEmpty) {
                        state.type = .empty
                    } else {
                        state.type = .loaded
                    }
                } catch let error {
                    Logger.info(error)
                }
            }
        }
    }
}
