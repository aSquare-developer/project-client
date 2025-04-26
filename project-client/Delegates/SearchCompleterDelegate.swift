import Foundation
import MapKit

class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    var onUpdate: ([MKLocalSearchCompletion]) -> Void = { _ in }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        onUpdate(completer.results)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Обработка ошибки
        if let mkError = error as? MKError {
            switch mkError.code {
            case .unknown:
                print("Неизвестная ошибка поиска.")
            case .serverFailure:
                print("Ошибка сервера при поиске.")
            default:
                print("Ошибка поиска: \(error.localizedDescription)")
            }
        } else {
            print("Ошибка поиска: \(error.localizedDescription)")
        }
        onUpdate([])  // Возвращаем пустой список при ошибке
    }
}
