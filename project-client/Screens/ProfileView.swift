import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var model: DroppieModel
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        VStack {
            // Log out button
            Button(action: {
                Task {
                    model.logout()
                    appState.routes.append(.login)
                }
            }) {
                Text("Log out")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(16)
                    .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }.padding()
    }
}

#Preview {
    ProfileView()
}
