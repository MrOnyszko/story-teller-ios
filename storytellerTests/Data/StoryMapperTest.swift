import XCTest
@testable import storyteller

final class StoryMapperTest: XCTestCase {

    func testGiven_has_entity_When_map_Then_return_model() throws {
        let entity = StoryEntity(
            id: "1",
            title: "Title",
            content: "Content",
            languageCode: "en",
            createdAt: Date(timeIntervalSince1970: 1718604164)
        )
        
        let expected = Story(
            id: "1",
            title: "Title",
            content: "Content",
            languageCode: "en",
            createdAt: Date(timeIntervalSince1970: 1718604164)
        )
        
        let sut = StoryMapper()
        
        let result = sut.map(entity: entity)
        
        XCTAssertEqual(expected, result)
    }
}
