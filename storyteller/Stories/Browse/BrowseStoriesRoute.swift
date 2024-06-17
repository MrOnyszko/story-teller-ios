import Foundation
import SwiftUI

struct BrowseStoriesRoute: Route {
    var name: String = "browse-stories"
}

extension BrowseStoriesRoute {
    
    @ViewBuilder
    func build(getIt: GetIt) -> some View {
        BrowseStoriesScreen(
            viewModel: BrowseStoriesViewModel(
                state: BrowseStoriesState(),
                getStoriesUseCase: getIt.get(type: GetStoriesUseCase.self),
                removeStoryUseCase: getIt.get(type: RemoveStoryUseCase.self)
            )
        )
    }
}
