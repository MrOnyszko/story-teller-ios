import Foundation

// sourcery: AutoMockable
protocol GetStoriesUseCase {
    func execute() async throws -> [Story]
}

final class GetStoriesUseCaseImpl: GetStoriesUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute() async throws -> [Story] {
        return try await storiesDataSource.getStories()
    }
}
