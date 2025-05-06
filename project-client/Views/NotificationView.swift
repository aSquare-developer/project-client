import SwiftUI

enum NotificationType {
    case success
    case warning
    case error
    case info

    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.octagon.fill"
        case .info: return "info.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        case .info: return .blue
        }
    }
}

struct NotificationView: View {
    
    let notificationWrapper: NotificationWrapper
    
    let type: NotificationType

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: type.icon)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(type.color)

            Text(notificationWrapper.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

#Preview {
    NotificationView(notificationWrapper: NotificationWrapper(message: "Some message"), type: .success)
}
