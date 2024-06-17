import Foundation

// sourcery: AutoMockable
protocol GetStoryUseCase {
    func execute(storyId: String) async throws -> GetStoryResult
}

struct GetStoryResult {
    let story: Story
    let translations: [StoryTranslation]
}

enum GetStoryError : Error {
    case notFound
}

final class GetStoryUseCaseImpl: GetStoryUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute(storyId: String) async throws -> GetStoryResult {
        guard let story = try await storiesDataSource.getStory(id: storyId) else {
            throw GetStoryError.notFound
        }
        let translations = try await storiesDataSource.getStoryTranslations(storyId: storyId)
        return GetStoryResult(story: story, translations: translations)
    }
}
