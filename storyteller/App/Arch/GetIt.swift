import Foundation

public protocol GetIt {
    func registerFactory<T>(type: T.Type, block: @escaping (GetIt) -> T)
    func get<T>(type: T.Type) -> T
}

public class GetItContainer {
    public static let shared: GetItContainer = GetItContainer()
    private var dependencies: [String: (() -> Any)] = [:]
}

extension GetItContainer : GetIt {    
    public func registerFactory<T>(type: T.Type, block: @escaping (GetIt) -> T) {
        let key = key(for: type)
        dependencies[key] = {
            block(self)
        }
    }
    
    public func get<T>(type: T.Type) -> T {
        let key = key(for: type)
        guard let dependency = dependencies[key]?() as? T else {
            preconditionFailure("There is no dependency registered for this type = \(key)")
        }
        return dependency
    }
    
    private func key<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
}
