import XCTest
import MockSwift
@testable import storyteller

final class TranslateTextUseCaseTest: XCTestCase {

    @Mock var ollamaService: OllamaService
    
    func test_Given_NoError_When_execute_Then_add_and_return_story() async throws {
        let sut = TranslateTextUseCaseImpl(
            ollamaService: ollamaService
        )
        
        given(ollamaService)
            .translate(
                model: "llama3:8b",
                prompt: "Translate the following text: '''I will go for a walk.''' to a language expressed by language code: '''pl'''. Respond only with TRANSLATION. NO COMMENT!"
            )
            .willReturn("Pójdę się przejść.")
        
        let result = try await sut.execute(
            model: "llama3:8b", 
            text: "I will go for a walk.",
            languageCode: "pl"
        )
        
        XCTAssertEqual(result, "Pójdę się przejść.")
    }
    
    func test_Given_Error_When_execute_Then_throws() async throws {
        let sut = TranslateTextUseCaseImpl(
            ollamaService: ollamaService
        )
        
        given(ollamaService)
            .translate(
                model: "llama3:8b",
                prompt: "Translate the following text: '''I will go for a walk.''' to a language expressed by language code: '''pl'''. Respond only with TRANSLATION. NO COMMENT!"
            )
            .willThrow(TestError.generic)
        
        await XCTAssertThrowsErrorAsync(
            try await sut.execute(
                model: "llama3:8b",
                text: "I will go for a walk.",
                languageCode: "pl"
            ),
            TestError.generic
        )
    }

}
