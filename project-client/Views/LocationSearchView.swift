import SwiftUI
import MapKit

struct LocationSearchView: View {
    
    @Binding var selectedAddress: String
    @State private var query: String = ""
    @State private var results: [MKLocalSearchCompletion] = []
    @FocusState private var isTextFieldFocused: Bool
    @State private var isSelecting: Bool = false
    
    @StateObject private var locationManager = LocationManager()

    private let completer = MKLocalSearchCompleter()
    private let searchDelegate = SearchCompleterDelegate()
    
    var body: some View {
        
        VStack {
            TextField("Введите адрес", text: $query)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .transition(.move(edge: .top).combined(with: .opacity))
                .focused($isTextFieldFocused)
                .onChange(of: query) {
                    if !isSelecting {
                        completer.queryFragment = query
                    }
                }
            
            if isTextFieldFocused && !results.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(results, id: \.self) { result in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(result.title)
                                    .font(.body)
                                Text(result.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .contentShape(Rectangle()) // Расширяет область нажатия
                            .onTapGesture {
                                selectAddress(result)
                            }
                            
                            Divider()
                        }
                    }
                }
                .frame(maxHeight: 200)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            
        }
        .onAppear {
            completer.delegate = searchDelegate
            searchDelegate.onUpdate = { completions in
                withAnimation(.spring(duration: 1)) {
                    self.results = Array(completions.prefix(3))
                }
            }
        }
        .onReceive(locationManager.$currentLocation.compactMap { $0 }) { location in
            completer.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }

        
    }
    
    private func selectAddress(_ completion: MKLocalSearchCompletion) {
        
        isSelecting = true
        
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)

        search.start { response, error in
            guard let placemark = response?.mapItems.first?.placemark else { return }

            selectedAddress = formatAddress(from: placemark)
            query = selectedAddress
            
            
            withAnimation(.spring(duration: 1)) {
                results = []
                
                // Закрываем клавиатуру и снимаем фокус
                isTextFieldFocused = false
            }
            

            // Вернём isSelecting в false после задержки, чтобы избежать скачка
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isSelecting = false
            }
        }
    }
    
    private func formatAddress(from placemark: MKPlacemark) -> String {
        var components: [String] = []

        if let street = placemark.thoroughfare {
            var line = street
            if let number = placemark.subThoroughfare {
                line += " \(number)"
            }
            components.append(line)
        }

        if let postalCode = placemark.postalCode {
            components.append(postalCode)
        }

        if let city = placemark.locality {
            components.append(city)
        }

        return components.joined(separator: ", ")
    }
}

#Preview {
    LocationSearchView(selectedAddress: .constant(""))
}
