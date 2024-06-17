import Foundation
import SwiftUI

struct ErrorView: View {
    
    let text: String? = nil
    
    var body: some View {
        if text == nil {
            Text("generic_error_message")
        } else {
            Text(text!)
        }
    }
}
