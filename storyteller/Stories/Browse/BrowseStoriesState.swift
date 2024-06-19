struct BrowseStoriesState: Hashable, Equatable {
    var type: StateType = StateType.loading
    var stories: [Story] = []
    
    enum StateType {
       case loading, loaded, empty, error
    }
}
