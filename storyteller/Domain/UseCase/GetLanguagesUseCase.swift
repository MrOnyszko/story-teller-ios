import Foundation

// sourcery: AutoMockable
protocol GetLanguagesUseCase {
    func execute() async throws -> [String]
}

final class GetLanguagesUseCaseImpl: GetLanguagesUseCase {
    private let storiesDataSource: StoriesDataSource
    
    init(storiesDataSource: StoriesDataSource) {
        self.storiesDataSource = storiesDataSource
    }
    
    func execute() async throws -> [String] {
        return try await storiesDataSource.languages()
    }
}
