import Foundation

// sourcery: AutoMockable
protocol AddStoryUseCase {
    func execute(title: String, content: String, languageCode: String) async throws -> Story
}

final class AddStoryUseCaseImpl: AddStoryUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute(title: String, content: String, languageCode: String) async throws -> Story {
        return try await storiesDataSource.addStory(title: title, content: content, languageCode: languageCode)
    }
}
