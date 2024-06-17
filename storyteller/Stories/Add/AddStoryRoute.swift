import Foundation
import SwiftUI

struct AddStoryRoute: Route {
    var name: String = "add-story"
}

extension AddStoryRoute {
    
    @ViewBuilder
    func build(getIt: GetIt) -> some View {
        AddStoryScreen(
            viewModel: AddStoryViewModel(
                state: AddStoryState(), 
                addStoryUseCase: getIt.get(type: AddStoryUseCase.self),
                addStoryTranslationUseCase: getIt.get(type: AddStoryTranslationUseCase.self),
                getLanguagesUseCase: getIt.get(type: GetLanguagesUseCase.self),
                translateTextUseCase: getIt.get(type: TranslateTextUseCase.self)
            )
        )
    }
}
