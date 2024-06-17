import Foundation

struct StoryTranslation: Identifiable, Hashable, Equatable {
    let id: String
    let storyId: String
    let languageCode: String
    let title: String
    let content: String
    let createdAt: Date
    
    init(id: String, storyId: String, languageCode: String, title: String, content: String, createdAt: Date) {
        self.id = id
        self.storyId = storyId
        self.languageCode = languageCode
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
}
