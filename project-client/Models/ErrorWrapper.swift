import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    
    /*
     Meaning this is a string property
     telling us what we should do in case of an error.
     */
    let guidance: String
}
