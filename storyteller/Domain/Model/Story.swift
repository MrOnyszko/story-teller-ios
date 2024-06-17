import Foundation

struct Story: Identifiable, Hashable, Equatable {
    let id: String
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
