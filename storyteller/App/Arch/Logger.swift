import Foundation

enum LogLevel {
    case info, warning, error
    
    var prefix: String {
        switch self {
        case .info:
            return "INFO"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
}

class Logger {
    static func info(_ message: Any) {
        log(message, level: .info)
    }
    
    static func warning(_ message: Any) {
        log(message, level: .warning)
    }
    
    static func error(_ message: Any) {
        log(message, level: .error)
    }
    
    private static func log(_ message: Any, level: LogLevel) {
        #if DEBUG
        print("\(Date()): [\(level.prefix)] \(message)")
        #endif
    }
}
