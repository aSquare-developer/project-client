import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var model: DroppieModel
    @EnvironmentObject private var appState: AppState
    
    private func fetchRouteObjects() async {
        do {
            try await model.getAllRoutesByUser()
        } catch {
            appState.errorWrapper = ErrorWrapper(error: DroppieError.fetchingError, guidance: "Something wrong with fetching data")
        }
    }
    
    var body: some View {
        List(model.routesList) { route in
            VStack(alignment: .leading) {
                Text("Origin: \(route.origin)")
                    .font(.headline)
                Text("Destination: \(route.destination)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Description: \(route.description)")
                    .font(.body)
                    .foregroundColor(.blue)
                Text("Speedometer Start: \(String(format: "%.2f", route.speedometerStart))")
                    .font(.body)
                    .foregroundColor(.green)
                Text("Speedometer End: \(String(format: "%.2f", route.speedometerEnd))")
                    .font(.body)
                    .foregroundColor(.green)
                Text("Distance: \(String(format: "%.0f", route.distance)) meters")
                    .font(.body)
                    .foregroundColor(.orange)
                Text("Date: \(route.date.formatted())")
                    .font(.body)
                Text("Created At: \(route.createdAt.formatted())")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text("Updated At: \(route.updatedAt.formatted())")
                    .font(.body)
                    .foregroundColor(.secondary)
                Divider()
            }
            .padding(.vertical, 10)
            
        }.task {
            await fetchRouteObjects()
        }
        .navigationTitle("Route List")
        .sheet(item: $appState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.fraction(0.35)])
        }
    }
    
}

#Preview {
    NavigationStack {
        HistoryView()
            .environmentObject(DroppieModel())
    }
}
