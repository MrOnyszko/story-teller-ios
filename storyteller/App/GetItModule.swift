import Foundation
import SwiftData

class GetItModule {
    
    @MainActor
    static func create(isStoredInMemoryOnly: Bool) -> GetIt {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                StoryEntity.self,
                TranslationEntity.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        let getIt = GetItContainer.shared
        
        getIt.registerFactory(type: OllamaService.self) { _ in
            OllamaService(session: URLSession.shared)
        }
        
        getIt.registerFactory(type: StoryMapper.self) { _ in
            StoryMapper()
        }
        getIt.registerFactory(type: TranslationMapper.self) { _ in
            TranslationMapper()
        }
        
        getIt.registerFactory(type: StoriesDataSource.self) { it in
            StoriesDataSourceImpl(
                modelContext: sharedModelContainer.mainContext,
                storyMapper: it.get(type: StoryMapper.self),
                translationMapper: it.get(type: TranslationMapper.self)
            )
        }
        getIt.registerFactory(type: GetStoriesUseCase.self) { it in
            GetStoriesUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: GetStoryUseCase.self) { it in
            GetStoryUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: AddStoryUseCase.self) { it in
            AddStoryUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: AddStoryTranslationUseCase.self) { it in
            AddStoryTranslationUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: RemoveStoryUseCase.self) { it in
            RemoveStoryUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: GetLanguagesUseCase.self) { it in
            GetLanguagesUseCaseImpl(storiesDataSource: it.get(type: StoriesDataSource.self))
        }
        getIt.registerFactory(type: TranslateTextUseCase.self) { it in
            TranslateTextUseCaseImpl(ollamaService: it.get(type: OllamaService.self))
        }
        return getIt
    }
}
