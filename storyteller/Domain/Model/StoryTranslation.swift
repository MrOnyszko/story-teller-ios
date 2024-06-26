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

extension StoryTranslation {
    static func _test() -> StoryTranslation {
        return StoryTranslation(
            id: "10",
            storyId: "1",
            languageCode: "en",
            title: "Title",
            content: "Content",
            createdAt: Date(timeIntervalSince1970: 1718604164)
        )
    }
}
