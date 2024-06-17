import Foundation
import SwiftUI

struct StoryItem: View {
    
    let id: String
    let title: String
    let content: String
    let languageCode: String
    let onPressed: (_ id: String) -> Void
    
    var body: some View {
        VStack(
            alignment: .leading,
            content: {
                Text(title)
                    .font(.headline)
                Text(content)
                    .font(.footnote)
                Text(languageCode)
                    .font(.caption)
            }
        )
        .onTapGesture(
            perform: {
                onPressed(id)
            }
        )
    }
}
