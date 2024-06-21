import Foundation
import SwiftUI

struct ViewStoryRoute: Route {    
    var name: String = "view-story"
    var storyId: String
    
    init(storyId: String) {
        self.storyId = storyId
    }
}

extension ViewStoryRoute {
    
    @ViewBuilder
    func build(getIt: GetIt) -> some View {
        ViewStoryScreen(
            viewModel: ViewStoryViewModel(
                state: ViewStoryState(
                    storyId: storyId
                ),
                getStoryUseCase: getIt.get(type: GetStoryUseCase.self)
            )
        )
    }
}
