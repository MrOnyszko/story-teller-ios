import Foundation

class TranslationMapper {
    func map(entity: TranslationEntity) -> StoryTranslation {
        return StoryTranslation(
            id: entity.id,
            storyId: entity.storyId,
            languageCode: entity.languageCode,
            title: entity.title,
            content: entity.content,
            createdAt: entity.createdAt
        )
    }
}
