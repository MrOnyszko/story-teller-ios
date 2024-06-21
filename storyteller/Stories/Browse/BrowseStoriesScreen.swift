import Foundation
import SwiftUI

struct BrowseStoriesScreen: View {
    @EnvironmentObject var router: GoRouter
    @EnvironmentObject var snackbar: SnackbarController
    @StateObject var viewModel: BrowseStoriesViewModel
    
    var body: some View {
        BrowseStoriesContent(
            state: viewModel.state,
            onItemPressed: { id in
                router.go(to: ViewStoryRoute(storyId: id))
            },
            onItemDeletePressed: viewModel.removeStory,
            onAddPressed: {
                router.go(to: AddStoryRoute())
            }
        )
        .onReceiveResult(router: router, type: AddStoryResult.self) { result in
            Logger.warning(String(describing: result))
            snackbar.show(data: SnackbarData(message: "story_added", style: SnackbarStyle.success))
        }
        .onAppear(perform: viewModel.load)
    }
}

struct BrowseStoriesContent: View {
    var state: BrowseStoriesState
    
    var onItemPressed: (String) -> Void
    var onItemDeletePressed: (IndexSet) -> Void
    var onAddPressed: () -> Void
    
    var body: some View {
        VStack {
            switch state.type {
            case .loading:
                ProgressView()
            case .loaded:
                List {
                    ForEach(state.stories) { story in
                        StoryItem(
                            id: story.id,
                            title: story.title,
                            content: story.content,
                            languageCode: story.languageCode,
                            onPressed: onItemPressed
                        )
                    }
                    .onDelete(perform: onItemDeletePressed)
                }
            case .empty:
                Text("missing_stories_message")
            case .error:
                ErrorView()
            }
        }
        .navigationTitle(Text("stories_screen_title"))
        .toolbar {
            ToolbarItem(
                placement: .navigationBarTrailing,
                content: {
                    Button(
                        action: onAddPressed,
                        label: {
                            Text("add_button")
                        }
                    )
                }
            )
        }
    }
}

#Preview {
    NavigationStack {
        BrowseStoriesContent(
            state: BrowseStoriesState(
                type: BrowseStoriesState.StateType.loaded,
                stories: [
                    Story(
                        id: "",
                        title: "Title",
                        content: "Content",
                        languageCode: "en",
                        createdAt: Date()
                    )
                ]
            ),
            onItemPressed: { _ in },
            onItemDeletePressed: { _ in },
            onAddPressed: {}
        )
    }
}
