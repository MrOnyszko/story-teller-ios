import Foundation

struct ViewStoryState: Hashable, Equatable {
    var type: StateType = .loading
    var storyId: String
    var story: Story? = nil
    var translations: [StoryTranslation] = []
    
    enum StateType {
        case loading, loaded, error
    }
}
