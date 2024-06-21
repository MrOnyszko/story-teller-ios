import Foundation
import SwiftUI

class SnackbarController: ObservableObject {
    @Published private(set) var data: SnackbarData? = nil
    private var workItem: DispatchWorkItem?
    
    func show(data: SnackbarData) {
        self.data = data
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if data.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                self.dismiss()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + data.duration, execute: task)
        }
    }
    
    func dismiss() {
        withAnimation {
            data = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

public struct SnackbarHost<Content> : View where Content : View {
    
    @StateObject var controller: SnackbarController = SnackbarController()
    
    @ViewBuilder var content: () -> Content
    
    public var body: some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                HStack(alignment: VerticalAlignment.bottom) {
                    Spacer()
                    if let data = controller.data {
                        Snackbar(
                            style: data.style,
                            message: data.message,
                            width: data.width,
                            onCancelTapped: controller.dismiss
                        )
                        .animation(.spring, value: controller.data)
                        .transition( AnyTransition.move(edge: .bottom).combined(with: .opacity))
                        .offset(y: -32)
                    }
                },
                alignment: .bottom
            )
            .environmentObject(controller)
    }
}

struct SnackbarData: Equatable {
    var message: LocalizedStringKey
    var style: SnackbarStyle = SnackbarStyle.info
    var duration: Double = 3
    var width: Double = .infinity
}

enum SnackbarStyle {
    case error
    case warning
    case success
    case info
}

extension SnackbarStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

private struct Snackbar: View {
    var style: SnackbarStyle
    var message: LocalizedStringKey
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .font(Font.caption)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.themeColor, lineWidth: 1)
                .opacity(0.6)
        )
        .padding(.horizontal, 16)
    }
}
