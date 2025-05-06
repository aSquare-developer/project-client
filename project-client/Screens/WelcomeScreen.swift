import SwiftUI

final class LoaderFlag {
    var value: Bool
    init(_ value: Bool) {
        self.value = value
    }
}

struct WelcomeScreen: View {
    
    @EnvironmentObject private var model: DroppieModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var isValidForm: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func loginTapped() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)

            if loginResponseDTO.error {
                appState.errorWrapper = ErrorWrapper(
                    error: DroppieError.login,
                    guidance: loginResponseDTO.reason ?? "")
            } else {
                appState.routes.append(.main)
            }
        } catch {
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
    }

    private func registerTapped() async {
        if !isValidForm {
            appState.errorWrapper = ErrorWrapper(error: DroppieError.fieldsIsInvalid, guidance: "To register, you must fill in the fields")
            return
        }
        
        do {
            let registerResponseDTO = try await model.register(username: username, password: password)

            if registerResponseDTO.error {
                appState.errorWrapper = ErrorWrapper(error: DroppieError.register, guidance: registerResponseDTO.reason ?? "")
            } else {
                await loginTapped()
            }
        } catch {
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
    }

    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 16) {
                    TextField("Login", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 16) {
                    Button(action: {
                        Task {
                            await loginTapped()
                        }
                    }) {
                        Text("Login")
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
                            .opacity(isValidForm ? 1 : 0.6)
                    }
                    .padding(.horizontal)
                    .disabled(!isValidForm)
                    
                    Button(action: {
                        Task {
                            await registerTapped()
                        }
                    }) {
                        Text("Registration")
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
                    .padding(.horizontal)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(item: $appState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.fraction(0.35)])
        }
    }
}

struct WelcomeScreenContainer: View {
    
    @StateObject private var model = DroppieModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            WelcomeScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        WelcomeScreen()
                    case .register:
                        WelcomeScreen()
                    case .main:
                        Main()
                    }
                }
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}

#Preview {
    WelcomeScreenContainer()
}
