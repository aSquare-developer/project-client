import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var model: DroppieModel
    @EnvironmentObject private var appState: AppState
    
    @State private var origin = ""
    @State private var destination = ""
    @State private var selectedDate: Date = Date()
    
    var isValidForm: Bool {
        !origin.isEmptyOrWhitespace && !destination.isEmptyOrWhitespace
    }
    
    private func saveRoute() async {
        let routeRequestDTO = RouteRequestDTO(origin: origin, destination: destination, date: selectedDate)
        
        do {
            let routeResponseDTO = try await model.saveRoute(routeRequestDTO)
            
            if routeResponseDTO.error {
                appState.errorWrapper = ErrorWrapper(error: DroppieError.saveRouteError,
                                                     guidance: routeResponseDTO.reason ?? "")
            } else {
                origin = ""
                destination = ""
                selectedDate = Date()
                appState.notificationWrapper = NotificationWrapper(message: "Your Route successfully added!")
            }
        } catch {
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
        
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 10) {
                // Секция "Начальной точкой"
                LocationSearchView(selectedAddress: $origin)
                    .id("origin")
                
                // Секция "Конечной точкой"
                LocationSearchView(selectedAddress: $destination)
                    .id("destination")
                
                // Секция "Дата маршрута"
                HStack {
                    DatePicker("Дата маршрута", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    Button(action: {
                        selectedDate = Date()
                    }) {
                        Image(systemName: "calendar")
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                Task {
                    await saveRoute()
                }
            }) {
                Text("Добавить маршрут")
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
            .disabled(!isValidForm)
            .padding()
            
        }
        .sheet(item: $appState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.fraction(0.35)])
        }
        .sheet(item: $appState.notificationWrapper) { notificationWrapper in
            NotificationView(notificationWrapper: notificationWrapper, type: .success)
                .presentationDetents([.fraction(0.35)])
        }
    }
}


#Preview {
    MainView()
        .environmentObject(DroppieModel())
        .environmentObject(AppState())
}
