struct BrowseStoriesState: Hashable {
    var type: StateType = StateType.loading
    var stories: [Story] = []
    
    enum StateType {
       case loading, loaded, empty, error
    }
}
