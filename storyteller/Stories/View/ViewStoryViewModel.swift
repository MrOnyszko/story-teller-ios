import Foundation
import SwiftUI

class ViewStoryViewModel: ObservableObject {
    
    @Published var state: ViewStoryState {
        didSet { Logger.info(state) }
    }
    
    private let getStoryUseCase: GetStoryUseCase
    
    init(state: ViewStoryState, getStoryUseCase: GetStoryUseCase) {
        self.state = state
        self.getStoryUseCase = getStoryUseCase
    }
    
    @MainActor
    func load() {
        Task {
            do {
                state.type = .loading
                let result = try await getStoryUseCase.execute(storyId: state.storyId)
                state.story = result.story
                state.translations = result.translations
                state.type = .loaded
            } catch let error {
                state.type = .error
                Logger.error(error)
            }
        }
    }
}
