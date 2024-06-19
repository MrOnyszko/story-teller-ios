import Foundation
import SwiftUI

struct ViewStoryScreen: View {
    @StateObject var viewModel: ViewStoryViewModel
    
    var body: some View {
        ViewStoryContent(state: viewModel.state)
            .onAppear(perform: viewModel.load)
    }
}

struct ViewStoryContent: View {
    var state: ViewStoryState
    
    var body: some View {
        VStack {
            switch state.type {
            case .loading:
                ProgressView()
            case .loaded:
                List {
                    Section(header: Text("story_label")) {
                        StoryItem(
                            id: state.story!.id,
                            title: state.story!.title,
                            content: state.story!.content,
                            languageCode: state.story!.languageCode,
                            onPressed: { _ in }
                        )
                    }
                    Section(header: Text("translations_label")) {
                        ForEach(state.translations) { translation in
                            StoryItem(
                                id: translation.id,
                                title: translation.title,
                                content: translation.content,
                                languageCode: translation.languageCode,
                                onPressed: { _ in }
                            )
                        }
                    }
                }
            case .error:
                ErrorView()
            }
        }
        .navigationTitle(Text("story_detail_screen_title"))
    }
}

#Preview {
    NavigationStack {
        ViewStoryContent(
            state: ViewStoryState(
                type: ViewStoryState.StateType.loaded,
                storyId: "1",
                story: Story(
                    id: "",
                    title: "Title",
                    content: "Content",
                    languageCode: "en",
                    createdAt: Date()
                ),
                translations: [
                    StoryTranslation(
                        id: "1",
                        storyId: "1",
                        languageCode: "pl",
                        title: "Tytuł",
                        content: "Kontent",
                        createdAt: Date()
                    )
                ]
            )
        )
    }
}
