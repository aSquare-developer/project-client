import Foundation
import MapKit

class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    var onUpdate: ([MKLocalSearchCompletion]) -> Void = { _ in }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        onUpdate(completer.results)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Ошибка поиска: \(error.localizedDescription)")
        onUpdate([])
    }
}
