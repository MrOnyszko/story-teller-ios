import Foundation

// sourcery: AutoMockable
protocol RemoveStoryUseCase {
    func execute(storyId: String) async throws
}

final class RemoveStoryUseCaseImpl: RemoveStoryUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute(storyId: String) async throws {
        try await storiesDataSource.removeStory(storyId: storyId)
    }
}
