import Foundation
import SwiftUI
import Combine
import Translation

class AddStoryViewModel : ObservableObject {
    
    @Published var state: AddStoryState {
        didSet { Logger.info(state) }
    }
    
    let didSaveStory = PassthroughSubject<AddStoryState.SideEffect, Never>()
    
    private let addStoryUseCase: AddStoryUseCase
    private let addStoryTranslationUseCase: AddStoryTranslationUseCase
    private let getLanguagesUseCase: GetLanguagesUseCase
    private let translateTextUseCase: TranslateTextUseCase
    
    init(
        state: AddStoryState,
        addStoryUseCase: AddStoryUseCase,
        addStoryTranslationUseCase: AddStoryTranslationUseCase,
        getLanguagesUseCase: GetLanguagesUseCase,
        translateTextUseCase: TranslateTextUseCase
    ) {
        self.state = state
        self.addStoryUseCase = addStoryUseCase
        self.addStoryTranslationUseCase = addStoryTranslationUseCase
        self.getLanguagesUseCase = getLanguagesUseCase
        self.translateTextUseCase = translateTextUseCase
    }
    
    @MainActor
    func load() {
        Task {
            do {
                state.type = .loading
                
                let languages = try await getLanguagesUseCase.execute().map { code in NSLocale(localeIdentifier: code) }
                
                state.languages = languages
                state.langauge = languages.first!
                
                state.translations = languages
                    .filter { it in it != state.langauge }
                    .map { locale in
                        TranslaionItem(
                            id: locale.languageCode,
                            title: "",
                            content: "",
                            languageCode: locale.languageCode
                        )
                    }
                
                state.type = .loaded
            } catch let error {
                state.type = .error
                Logger.error(error)
            }
        }
    }
    
    @MainActor
    func save() {
        Task {
            do {
                state.type = .submitting
                
                let story = try await addStoryUseCase.execute(
                    title: state.title,
                    content: state.content,
                    languageCode: state.langauge.languageCode
                )
                
                for item in state.translations {
                    let translation = try await addStoryTranslationUseCase.execute(
                        storyId: story.id,
                        title: item.title,
                        content: item.content,
                        languageCode: item.languageCode
                    )
                    
                    Logger.info(translation)
                }
                
                state.type = .loaded
                
                didSaveStory.send(AddStoryState.SideEffect.closeScreen(story: story))
                
                Logger.info(story)
            } catch let error {
                state.type = .error
                Logger.info(error)
            }
        }
    }
    
    @MainActor
    func translate(translation: TranslaionItem) {
        Task {
            do {
                state.type = .translating
                let translatedTitle = try await translateTextUseCase.execute(
                    model: "llama3:8b",
                    text: state.title,
                    languageCode: translation.languageCode
                )
                let translatedContent = try await translateTextUseCase.execute(
                    model: "llama3:8b",
                    text: state.content,
                    languageCode: translation.languageCode
                )
                
                if let index = state.translations.firstIndex(of: translation) {
                    
                    let newTranslation = TranslaionItem(
                        id: translation.id,
                        title: translatedTitle,
                        content: translatedContent,
                        languageCode: translation.languageCode
                    )
                    
                    state.translations[index] = newTranslation
                }
                
                state.type = .loaded
            } catch let error {
                Logger.error(error)
            }
        }
    }
    
    func filterTranslations(language: NSLocale) {
        state.translations = state.languages
            .filter { it in it != language }
            .map { locale in
                TranslaionItem(
                    id: UUID().uuidString,
                    title: "",
                    content: "",
                    languageCode: locale.languageCode
                )
            }
    }
}
