import SwiftUI

struct LoadingView: View {
    var message: String = "Please wait…"
    
    @State private var isVisible = false

    var body: some View {
        ZStack {
            if isVisible {
                Color.black.opacity(0.4).ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)

                    Text(message)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(16)
                .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.25)) {
                isVisible = true
            }
        }
        .onDisappear {
            isVisible = false
        }
    }
}



#Preview {
    LoadingView()
}
