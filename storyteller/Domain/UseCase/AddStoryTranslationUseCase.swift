import Foundation

// sourcery: AutoMockable
protocol AddStoryTranslationUseCase {
    func execute(storyId: String, title: String, content: String, languageCode: String) async throws -> StoryTranslation
}

final class AddStoryTranslationUseCaseImpl: AddStoryTranslationUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute(storyId: String, title: String, content: String, languageCode: String) async throws -> StoryTranslation {
        return try await storiesDataSource.addTranslation(
            storyId: storyId,
            langaugeCode: languageCode,
            title: title,
            content: content
        )
    }
}
