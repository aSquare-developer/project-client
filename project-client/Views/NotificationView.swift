import SwiftUI

struct NotificationView: View {
    
    let message: String
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.horizontal)
                .padding(.top, 20)
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.5), value: isVisible)
        }
    }
}

#Preview {
    NotificationView(message: "Some important message that might be quite long", isVisible: .constant(true))
}
