import Foundation

// sourcery: AutoMockable
protocol StoriesDataSource {
    
    func languages() async throws -> [String]
    
    func getStories() async throws -> [Story]
    
    func getStory(id: String) async throws -> Story?
    
    func getStoryTranslations(storyId: String) async throws -> [StoryTranslation]
    
    func addStory(title: String, content: String, languageCode: String) async throws -> Story
    
    func addTranslation(storyId: String, langaugeCode: String, title: String, content: String) async throws -> StoryTranslation
    
    func removeStory(storyId: String) async throws
}
