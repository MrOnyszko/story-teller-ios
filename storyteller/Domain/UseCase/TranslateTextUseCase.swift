import Foundation

// sourcery: AutoMockable
protocol TranslateTextUseCase {
    func execute(model: String, text: String, languageCode: String) async throws -> String
}

final class TranslateTextUseCaseImpl: TranslateTextUseCase {
    private let ollamaService: OllamaService
    
    init(ollamaService: OllamaService) {
        self.ollamaService = ollamaService
    }
    
    func execute(model: String = "llama3:8b", text: String, languageCode: String) async throws -> String {
        return try await ollamaService.translate(
            model: model, 
            prompt: "Translate the following text: '''\(text)''' to a language expressed by language code: '''\(languageCode)'''. Respond only with TRANSLATION. NO COMMENT!"
        )
    }
}
