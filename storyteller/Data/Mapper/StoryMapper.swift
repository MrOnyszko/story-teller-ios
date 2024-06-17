import Foundation

class StoryMapper {
    func map(entity: StoryEntity) -> Story {
        return Story(
            id: entity.id,
            title: entity.title,
            content: entity.content,
            languageCode: entity.languageCode,
            createdAt: entity.createdAt
        )
    }
}
