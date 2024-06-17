import Foundation
import SwiftData

@Model
class StoryEntity: Identifiable, Hashable, Equatable {
    @Attribute(.unique) let id: String
    let title: String
    let content: String
    let languageCode: String
    let createdAt: Date
    
    init(id: String, title: String, content: String, languageCode: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.content = content
        self.languageCode = languageCode
        self.createdAt = createdAt
    }
}
