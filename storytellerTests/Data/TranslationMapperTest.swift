import XCTest
@testable import storyteller

final class TranslationMapperTest: XCTestCase {

    func test_Given_has_entity_When_map_Then_return_model() throws {
        let entity = TranslationEntity(
            id: "1",
            storyId: "2",
            languageCode: "en",
            title: "Title",
            content: "Content",
            createdAt: Date(timeIntervalSince1970: 1718604164)
        )
        
        let expected = StoryTranslation(
            id: "1",
            storyId: "2",
            languageCode: "en",
            title: "Title",
            content: "Content",
            createdAt: Date(timeIntervalSince1970: 1718604164)
        )
        
        let sut = TranslationMapper()
        
        let result = sut.map(entity: entity)
        
        XCTAssertEqual(expected, result)
    }
}
