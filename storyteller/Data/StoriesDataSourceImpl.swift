import Foundation
import SwiftData

final class StoriesDataSourceImpl: StoriesDataSource {
    
    private let modelContext: ModelContext
    private let storyMapper: StoryMapper
    private let translationMapper: TranslationMapper
    
    init(modelContext: ModelContext, storyMapper: StoryMapper, translationMapper: TranslationMapper) {
        self.modelContext = modelContext
        self.storyMapper = storyMapper
        self.translationMapper = translationMapper
    }
    
    func languages() async throws -> [String] {
        return [
            "en",
            "pl",
            "de",
            "es"
        ]
    }
    
    func getStories() async throws -> [Story] {
        let descriptor = FetchDescriptor<StoryEntity>()
        let result = try modelContext.fetch(descriptor)
        return result.map(storyMapper.map)
    }
    
    func getStory(id: String) async throws -> Story? {
        let descriptor = FetchDescriptor<StoryEntity>(
            predicate: #Predicate {
                $0.id == id
            }
        )
        let result = try modelContext.fetch(descriptor).map(storyMapper.map)
        return result.first
    }
    
    func getStoryTranslations(storyId: String) async throws -> [StoryTranslation] {
        let descriptor = FetchDescriptor<TranslationEntity>(
            predicate: #Predicate {
                $0.storyId == storyId
            }
        )
        let result = try modelContext.fetch(descriptor)
        return result.map(translationMapper.map)
    }
    
    func addStory(title: String, content: String, languageCode: String) async throws -> Story {
        let newStory = StoryEntity(id: UUID().uuidString, title: title, content: content, languageCode: languageCode, createdAt: Date())
        modelContext.insert(newStory)
        try modelContext.save()
        return storyMapper.map(entity: newStory)
    }
    
    func addTranslation(storyId: String, languageCode: String, title: String, content: String) async throws -> StoryTranslation {
        let newTranslation = TranslationEntity(id: UUID().uuidString, storyId: storyId, languageCode: languageCode, title: title, content: content, createdAt: Date())
        modelContext.insert(newTranslation)
        try modelContext.save()
        return translationMapper.map(entity: newTranslation)
    }
    
    func removeStory(storyId: String) async throws {
        try modelContext.delete(model: StoryEntity.self, where: #Predicate { story in
            story.id == storyId
        })
        
        try modelContext.delete(model: TranslationEntity.self, where: #Predicate { translation in
            translation.storyId == storyId
        })
        
        try modelContext.save()
    }
}
