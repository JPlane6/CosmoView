import Foundation

class APODViewModel: ObservableObject {
    private let service = NASAService()
    @Published var apod: APOD?

    func loadAPOD() {
        service.fetchAPOD { [weak self] result in
            DispatchQueue.main.async {
                self?.apod = result
            }
        }
    }
}
