import Foundation
import SwiftUI

public protocol Route: Hashable {
    var name: String { get }
}

final class GoRouter : ObservableObject {
    struct RouteDestination: Route {
        let name: String
        let value: any Route
        
        private let _hash: (inout Hasher) -> Void

        init<T: Route>(_ base: T) {
            self.name = base.name
            self.value = base
            self._hash = { hasher in
                base.hash(into: &hasher)
            }
        }

        func hash(into hasher: inout Hasher) {
            _hash(&hasher)
        }

        static func == (lhs: RouteDestination, rhs: RouteDestination) -> Bool {
            lhs.name == rhs.name
        }
    }
    
    
    @Published var path = NavigationPath()
    
    func go(to destination: any Route) {
        path.append(RouteDestination(destination))
    }
    
    func back() {
        path.removeLast()
    }
    
    func root() {
        path.removeLast(path.count)
    }
}
