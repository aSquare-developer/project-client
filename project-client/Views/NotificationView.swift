import SwiftUI

struct NotificationView: View {
    
    let message: String
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            VStack {
                Text(message)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                    .padding(.top, 20)
                    .animation(.easeInOut(duration: 0.5), value: isVisible) // Добавлена анимация
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: isVisible)
        }
    }
}
