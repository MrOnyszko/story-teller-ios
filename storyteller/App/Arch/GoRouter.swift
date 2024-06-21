import Foundation
import SwiftUI
import Combine

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
    private var _destinations: [String] = []
    private var _results: [String: PassthroughSubject<Any, Never>] = [:]
    
    func go(to destination: any Route) {
        let route = RouteDestination(destination)
        path.append(route)
    }
    
    func back() {
        path.removeLast()
    }
    
    func back<T>(type: T.Type, value: T) {
        let key = key(for: type)
        let publisher = _results[key]
        publisher?.send(value)
        
        path.removeLast()
    }
    
    func root() {
        path.removeLast(path.count)
        _destinations.removeLast(_destinations.count)
    }
    
    func resultRecipient<T>(for result: T.Type) -> AnyPublisher<T, Never> {
        let key = key(for: result)
        if _results[key] == nil {
            _results[key] = PassthroughSubject<Any, Never>()
        }
        return _results[key]!.map { it in it as! T }.eraseToAnyPublisher()
    }
    
    private func key<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
}

extension View {
    func onReceiveResult<T>(
        router: GoRouter,
        type: T.Type,
        block: @escaping (T) -> Void
    ) -> some View {
        self.onReceive(router.resultRecipient(for: type)) { result in
            block(result)
        }
    }
}
