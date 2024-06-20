import XCTest
import MockSwift
import Combine
@testable import storyteller

final class AddStoryViewModelTest: XCTestCase {
    
    @Mock var addStoryUseCase: AddStoryUseCase
    @Mock var addStoryTranslationUseCase: AddStoryTranslationUseCase
    @Mock var getLanguagesUseCase: GetLanguagesUseCase
    @Mock var translateTextUseCase: TranslateTextUseCase
    
    let languages = ["en", "pl"]
    let nsLocale = NSLocale(localeIdentifier: "en")
    let nsLocales = [NSLocale(localeIdentifier: "en"), NSLocale(localeIdentifier: "pl")]
    let translations = [TranslaionItem(id: "pl", title: "", content: "", languageCode: "pl")]
    
    func sut(state: AddStoryState) -> AddStoryViewModel {
        return AddStoryViewModel(
            state: state,
            addStoryUseCase: addStoryUseCase,
            addStoryTranslationUseCase: addStoryTranslationUseCase,
            getLanguagesUseCase: getLanguagesUseCase,
            translateTextUseCase: translateTextUseCase
        )
    }
    
    @MainActor
    func test_Given_NoError_When_load_Then_emit_loaded_state() async throws {
        given(getLanguagesUseCase).execute().willReturn(languages)
        
        let sut = sut(
            state: AddStoryState()
        )
        
        let states = [
            AddStoryState(type: AddStoryState.StateType.loading),
            AddStoryState(type: AddStoryState.StateType.loading, languages: nsLocales),
            AddStoryState(type: AddStoryState.StateType.loading, title: "", content: "", langauge: nsLocale, languages: nsLocales),
            AddStoryState(type: AddStoryState.StateType.loading, title: "", content: "", langauge: nsLocale, languages: nsLocales, translations: translations),
            AddStoryState(type: AddStoryState.StateType.loaded, title: "", content: "", langauge: nsLocale, languages: nsLocales, translations: translations)
        ]
        
        await assertPublisher(
            sut.$state.dropFirst(),
            emits: states,
            when: {
                sut.load()
            }
        )
    }
    
    @MainActor
    func test_Given_Error_When_load_Then_emit_error_state() async throws {
        given(getLanguagesUseCase).execute().willThrow(TestError.generic)
        
        let sut = sut(
            state: AddStoryState()
        )
        
        let states = [
            AddStoryState(type: AddStoryState.StateType.loading),
            AddStoryState(type: AddStoryState.StateType.error),
        ]
        
        await assertPublisher(
            sut.$state.dropFirst(),
            emits: states,
            when: {
                sut.load()
            }
        )
    }
    
    @MainActor
    func test_Given_NoError_When_save_Then_emit_loaded_state_and_pop_the_screen() async throws {
        let story = Story._test(
            title: "This is awesome",
            content: "Yes it is.",
            languageCode: "en"
        )
        
        let translation = TranslaionItem(
            id: "pl",
            title: "To jest niesamowite.",
            content: "Tak to jest.",
            languageCode: "pl"
        )
        
        let translations = [translation]
        
        let initialState = AddStoryState(
            type: AddStoryState.StateType.loaded,
            title: story.title,
            content: story.content,
            langauge: nsLocale,
            languages: nsLocales,
            translations: translations
        )
        
        given(addStoryUseCase)
            .execute(
                title: initialState.title,
                content: initialState.content,
                languageCode: initialState.langauge.languageCode
            )
            .willReturn(story)
        
        given(addStoryTranslationUseCase)
            .execute(
                storyId: story.id,
                title: translation.title,
                content: translation.content,
                languageCode: translation.languageCode
            )
            .willReturn(StoryTranslation._test())
        
        let sut = sut(
            state: initialState
        )
        
        let states = [
            initialState,
            AddStoryState(
                type: AddStoryState.StateType.submitting,
                title: initialState.title,
                content: initialState.content,
                langauge: initialState.langauge,
                languages: initialState.languages,
                translations: initialState.translations
            ),
            AddStoryState(
                type: AddStoryState.StateType.loaded,
                title: initialState.title,
                content: initialState.content,
                langauge: initialState.langauge,
                languages: initialState.languages,
                translations: initialState.translations
            )
        ]

        await assertPublisher(
            sut.$state,
            emits: states,
            when: {
                sut.save()
            }
        )
    }
    
    @MainActor
    func test_Given_NoError_When_translate_Then_emit_with_translation() async throws {
        let story = Story._test(
            title: "This is awesome",
            content: "Yes it is.",
            languageCode: "en"
        )
        
        let untranslatedItem = TranslaionItem(id: "pl", title: "", content: "", languageCode: "pl")
        
        let translation = TranslaionItem(
            id: "pl",
            title: "To jest niesamowite.",
            content: "Tak to jest.",
            languageCode: "pl"
        )
        
        let translations = [translation]
        
        let initialState = AddStoryState(
            type: AddStoryState.StateType.loaded,
            title: story.title,
            content: story.content,
            langauge: nsLocale,
            languages: nsLocales,
            translations: [untranslatedItem]
        )
        
        given(translateTextUseCase)
            .execute(
                model: "llama3:8b",
                text: initialState.title,
                languageCode: translation.languageCode
            )
            .willReturn(translation.title)
        
        given(translateTextUseCase)
            .execute(
                model: "llama3:8b",
                text: initialState.content,
                languageCode: translation.languageCode
            )
            .willReturn(translation.content)
        
        let sut = sut(
            state: initialState
        )
        
        let states = [
            initialState,
            AddStoryState(
                type: AddStoryState.StateType.translating,
                title: initialState.title,
                content: initialState.content,
                langauge: initialState.langauge,
                languages: initialState.languages,
                translations: initialState.translations
            ),
            AddStoryState(
                type: AddStoryState.StateType.translating,
                title: initialState.title,
                content: initialState.content,
                langauge: initialState.langauge,
                languages: initialState.languages,
                translations: translations
            ),
            AddStoryState(
                type: AddStoryState.StateType.loaded,
                title: initialState.title,
                content: initialState.content,
                langauge: initialState.langauge,
                languages: initialState.languages,
                translations: translations
            )
        ]
        
        await assertPublisher(
            sut.$state,
            emits: states,
            when: {
                sut.translate(translation: untranslatedItem)
            }
        )
    }
}
