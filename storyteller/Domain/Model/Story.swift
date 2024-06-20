import Foundation

struct Story: Identifiable, Hashable {
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

extension Story {
    static func _test(
        id: String? = nil,
        title: String? = nil,
        content: String? = nil,
        languageCode: String? = nil,
        createdAt: Date? = nil
    ) -> Story {
        return Story(
            id: id ?? "1",
            title: title ?? "Title",
            content: content ?? "Content",
            languageCode: languageCode ?? "en",
            createdAt: createdAt ?? Date(timeIntervalSince1970: 1718604164)
        )
    }
}
