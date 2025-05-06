import SwiftUI

enum SampleError: Error {
    case operationFailed
}

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)

            Text("Error has occured in the application.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(errorWrapper.guidance)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

#Preview {
    ErrorView(errorWrapper: ErrorWrapper(error: SampleError.operationFailed, guidance: "Operation has failed. Please try again later."))
}
