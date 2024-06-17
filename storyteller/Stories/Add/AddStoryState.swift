import Foundation

struct AddStoryState: Hashable {
    var type: StateType = .loaded
    var title: String = ""
    var content: String = ""
    var langauge: NSLocale = NSLocale(localeIdentifier: "en")
    var languages: [NSLocale] = []
    var translations: [TranslaionItem] = []
    
    enum StateType {
        case loading, submitting, translating, loaded, error
    }
}

struct TranslaionItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var languageCode: String
    
    init(id: String, title: String, content: String, languageCode: String) {
        self.id = id
        self.title = title
        self.content = content
        self.languageCode = languageCode
    }
}

extension AddStoryState {
    
    var isTranslating: Bool {
        get {
            return type == .translating
        }
    }
    
    var hasInvalidTranslations: Bool {
        get {
            return translations.filter { translation in
                !translation.title.isEmpty && !translation.content.isEmpty
            }.isEmpty
        }
    }
    
    var isSaveDisabled: Bool {
        get {
            return title.isEmpty && content.isEmpty && hasInvalidTranslations
        }
    }
    
    var isTranslateDisabled: Bool {
        get {
            return type == .translating && isSaveDisabled
        }
    }
}
