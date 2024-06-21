import SwiftUI

@main
struct storytellerApp: App {
        
    var body: some Scene {
        WindowGroup {
            AppScreen(
                getIt: GetItModule.create(isStoredInMemoryOnly: false),
                navigationDestinationFactory: NavigationDestinationFactory(getIt: GetItContainer.shared)
            )
        }
    }
}

struct AppScreen: View {
    
    @ObservedObject var router = GoRouter()
    
    let getIt: GetIt
    
    let navigationDestinationFactory: NavigationDestinationFactory
    
    var body: some View {
        SnackbarHost {
            NavigationStack(
                path: $router.path,
                root: {
                    BrowseStoriesRoute().build(getIt: getIt)
                        .navigationDestination(
                            for: GoRouter.RouteDestination.self,
                            destination: navigationDestinationFactory.create
                        )
                }
            )
            .environmentObject(router)
        }
    }
}

class NavigationDestinationFactory {
    
    private let getIt: GetIt
    
    init(getIt: GetIt) {
        self.getIt = getIt
    }
    
    @ViewBuilder
    func create(destination: GoRouter.RouteDestination) -> some View {
        switch destination.value {
        case let addStory as AddStoryRoute:
            addStory.build(getIt: getIt)
        case let viewStory as ViewStoryRoute:
            viewStory.build(getIt: getIt)
        default:
            Text("missing_navigation_destination_message")
        }
    }
}

#Preview {
    AppScreen(
        getIt: GetItModule.create(isStoredInMemoryOnly: true),
        navigationDestinationFactory: NavigationDestinationFactory(getIt: GetItContainer.shared)
    )
}
